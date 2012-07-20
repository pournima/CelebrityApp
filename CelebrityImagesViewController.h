//
//  CelebrityImagesViewController.h
//  CelebrityApp
//
//  Created by nachi on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonLoadingView.h"

@interface CelebrityImagesViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
    
    NSUserDefaults *standardUserDefaults;
    NSString *responseJSONString;
    NSMutableArray *facebookImageArray;
    NSMutableArray *retrivedFfacebookImageArray;
    
    IBOutlet UITableView *tblView;
    IBOutlet UITableViewCell *tableCell; 
    IBOutlet UIImageView *imageView;
    CommonLoadingView *commonLoadingView;
    
}

@property (retain,nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UITableView *tblView;
@property (nonatomic,retain) IBOutlet UITableViewCell *tableCell;
@property (nonatomic,retain) CommonLoadingView *commonLoadingView;

@end
