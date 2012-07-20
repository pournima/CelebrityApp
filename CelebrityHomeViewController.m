//
//  CelebrityHomeViewController.m
//  CelebrityApp
//
//  Created by nachi on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CelebrityHomeViewController.h"
#import "Constants.h"

@interface CelebrityHomeViewController ()

@end

@implementation CelebrityHomeViewController

@synthesize imageView,celebrityViewController;

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
    
    self.navigationItem.title=@"About Celebrity";
    
   // scrollView.contentSize = CGSizeMake(SCROLLVIEW_CONTENT_WIDTH,SCROLLVIEW_CONTENT_HEIGHT);
    
    CGRect myImageRect = CGRectMake(60.0f, 30.0f, 180.0f, 130.0f);
    UIImageView *myImage = [[UIImageView alloc] initWithFrame:myImageRect]; 
    [myImage setImage:[UIImage imageNamed:@"index.jpg"]];
    myImage.opaque = YES; // explicitly opaque for performance 
    [self.view addSubview:myImage]; 

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    celebrityViewController=[[CelebrityViewController alloc]initWithNibName:@"CelebrityViewController" bundle:nil];
    standardUserDefaults = [NSUserDefaults standardUserDefaults];

    NSString *facebookUID=[standardUserDefaults objectForKey:@"FBAuthToken"];
    NSString *twitterAuthKey=[standardUserDefaults objectForKey:@"TWAUTHKEY"];
    
    
   //isFBKeyPresent =[[NSUserDefaults standardUserDefaults] objectForKey:@"isActiveFB"];
    
    if([facebookUID length]==0 || [twitterAuthKey length]==0)
    {
         [self presentModalViewController:celebrityViewController animated:NO];
    }
  
   
    [super viewWillAppear:YES];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc{
    [imageView release];
    [super dealloc];
}
@end
