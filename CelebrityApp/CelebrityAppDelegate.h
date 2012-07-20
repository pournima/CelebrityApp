//
//  CelebrityAppDelegate.h
//  CelebrityApp
//
//  Created by nachi on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "TwitterShare.h"

@class CelebrityViewController;

@interface CelebrityAppDelegate :NSObject<FBSessionDelegate,FBRequestDelegate,FBDialogDelegate,FBLoginDialogDelegate,UITabBarControllerDelegate,UIApplicationDelegate,UINavigationBarDelegate>
{
    BOOL applicationResuming;
    Facebook *facebook;
    TwitterShare *twitter;
    IBOutlet UIWindow *window;
    IBOutlet UITabBarController *mCheckinTabBarController;
}

@property (nonatomic) BOOL applicationResuming;
@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain) TwitterShare *twitter;
@property (strong, nonatomic) IBOutlet UIWindow *window;

@property (strong, nonatomic) CelebrityViewController *viewController;
@property (retain, nonatomic) IBOutlet UITabBarController *mCheckinTabBarController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end
