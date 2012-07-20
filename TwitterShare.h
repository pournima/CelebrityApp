//
//  TwitterShare.h
//  Checkin iOS
//
//  Created by Bhuvan Khanna on 25/06/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SA_OAuthTwitterController.h"
#import "SA_OAuthTwitterEngine.h"
#import <Accounts/Accounts.h>
#import "CelebrityViewController.h"


@interface TwitterShare : NSObject <SA_OAuthTwitterControllerDelegate>
{
    ACAccountStore *accountStore;
    NSString *oauth_token ;
    NSString *oauth_secret ;
    NSString *screeen_name ;
    NSString *user_id;
    @public
    CelebrityViewController *celebrityViewController;
}


@property (nonatomic, strong) ACAccountStore *accountStore;
@property (nonatomic, strong) CelebrityViewController *celebrityViewController;

-(void)performTwitterAuthentication;
- (BOOL)_checkForKeys;
- (BOOL)_checkForLocalCredentials;
- (void)_handleError:(NSError *)error forResponse:(NSURLResponse *)response;
- (void)_handleStep2Response:(NSString *)responseStr;
-(void) returnTwitterCredentials;

@end
