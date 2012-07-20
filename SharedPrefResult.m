//
//  SharedPrefResult.m
//  Checkin iOS
//
//  Created by bhuvan khanna on 14/02/12.
//  Copyright (c) 2012 webonise software solutions pvt ltd. All rights reserved.
//

#import "SharedPrefResult.h"

@implementation SharedPrefResult

@synthesize existFB,access_tokenFB,activeFB,access_secretFB,existTW,activeTW,access_tokenTW,access_secretTW;

+(SharedPrefResult *) fromJson:(NSString *)jsonString {
    NSDictionary *sharedPrefs = [jsonString JSONValue];
    
        SharedPrefResult *result = [SharedPrefResult new];
        NSDictionary *facebook_social_preference = [sharedPrefs objectForKey:@"facebook_social_preference"];
        result.existFB =[[facebook_social_preference objectForKey:@"exist"]boolValue];
        result.access_tokenFB = [facebook_social_preference objectForKey:@"access_token"];
        result.access_secretFB = [facebook_social_preference objectForKey:@"access_secret"];
        result.activeFB = [[facebook_social_preference objectForKey:@"active"]boolValue];
        
        NSDictionary *twitter_social_preference = [sharedPrefs objectForKey:@"twitter_social_preference"];
        result.existTW = [[twitter_social_preference objectForKey:@"exist"]boolValue];
        result.access_tokenTW = [twitter_social_preference objectForKey:@"access_token"];
        result.access_secretTW = [twitter_social_preference objectForKey:@"access_secret"];
        result.activeTW = [[twitter_social_preference objectForKey:@"active"]boolValue];
     
    return result;
}

/*-(void)dealloc {
    [access_secretFB release];
    [access_secretTW release];
    [access_tokenFB release];
    [access_tokenTW release];
    [super dealloc];
}*/

@end
