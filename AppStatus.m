//
//  AppStatus.m
//  Checkin iOS
//
//  Created by bhuvan khanna on 08/12/11.
//  Copyright (c) 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import "AppStatus.h"
#import "Reachability.h"

@implementation AppStatus

- (id)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

-(NSString*)getPath {
    
    NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentFolder = [documentPath objectAtIndex:0];
    return documentFolder;
}

-(BOOL)isAppOnline {

    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
	
        // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
	
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
   /* Reachability *r = [Reachability reachabilityWithHostname:@"www.google.com"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	if ((internetStatus != ReachableViaWiFi) && (internetStatus != ReachableViaWWAN)) {
        return 0;
    }*/
	
    if (!didRetrieveFlags)
        {
        printf("Error. Could not recover network reachability flags\n");
        return 0;
        }
	
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}

-(NSString*)readApiKey {
    path = [[self getPath] stringByAppendingPathComponent:@"checkinSettings.plist"];
    
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    apiKey=[dict valueForKey:@"api_key"];
    NSLog(@"*********api_key %@ from plist at path %@",apiKey, path);
    
    return apiKey;
}

-(void)saveApiKey:(NSString*)mApiKey {
   // mApiKey = apiKey;
   NSLog(@"******* API Key = %@",mApiKey);
    
    path = [[self getPath] stringByAppendingPathComponent:@"checkinSettings.plist"];
 //   [path retain];
    NSLog(@"******path = %@",path);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ( ![fileManager fileExistsAtPath:path] ) {
    
    NSString *bundleFile = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
    
    [[NSFileManager defaultManager]copyItemAtPath:bundleFile toPath:path error:nil];
    }    
    
    NSMutableDictionary *addData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [addData setObject:mApiKey forKey:@"api_key"];
    
    [addData writeToFile:path atomically:YES]; 
    
}

-(BOOL)isAppResistered {
    
    if(apiKey==NULL) {
        return NO;
    }
    return YES;
}

/*-(NSString *) getApiKey {
    
    apiKey=[self readApiKey];
    return apiKey;
}*/

-(NSString *) getApiKey {
    
    apiKey=[[NSUserDefaults standardUserDefaults] valueForKey:@"api_key"]; 
    return apiKey;
}

-(void)setApiKey:(NSString*)mApiKey {
    
    apiKey=mApiKey;
    [self saveApiKey:mApiKey];
}

-(void)removeAuthCode
{
    
}

-(void)saveShareStatus:(NSString *)key withArg2:(NSString *)value{
 
    path = [[self getPath] stringByAppendingPathComponent:@"checkinSettings.plist"];
       
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ( ![fileManager fileExistsAtPath:path] ) {
        
        NSString *bundleFile = [[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"];
        
        [[NSFileManager defaultManager]copyItemAtPath:bundleFile toPath:path error:nil];
    }    
    
    NSMutableDictionary *addData = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    [addData setObject:value forKey:key];
    
    [addData writeToFile:path atomically:YES]; 

}

-(NSString *)getShareStatus : (NSString*)key{
    NSString *status;
    path = [[self getPath] stringByAppendingPathComponent:@"checkinSettings.plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];    
    status=[dict valueForKey:key];
    NSLog(@"*********** %@",status);
    
    return status;
}

/*- (void)dealloc {
    [super dealloc];
}*/

@end
