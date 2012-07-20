//
//  CelebrityViewController.h
//  CelebrityApp
//
//  Created by nachi on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppStatus.h"
#import "SA_OAuthTwitterEngine.h"
#import "SA_OAuthTwitterController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "FBConnect.h"
#import "SharedPrefResult.h"

@interface CelebrityViewController : UIViewController<UITextFieldDelegate,ASIHTTPRequestDelegate,FBSessionDelegate,FBRequestDelegate,FBDialogDelegate,SA_OAuthTwitterControllerDelegate>
{
    IBOutlet UIButton *btnFaceBook;
    IBOutlet UIButton *btnTwitter;
    
    NSString *socialSigninType;
    NSArray *permissions;
    NSString *facebook_UID;
    NSString *facebook_FirstName;
    NSString *facebook_LastName;
    NSString *facebook_access_token;
    NSString *facebook_Email;
    NSString *jsonString;
    NSString *Facebook_access_token;
    AppStatus *appStatus;
    
    SA_OAuthTwitterEngine *_engine;
    UIActivityIndicatorView *busyIndicator;
    
    NSMutableArray *tweetsDataArray;
    

}


@property (retain, nonatomic) IBOutlet UIButton *btnFaceBook;
@property (retain, nonatomic) IBOutlet UIButton *btnTwitter;

- (IBAction)btnFacebookClick:(id)sender;
- (IBAction)btnTwitterClick:(id)sender;

@end
