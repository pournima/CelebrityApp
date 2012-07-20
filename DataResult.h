//
//  DataResult.h
//  POLS3
//
//  Created by nachi on 04/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataResult : NSObject
{
    NSString *strId;
    NSString *strImage;
    
    NSString *strFeeds;
    NSString *strFacebookSocial;
}

@property (retain,nonatomic) NSString *strId;
@property (retain,nonatomic) NSString *strImage;
@property (retain,nonatomic) NSString *strFeeds;
@property (retain,nonatomic) NSString *strFacebookSocial;

+ (NSMutableArray *) parseFacebookImage:(NSString *) strImageResponse;
+ (NSMutableArray *) parseFacebookFeeds:(NSString *) strFeedsResponse;
+ (NSMutableArray *) parseTwitterTweets:(NSString *) strTweetsResponse;

@end
