//
//  CheckIOSVersion.m
//  Checkin iOS
//
//  Created by bhuvan khanna on 09/05/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import "CheckIOSVersion.h"

@implementation CheckIOSVersion

+(BOOL)isGreaterThanOS5 {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0) 
        return YES;
    else 
        return NO;
}

@end
