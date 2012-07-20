//
//  SharedPrefResult.h
//  Checkin iOS
//
//  Created by bhuvan khanna on 14/02/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"

@interface SharedPrefResult : NSObject {
    BOOL existFB;
    NSString *access_tokenFB;
    NSString *access_secretFB;
    BOOL activeFB;
    
    BOOL existTW;
    NSString *access_tokenTW;
    NSString *access_secretTW;
    BOOL activeTW;
}

@property(nonatomic) BOOL existFB;
@property(nonatomic,retain) NSString *access_tokenFB;
@property(nonatomic,retain) NSString *access_secretFB;
@property(nonatomic) BOOL activeFB;
@property(nonatomic) BOOL existTW;
@property(nonatomic,retain) NSString *access_tokenTW;
@property(nonatomic,retain) NSString *access_secretTW;
@property(nonatomic) BOOL activeTW;

+(SharedPrefResult *) fromJson:(NSString *)jsonString;

@end
