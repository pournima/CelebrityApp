//
//  DataResult.m
//  POLS3
//
//  Created by nachi on 04/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataResult.h"
#import "SBJson.h"
#import "JSON.h"
@implementation DataResult
@synthesize strId,strImage,strFeeds,strFacebookSocial;

-(void)dealloc
{
    [super dealloc];

}


+ (NSMutableArray *) parseFacebookImage:(NSString *) strImageResponse
{

    //NSLog(@"response %@",strImageResponse);
    NSMutableArray *facebookValue=[[NSMutableArray alloc]init];
    
    NSArray *facebookImageData=[strImageResponse JSONValue];
    
    //NSLog(@"response array %@",facebookImageData);
    NSMutableArray *data=[facebookImageData valueForKey:@"data"];
    //NSLog(@"data -- %@",data);
    
    for (int i=1; i<[data count]; i++) 
    {
        DataResult *imageResult=[[DataResult alloc]init];
        
        NSDictionary *imageDictionary=[data objectAtIndex:i];
        
        imageResult.strId=[imageDictionary valueForKey:@"id"];
        imageResult.strImage=[imageDictionary valueForKey:@"picture"];
        
        [facebookValue addObject:imageResult];
        [imageResult release];
    }
    return facebookValue;    
}



+ (NSMutableArray *) parseFacebookFeeds:(NSString *) strFeedsResponse
{
    
    //NSLog(@"response %@",strImageResponse);
    NSMutableArray *facebookValue=[[NSMutableArray alloc]init];
    
    NSArray *facebookFeedsData=[strFeedsResponse JSONValue];
    
    //NSLog(@"response array %@",facebookImageData);
    NSMutableArray *data=[facebookFeedsData valueForKey:@"data"];
    NSLog(@"data -- %@",data);
    
    for (int i=1; i<[data count]; i++) 
    {
        DataResult *feedsResult=[[DataResult alloc]init];
        
        NSDictionary *feedsDictionary=[data objectAtIndex:i];
        
        feedsResult.strFeeds=[feedsDictionary valueForKey:@"message"];
        if(feedsResult.strFeeds){
            feedsResult.strFacebookSocial=@"true";
            [facebookValue addObject:feedsResult];
            [feedsResult release];
        }

    }
    return facebookValue;    
}


+ (NSMutableArray *) parseTwitterTweets:(NSString *) strTweetsResponse
{
    
    NSMutableArray *twitterValue=[[NSMutableArray alloc]init];
    
    NSArray *twitterTweetsData=[strTweetsResponse JSONValue];
    
    NSLog(@"response array %@",twitterTweetsData);
    
    NSMutableArray *data=[twitterTweetsData valueForKey:@"results"];
    NSLog(@"Twitter data -- %@",data);
    
    for (int i=1; i<[data count]; i++) 
    {
        DataResult *feedsResult=[[DataResult alloc]init];
        
        NSDictionary *feedsDictionary=[data objectAtIndex:i];
        
        feedsResult.strFeeds=[feedsDictionary valueForKey:@"text"];
        if(feedsResult.strFeeds){
            feedsResult.strFacebookSocial=@"false";
            [twitterValue addObject:feedsResult];
            [feedsResult release];
        }
    }
    return twitterValue;    
}
@end
