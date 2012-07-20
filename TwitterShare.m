//
//  TwitterShare.m
//  Checkin iOS
//
//  Created by Bhuvan Khanna on 25/06/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import "TwitterShare.h"
#import "Constants.h"
#import "TWSignedRequest.h"
#import <Twitter/Twitter.h>
#import "CelebrityViewController.h"

@implementation TwitterShare 
@synthesize accountStore;
@synthesize celebrityViewController;

-(void)performTwitterAuthentication 
{
    //  Check to make sure that the user has added his credentials
    //  Check to make sure that the user has added his credentials
    if ([self _checkForKeys] && [self _checkForLocalCredentials]) 
    {
        //
        //  Step 1)  Ask Twitter for a special request_token for reverse auth
        //
        NSURL *url = [NSURL URLWithString:TW_OAUTH_URL_REQUEST_TOKEN];
        
        // "reverse_auth" is a required parameter
        NSDictionary *dict = [NSDictionary dictionaryWithObject:TW_X_AUTH_MODE_REVERSE_AUTH forKey:TW_X_AUTH_MODE_KEY];
        TWSignedRequest *signedRequest = [[[TWSignedRequest alloc] initWithURL:url parameters:dict requestMethod:TWSignedRequestMethodPOST]autorelease];
        
        [signedRequest performRequestWithHandler:^(NSData *data, NSURLResponse *response, NSError *error) 
        {
            if (!data) {
                //[self showAlert:@"Unable to receive a request_token." title:@"Yikes"];
                [self _handleError:error forResponse:response];
            }
            else {
                NSString *signedReverseAuthSignature = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]autorelease];
                
                //
                //  Step 2)  Ask Twitter for the user's auth token and secret
                //           include x_reverse_auth_target=CK2 and x_reverse_auth_parameters=signedReverseAuthSignature parameters
                //
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSDictionary *step2Params = [NSDictionary dictionaryWithObjectsAndKeys:[TWSignedRequest consumerKey], TW_X_AUTH_REVERSE_TARGET, signedReverseAuthSignature, TW_X_AUTH_REVERSE_PARMS, nil];
                    NSURL *authTokenURL = [NSURL URLWithString:TW_OAUTH_URL_AUTH_TOKEN];
                    TWRequest *step2Request = [[TWRequest alloc] initWithURL:authTokenURL parameters:step2Params requestMethod:TWRequestMethodPOST];
                    
                    //  Obtain the user's permission to access the store
                    //
                    //  NB: You *MUST* keep the ACAccountStore around for as long as you need an ACAccount around.  See WWDC 2011 Session 124 for more info.
                    self.accountStore = [[ACAccountStore alloc] init];
                    ACAccountType *twitterType = [self.accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
                    
                    [self.accountStore requestAccessToAccountsWithType:twitterType withCompletionHandler:^(BOOL granted, NSError *error) {
                        if (!granted) {
                            // [self showAlert:@"User rejected access to his/her account." title:@"Yikes"];
                        }
                        else {
                            // obtain all the local account instances
                            NSArray *accounts = [self.accountStore accountsWithAccountType:twitterType];
                            
                            // we can assume that we have at least one account thanks to +[TWTweetComposeViewController canSendTweet], let's return it
                            [step2Request setAccount:[accounts objectAtIndex:0]];
                            [step2Request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                if (!responseData) {
                                    // [self showAlert:@"Error occurred in Step 2.  Check console for more info." title:@"Yikes"];
                                    [self _handleError:error forResponse:response];
                                }
                                else {
                                    NSString *responseStr = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]autorelease];
                                    [self _handleStep2Response:responseStr];
                                }
                            }];
                        }
                    }];
                });
            }
        }];
    }
}

- (BOOL)_checkForKeys
{
    BOOL resp = YES;
    
    if (![TWSignedRequest consumerKey] || ![TWSignedRequest consumerSecret]) {
        
        resp = NO;
    }
    
    return resp;
}

- (BOOL)_checkForLocalCredentials
{
    BOOL resp = YES;
    if (![TWTweetComposeViewController canSendTweet]) 
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Configure Twitter" message:@"To set up Twitter sharing, you need to configure a Twitter account in your iPhone settings.  Hit the home button and navigate to Settings to update this value." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        resp = NO;
    }
    
    return resp;
}

- (void)_handleError:(NSError *)error forResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *urlResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"[Step Two Request Error]: %@", [error localizedDescription]);
    NSLog(@"[Step Two Request Error]: Response Code:%d \"%@\" ", [urlResponse statusCode], [NSHTTPURLResponse localizedStringForStatusCode:[urlResponse statusCode]]);
}

#define RESPONSE_EXPECTED_SIZE 4
- (void)_handleStep2Response:(NSString *)responseStr
{
    NSDictionary *dict = [NSURL ab_parseURLQueryString:responseStr];
    if ([dict count] == RESPONSE_EXPECTED_SIZE) {
        //[self showAlert:[NSString stringWithFormat:@"User: %@\nUser ID: %@", [dict objectForKey:TW_SCREEN_NAME], [dict objectForKey:TW_USER_ID]] title:@"Success!"];
        NSLog(@"The user's info for your server:\n%@", dict);
        oauth_token = [dict objectForKey:TW_OAUTH_TOKEN];
        oauth_secret = [dict objectForKey:TW_OAUTH_SECRET];
        screeen_name = [dict objectForKey:TW_SCREEN_NAME];
        user_id = [dict objectForKey:TW_USER_ID];
        
        [self returnTwitterCredentials];
    } 
    else 
    {
        //[self showAlert:@"The response doesn't seem correct.  Please check the console." title:@"Hmm..."];
        NSLog(@"The user's info for your server:\n%@", dict);
    }
}

-(void) returnTwitterCredentials
{
    [[NSUserDefaults standardUserDefaults] setValue:oauth_token forKey:@"AUTHTOKEN"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:oauth_secret forKey:@"AUTHSECRET"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:screeen_name forKey:@"SCREENNAME"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setValue:user_id forKey:@"USERID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"Twitter Response: %@ \n %@ \n %@ \n %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"AUTHTOKEN"], [[NSUserDefaults standardUserDefaults] valueForKey:@"AUTHSECRET"], [[NSUserDefaults standardUserDefaults] valueForKey:@"SCREENNAME"], [[NSUserDefaults standardUserDefaults] valueForKey:@"USERID"]);
    [celebrityViewController onTwResponse];  // Call to method in CelebrityViewController
   
}


-(void) dealloc
{
    [accountStore release];
    [super dealloc];
}

@end
