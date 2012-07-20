//
//  CommonLoadingView.m
//  Checkin iOS
//
//  Created by bhuvan khanna on 13/02/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import "CommonLoadingView.h"
#import "constants.h"


@implementation CommonLoadingView
@synthesize loadingView,activityIndicator,loadingMessage;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


    // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)showProgressDialog:(NSString*)message {
    // Add curved border
    self.loadingView.layer.cornerRadius = 8.0;
	self.loadingView.layer.borderColor = [[UIColor whiteColor] CGColor];
	self.loadingView.layer.borderWidth = 2;
    // Add drop shadow
    self.loadingView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.loadingView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    self.loadingView.layer.shadowOpacity = 0.25;
    [activityIndicator startAnimating];
    loadingMessage.backgroundColor = [UIColor clearColor];
    loadingMessage.text = message;
    loadingMessage.textColor = [UIColor whiteColor];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
        // Overriden to allow any orientation.
    return NO;
}


- (void)didReceiveMemoryWarning {
        // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
        // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    [activityIndicator stopAnimating];
        // Release any retained subviews of the main view.
        // e.g. self.myOutlet = nil;
}


/*- (void)dealloc {
	
	[loadingView release];
    [activityIndicator release];
    [super dealloc];
}*/


@end