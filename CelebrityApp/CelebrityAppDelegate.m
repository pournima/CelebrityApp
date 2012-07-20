//
//  CelebrityAppDelegate.m
//  CelebrityApp
//
//  Created by nachi on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CelebrityAppDelegate.h"
//#import "CelebrityViewController.h"
#import "Constants.h"

@implementation CelebrityAppDelegate
@synthesize applicationResuming,facebook;
@synthesize mCheckinTabBarController;

@synthesize window = _window;
@synthesize viewController = _viewController;

@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

static NSString* kAppId =@"342624499147202";

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
 //   self.viewController = [[[CelebrityViewController alloc] initWithNibName:@"CelebrityViewController" bundle:nil] autorelease];
 //   self.window.rootViewController = self.viewController;

    mCheckinTabBarController.delegate=self;
    [self.window setRootViewController:mCheckinTabBarController];
    [window addSubview:mCheckinTabBarController.view];  
    
    [self.window makeKeyAndVisible];

    facebook = [[Facebook alloc] initWithAppId:kAppId andDelegate:self];
    
    // Check and retrieve authorization information
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    return YES;
    
}

- (void) tabBarController: (UITabBarController *) tabBarController didSelectViewController: (UIViewController *) viewController 
{
    UIView *child = [viewController.view viewWithTag:CHILD_CONTROLLER_TAG];
    
    if ( child != nil ) {
        UIViewController *controller = (UIViewController *)[child nextResponder];
        
        if ( controller != nil ) {
            
            [controller.navigationController popToRootViewControllerAnimated:YES];
            
        }
    } 
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)fbDidLogin {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FBDidLoginCalled" object:nil];
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [self.facebook handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotatio
{
    return [self.facebook handleOpenURL:url];
}



#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
-(BOOL) contactWebView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    return YES;
}


@end
