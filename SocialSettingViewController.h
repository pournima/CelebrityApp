//
//  SocialSettingViewController.h
//  CelebrityApp
//
//  Created by nachi on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CelebrityHomeViewController.h"

@interface SocialSettingViewController : UIViewController{
    
    IBOutlet UISwitch *switchFacebook;  
    IBOutlet UISwitch *switchTwitter;
    
    NSString *strFacebook;
    NSString *strTwitter;
    
    NSString *isFBKeyPresent;
    NSString *isTWKeyPresent;
    
    NSString *facebookAuthkey;
    NSString *twitterAuthKey;
    CelebrityHomeViewController * celebrityHomeViewController;
}

-(IBAction)setFacebookStatus:(id)sender;
-(IBAction)setTwitterStatus:(id)sender;

@property (nonatomic, retain) UISwitch *switchFacebook;
@property (nonatomic, retain) UISwitch *switchTwitter;
@property (nonatomic, retain) CelebrityHomeViewController * celebrityHomeViewController;
 
@end
