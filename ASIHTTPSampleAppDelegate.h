//
//  ASIHTTPSampleAppDelegate.h
//  ASIHTTPSample
//
//  Created by Johan Hernandez on 4/24/11.
//  Copyright 2011 Johan Hernandez<johan@firebase.co>. All rights reserved.
//  Part of ASIHTTP Request Tutorial http://firebase.tumblr.com/post/4901974686/beginner-guide-to-asihttp-and-ios-development
//

#import <UIKit/UIKit.h>

@class ASIHTTPSampleViewController;

@interface ASIHTTPSampleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ASIHTTPSampleViewController *viewController;

@end
