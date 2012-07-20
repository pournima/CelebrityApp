//
//  CommonLoadingView.h
//  Checkin iOS
//
//  Created by bhuvan khanna on 13/02/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface CommonLoadingView : UIViewController {
    
	UIView * loadingView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextView *loadingMessage;
}

@property (nonatomic,retain) IBOutlet UIView * loadingView;
@property (nonatomic,retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic,retain) IBOutlet UITextView *loadingMessage;

-(void)showProgressDialog:(NSString*)message;

@end