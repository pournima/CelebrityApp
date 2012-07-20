//
//  CelebrityFeedsTweetsViewController.h
//  CelebrityApp
//
//  Created by nachi on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonLoadingView.h"
#import "CelebrityViewController.h"

@class ASINetworkQueue;
@class ASIHTTPRequest;
@class CelebrityHomeViewController;

@interface CelebrityFeedsTweetsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    IBOutlet UITableView *tblView;
    NSMutableArray *tableContents;
    IBOutlet UITableViewCell *tableCell;
    IBOutlet UILabel *lblTableContents;
    IBOutlet UIImage *feedImage;
    
    NSUserDefaults *standardUserDefaults;
    NSString *responseJSONString;
    NSMutableArray *facebookFeedsArray;
    NSMutableArray *tweetsDataArray;
    NSMutableArray *dataArray;
       
    CommonLoadingView *commonLoadingView;
    NSString *flagSocial;
    NSString *auth_key;
    NSString *twitterAuthKey;
    
    NSURL *url;
    
    NSDictionary *facebookInDict;
    NSDictionary *twitterInDict;
    
    ASINetworkQueue *networkQueue;
    //IBOutlet UIActivityIndicatorView *activityView;
    NSString *isFBKeyPresent;
    NSString *isTWKeyPresent;
    
}
- (void)doNetworkOperations;
//- (ASIHTTPRequest *)getFacebookData;
//- (ASIHTTPRequest *)getTwitterData;
-(void)getTwitterData;
-(void)getFacebookData;

@property (retain) ASINetworkQueue *networkQueue;

//@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UITableView *tblView;
@property (nonatomic,retain) NSMutableArray *tableContents;
@property (nonatomic,retain) IBOutlet UITableViewCell *tableCell;
@property (nonatomic,retain) IBOutlet UILabel *lblTableContents;
@property (nonatomic,retain) CommonLoadingView *commonLoadingView;

@property (nonatomic,copy) NSString *facebook;
@property (nonatomic,copy) NSString *twitter;


@end




