//
//  CelebrityViewController.m
//  CelebrityApp
//
//  Created by nachi on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CelebrityViewController.h"
#import "CelebrityAppDelegate.h"
#import "AppStatus.h"
#import "ASIHTTPRequest.h"
#import "TwitterShare.h"
#import "CheckIOSVersion.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "JSON.h"
#import "DataResult.h"
#import "CelebrityHomeViewController.h"

@implementation CelebrityViewController
@synthesize  btnFaceBook,btnTwitter;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //flagAuth=@"true";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    busyIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    busyIndicator.center = self.view.center;
    [self.view addSubview:busyIndicator];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(IBAction)btnTwitterClick:(id)sender{
    
    socialSigninType = @"twitter";
    /*if ([CheckIOSVersion isGreaterThanOS5])
    {
    TwitterShare *twitterShare = [[TwitterShare alloc] init];
    twitterShare.celebrityViewController = self;
    [twitterShare performTwitterAuthentication];
    //[twitterShare release];
   }    
    else 
    {*/
        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
        _engine.consumerKey =  CONSUMER_KEY;
        _engine.consumerSecret = CONSUMER_SECRET;
        
        UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
        
       // [activityIndicator startAnimating];
        if (controller) 
        {
            [self presentModalViewController: controller animated: YES]; 
        }
   // }

}


- (void)onTwResponse
{       
    
    NSString *auth_token = [[NSUserDefaults standardUserDefaults] valueForKey:@"TWAUTHKEY"];
    NSString *auth_secret = [[NSUserDefaults standardUserDefaults] valueForKey:@"TWAUTHSECRET"];
    NSString *screen_name = [[NSUserDefaults standardUserDefaults] valueForKey:@"SCREENNAME"];
    NSString *user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"USERID"];
    if (([auth_token length] != 0) && ([auth_secret length] != 0) && ([screen_name length] != 0) && ([user_id length] != 0)) 
    {

            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"USERID"] length] != 0) 
            {
                if(![AppStatus isAppOnline]) 
                {
                   // [self ShowAlertMsg:ALRT_NO_INTERNET_MSG withArg2:@"Network"];
                    //[self slideInView:signupView toReveal:noInternetView withDuration:0.3];
                }
                else 
                {
                    CelebrityHomeViewController *celebrityHomeViewController =[[CelebrityHomeViewController alloc]initWithNibName:@"CelebrityHomeViewController" bundle:nil];
                    [self presentModalViewController:celebrityHomeViewController animated:NO];
                    [celebrityHomeViewController release];

                }
            }       
    }
    socialSigninType = @"twitter";
    
}


- (IBAction)btnFacebookClick:(id)sender{
    socialSigninType = @"facebook";
    NSLog(@"Login --: %@",socialSigninType);
   
    [self postToFacebook];
}

-(void)postToFacebook 
{

    permissions = [[NSArray alloc] initWithObjects:@"publish_stream",@"offline_access",@"email", nil];
    NSString *isFBKeyPresent = [appStatus getShareStatus:@"isActiveFB"];
    if([isFBKeyPresent isEqualToString:@"YES"]) 
    {
        //[self updateSharedPreferences :apiKey:@"facebook":@"true"];
    }
    else 
    {
        [appStatus saveShareStatus:@"fb_on" withArg2:@"false"];
        CelebrityAppDelegate *delegate = (CelebrityAppDelegate *)[[UIApplication sharedApplication] delegate];
        if (![[delegate facebook] isSessionValid]) 
        {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbDidLoginNotificationFired) name:@"FBDidLoginCalled" object:nil];
            [[delegate facebook] authorize:permissions];
        } 
        else 
        {
            [[delegate facebook] authorize:nil];
        }
    }
}


#pragma mark - ASIHTTP delegate methods

