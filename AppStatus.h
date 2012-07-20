//
//  AppStatus.h
//  Checkin iOS
//
//  Created by bhuvan khanna on 08/12/11.
//  Copyright (c) 2011 webonise software solutions pvt ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#include <netinet/in.h> 

@interface AppStatus : NSObject {
    NSString *path;
    NSString *apiKey;
}

    -(NSString*)getPath;
    -(BOOL)isAppOnline;
    -(NSString*)readApiKey;
    -(void)saveApiKey:(NSString*)apiKey1;
    -(BOOL)isAppResistered;
    -(NSString *) getApiKey;
    -(void)setApiKey:(NSString*)apiKey1;
    -(void)removeAuthCode;

-(void)saveShareStatus:(NSString *)key withArg2:(NSString*)value;
-(NSString *)getShareStatus:(NSString*)key;


@end
