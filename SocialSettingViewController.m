//
//  SocialSettingViewController.m
//  CelebrityApp
//
//  Created by nachi on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SocialSettingViewController.h"


@implementation SocialSettingViewController
@synthesize switchFacebook,switchTwitter,celebrityHomeViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Social Settings";
    
     celebrityHomeViewController=[[CelebrityHomeViewController alloc]initWithNibName:@"CelebrityHomeViewController" bundle:nil];

    facebookAuthkey=[[NSUserDefaults standardUserDefaults] objectForKey:@"FBAuthToken"];
    twitterAuthKey=[[NSUserDefaults standardUserDefaults] objectForKey:@"TWAUTHKEY"];
    
    //---Facebook
    isFBKeyPresent =[[NSUserDefaults standardUserDefaults] objectForKey:@"isActiveFB"];
    if([isFBKeyPresent isEqualToString:@"YES"]){
        [self.switchFacebook setOn:YES animated:YES];
        strFacebook=@"YES";
    }else {
        [self.switchFacebook setOn:NO animated:YES];
        strFacebook=@"NO";
    }
    
    //---Twitter
    isTWKeyPresent =[[NSUserDefaults standardUserDefaults] objectForKey:@"isActiveTW"];
    if([isTWKeyPresent isEqualToString:@"YES"]){
        [self.switchTwitter setOn:YES animated:YES];
        strTwitter=@"YES";
    }else {
        [self.switchTwitter setOn:NO animated:YES];
        strTwitter=@"NO";
    }

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)setFacebookStatus:(id)sender
{
    isFBKeyPresent =[[NSUserDefaults standardUserDefaults] objectForKey:@"isActiveFB"];
    if([strFacebook isEqualToString:@"YES"]){
        //[self.switchFacebook setOn:YES animated:YES];
            if([isFBKeyPresent isEqualToString:@"NO"]){
               if ([facebookAuthkey length]==0) { 
                [self presentModalViewController:celebrityHomeViewController animated:NO];
               }
            }
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"isActiveFB"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        strFacebook=@"NO";
    }else {
       // [self.switchFacebook setOn:NO animated:YES];
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isActiveFB"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        strFacebook=@"YES";
    }
    
}

- (IBAction)setTwitterStatus:(id)sender
{
   isTWKeyPresent =[[NSUserDefaults standardUserDefaults] objectForKey:@"isActiveTW"];
    if([strTwitter isEqualToString:@"YES"]){
        //[self.switchTwitter setOn:YES animated:YES];
            if([isTWKeyPresent isEqualToString:@"NO"]){
                if ([twitterAuthKey length]==0) { 
                [self presentModalViewController:celebrityHomeViewController animated:NO];
                }
            }
        [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"isActiveTW"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        strTwitter=@"NO";
    }else {
        //[self.switchTwitter setOn:NO animated:YES];
        [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"isActiveTW"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        strTwitter=@"YES";
    }
}



-(void)clearCredentials{

    //else{
    //    CelebrityViewController *celebrityViewController =[[CelebrityViewController alloc]initWithNibName:@"CelebrityViewController" bundle:nil];
    //    [self presentModalViewController:celebrityViewController animated:NO];
    //    [celebrityViewController release];
    //    
    //}
    
            //Facebook
            //[appStatus saveShareStatus:@"access_token_FB" withArg2:@""];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"access_token_FB"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isActiveFB"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            //twitter
            // [appStatus saveShareStatus:@"TW_API_KEY" withArg2:@""];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TW_API_KEY"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            // [appStatus saveShareStatus:@"TW_API_SECRET" withArg2:@""];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"TW_API_SECRET"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            // [appStatus saveShareStatus:@"tw_on" withArg2:@"false"];
            [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"tw_on"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            // [appStatus saveShareStatus:@"isActiveTW" withArg2:@"NO"];
            [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isActiveTW"];
            [[NSUserDefaults standardUserDefaults] synchronize];

}

-(void)dealloc{
    [switchFacebook release];
    [switchTwitter release];
    [super dealloc];
}
@end
