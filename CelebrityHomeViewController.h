//
//  CelebrityHomeViewController.h
//  CelebrityApp
//
//  Created by nachi on 16/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CelebrityViewController.h"

@interface CelebrityHomeViewController : UIViewController{
    
   
    CelebrityViewController *celebrityViewController;
    
    NSUserDefaults *standardUserDefaults;
    
    IBOutlet UIImageView *imageView;
    
}
@property (retain,nonatomic) IBOutlet UIImageView *imageView;
@property (retain,nonatomic) CelebrityViewController *celebrityViewController;



@end