-(void)requestFinished:(ASIHTTPRequest *)requestResponse
{

    jsonString=[requestResponse responseString];
    NSLog(@"JSON Rersponse : %@", jsonString);
    
      if([socialSigninType isEqualToString:@"facebook"])
      {
        NSDictionary *facebookResponseDict = [jsonString JSONValue];
        
        facebook_UID = [facebookResponseDict objectForKey:@"id"];
        facebook_FirstName = [facebookResponseDict objectForKey:@"first_name"];
        facebook_LastName = [facebookResponseDict objectForKey:@"last_name"];
        facebook_Email = [facebookResponseDict objectForKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setValue:facebook_UID forKey:@"FBUID"];
        [[NSUserDefaults standardUserDefaults] setValue:facebook_FirstName forKey:@"FBFirstName"];
        [[NSUserDefaults standardUserDefaults] setValue:facebook_LastName forKey:@"FBLastName"];
        [[NSUserDefaults standardUserDefaults] setValue:facebook_Email forKey:@"FBEmail"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if (([facebook_UID length] != 0) && ([facebook_FirstName length] != 0) && ([facebook_LastName length] != 0) && ([facebook_Email length] !=   0))
        {

            if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"FBUID"] length] != 0) {
                    [self dismissModalViewControllerAnimated:NO];
                    
                   // if(![AppStatus isAppOnline]) 
                  //  {
                      //  [self ShowAlertMsg:@"NoInternetConnectivity" withArg2:@"Network"];
                        //[self slideInView:signupView toReveal:noInternetView withDuration:0.3];
                  //  }
                  //  else 
                  //  {
                     //   [self showLoadingView:@"Sign in... Please wait."];
//                        NSString *urlString = [NSString stringWithFormat:@"%@social_sign_in.json",URL]; 
//
//                        NSURL *url = [[NSURL alloc] initWithString:urlString];
//                        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url:@"POST"];
//                        //   [request setPostValue:APP_ID forKey:APP_ID_KEY];
//                        [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"FBUID"] forKey:@"uid"];
//                        [request setPostValue:socialSigninType forKey:@"social_network"];
//                        [request setDelegate:self];
//                        [request setDidFinishSelector:@selector(requestFinished:)];
//                        [request startAsynchronous];
                 //   }
                }
    
        }
      }
        else if([socialSigninType isEqualToString:@"twitter"])
        {
                tweetsDataArray=[DataResult parseTwitterTweets:jsonString];
                
                NSLog(@"RESPONSE -- %@",tweetsDataArray);
            
        }
        

  //  [self removeLoadingView];
}

-(void)requestFailed:(ASIHTTPRequest *)requestResponse
{
   // [self removeLoadingView];
   // [self ShowAlertMsg:@"Can't connect right now, please try again after some time" withArg2:@""];
}

- (void)fbDidLoginNotificationFired 
{
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"FBDidLoginCalled" object:nil];
    Facebook_access_token = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"access_token_FB"]];
    // NSLog(@"%@",Facebook_access_token);
    //  [appStatus saveShareStatus:@"fb_on" withArg2:@"true"];
    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"fb_on"];
    //  [appStatus saveShareStatus:@"isActiveFB" withArg2:@"YES"];
    [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isActiveFB"];
    [[NSUserDefaults standardUserDefaults] setValue:Facebook_access_token forKey:@"FBAuthToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSString *urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",Facebook_access_token];
    NSURL *URL = [NSURL URLWithString:urlString];
    // [restConnection performRequestGET:[NSURLRequest requestWithURL:URL]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:URL:@"GET"];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestFinished:)];
    [request startAsynchronous];
   // bIsFromFaceBookSignup = true;
   // bIsFromSocialSignup = true;
    socialSigninType = @"facebook";
}

#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {

    [[NSUserDefaults standardUserDefaults] setValue:@"true" forKey:@"tw_on"];
    [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isActiveTW"];
    // NSString *accessToken=[appStatus getShareStatus:@"TW_API_KEY"];
  /*  NSString *accessToken=[[NSUserDefaults standardUserDefaults] valueForKey:@"TW_API_KEY"];
    // NSString *accessSecret=[appStatus getShareStatus:@"TW_API_SECRET"];
    NSString *accessSecret=[[NSUserDefaults standardUserDefaults] valueForKey:@"TW_API_SECRET"];*/
    // [self doSharePreferences:apiKey :@"twitter" :@"true" :accessToken :accessSecret]; 
    
    [[NSUserDefaults standardUserDefaults] valueForKey:@"TWAUTHKEY"];
    [[NSUserDefaults standardUserDefaults] valueForKey:@"TWAUTHSECRET"];
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"SCREENNAME"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
   /* [[NSUserDefaults standardUserDefaults] setValue:accessToken forKey:@"AUTHTOKEN"],
    [[NSUserDefaults standardUserDefaults] setValue:accessSecret forKey:@"AUTHSECRET"],
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:@"SCREENNAME"],
    [[NSUserDefaults standardUserDefaults] synchronize];*/
    socialSigninType = @"twitter";

    
        [self onTwResponse];
//    }
    /*NSString *urlString = [NSString stringWithFormat:@"http://twitter.com/users/show.json?screen_name=%@",username];
     NSURL *url = [NSURL URLWithString:urlString];
     [restConnection performRequestGET:[NSURLRequest requestWithURL:url]];*/
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	//NSLog(@"Authentication Failed!");
    //  isTWOn=NO;
    // [appStatus saveShareStatus:@"tw_on" withArg2:@"false"];
    [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"tw_on"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    // [tableSharing reloadData];
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
    // isTWOn=NO;
    //[appStatus saveShareStatus:@"tw_on" withArg2:@"false"];
    // [tableSharing reloadData];
}

#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
    //[self dismissModalViewControllerAnimated:YES];
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
    // isTWOn=NO;
    // [appStatus saveShareStatus:@"tw_on" withArg2:@"false"];
    [[NSUserDefaults standardUserDefaults] setValue:@"false" forKey:@"tw_on"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    // [tableSharing reloadData];
}

-(void)dealloc{
    [btnFaceBook release];
    [btnTwitter release];
    [super dealloc];
}
@end
