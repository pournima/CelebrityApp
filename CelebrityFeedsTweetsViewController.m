//
//  CelebrityFeedsTweetsViewController.m
//  CelebrityApp
//
//  Created by nachi on 18/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CelebrityFeedsTweetsViewController.h"
#import "ASIFormDataRequest.h"
#import "DataResult.h"
#import "Constants.h"
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"

@implementation CelebrityFeedsTweetsViewController
@synthesize tableCell,tableContents,tblView,commonLoadingView,networkQueue,facebook,twitter,lblTableContents;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    dataArray = [[NSMutableArray alloc] init];

    standardUserDefaults = [NSUserDefaults standardUserDefaults];
    auth_key=[standardUserDefaults objectForKey:@"FBAuthToken"];
    twitterAuthKey=[standardUserDefaults objectForKey:@"TWAUTHKEY"];

    
    //[self doNetworkOperations];
    
     [self setTableView];
     self.navigationItem.title=@"Celebrity Feeds";
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma Progress Dialog Methods

-(void)showLoadingView:(NSString*)message {
    [self performSelector:@selector(removeLoadingView) withObject:nil afterDelay:30];
    self.commonLoadingView=[[CommonLoadingView alloc] initWithNibName:@"CommonLoadingView" bundle:nil];
    [self.view addSubview:self.commonLoadingView.view];
    [commonLoadingView showProgressDialog:message];
}

-(void)removeLoadingView { 
    [commonLoadingView.activityIndicator stopAnimating];
    [commonLoadingView.view removeFromSuperview];
}

-(void)viewWillAppear:(BOOL)animated{

    
    //[activityView startAnimating];
    isFBKeyPresent =[[NSUserDefaults standardUserDefaults] objectForKey:@"isActiveFB"];
    isTWKeyPresent =[[NSUserDefaults standardUserDefaults] objectForKey:@"isActiveTW"];

  
    AppStatus *appStatus = [[AppStatus alloc]init];
    
    if([appStatus isAppOnline])
    {
        
        if([isFBKeyPresent isEqualToString:@"YES"] || [isTWKeyPresent isEqualToString:@"YES"] ){
            [dataArray removeAllObjects];
        }
    
        if([isFBKeyPresent isEqualToString:@"YES"]){
            [self getFacebookData];
        }else {
            if(facebookFeedsArray)
            {
            facebookInDict = [NSDictionary dictionaryWithObject:facebookFeedsArray forKey:@"Social"];
            [dataArray addObject:facebookInDict];
            }

        }
    
        if([isTWKeyPresent isEqualToString:@"YES"]){
            [self getTwitterData];
        }else {
            if(tweetsDataArray)
            {
                twitterInDict = [NSDictionary dictionaryWithObject:tweetsDataArray forKey:@"Social"];
                [dataArray addObject:twitterInDict];
            }
        }

        if([isFBKeyPresent isEqualToString:@"NO"] && [isTWKeyPresent isEqualToString:@"NO"])
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please ON facebook or twitter" message:@"Check Settings" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];

//        SocialSettingViewController *socialSettingViewController=[[SocialSettingViewController alloc]initWithNibName:@"SocialSettingViewController" bundle:nil];
//
//        [self.navigationController pushViewController:socialSettingViewController animated:YES];
//        [socialSettingViewController release]; 
    
            //Switch to tab
            self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:3];    
    
        }
        else{
            [tblView reloadData];
        }
    }else 
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connectivity Error" message:@"Check  your connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    }
    
    
    //Merge Two array
 //   [facebookFeedsArray addObjectsFromArray:tweetsDataArray];
}

//- (void)doNetworkOperations
//{
//    // Stop anything already in the queue before removing it
//    [[self networkQueue] cancelAllOperations];
//    
//    // Creating a new queue each time we use it means we don't have to worry about clearing delegates or resetting progress tracking
//    [self setNetworkQueue:[ASINetworkQueue queue]];
//    [[self networkQueue] setDelegate:self];
//    [[self networkQueue] setRequestDidFinishSelector:@selector(requestFinished:)];
//    [[self networkQueue] setRequestDidFailSelector:@selector(requestFailed:)];
//    [[self networkQueue] setQueueDidFinishSelector:@selector(queueFinished:)];
//    
//    
//    ASIHTTPRequest *facebookRequest = [self getFacebookData];
//    ASIHTTPRequest *twitterRequest = [self getTwitterData];
//
//    
//    [[self networkQueue] addOperation:facebookRequest];
//    [[self networkQueue] addOperation:twitterRequest];
//
//    [[self networkQueue] go];
//}



#pragma mark - Reqeust Queue Callbacks
//- (void)requestFinished:(ASIHTTPRequest *)request
//{
//     NSLog(@" **** %@", [request responseString]);
//    // NSLog(@"Global Request Finished Called!");
//   }
//
//- (void)queueFinished:(ASIHTTPRequest *)request
//{
//
//    
//    responseJSONString=[request responseString];
//    
//    if([self.facebook isEqualToString:@"facebook"]){
//       
//        facebookFeedsArray=[DataResult parseFacebookFeeds:responseJSONString];
//        NSLog(@"FACEBOOK RESPONSE -- %@",facebookFeedsArray);
//    }
//    
//    
//    if([self.twitter isEqualToString:@"twitter"]){
//        tweetsDataArray=[DataResult parseTwitterTweets:responseJSONString];
//        NSLog(@"TWITTER RESPONSE -- %@",tweetsDataArray);
//    }
//    
//    [self removeLoadingView];
//    [tblView reloadData];
//    //[facebookFeedsArray addObject:tweetsDataArray];
//
//}
//
//- (void)requestFailed:(ASIHTTPRequest *)request
//{
//
//    
//}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error %@",error);
    if ([flagSocial isEqualToString:@"twitter"]) {
        if(tweetsDataArray){
        twitterInDict = [NSDictionary dictionaryWithObject:tweetsDataArray forKey:@"Social"];
        [dataArray addObject:twitterInDict];
        }
    }
}

#pragma mark - ASIHttpRequestDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    responseJSONString=[request responseString];
    NSLog(@"Response: %@",responseJSONString);
 
        //----Facebook
        if ([flagSocial isEqualToString:@"facebook"]) {
            [facebookFeedsArray removeAllObjects];
            facebookFeedsArray=[DataResult parseFacebookFeeds:responseJSONString];
            NSLog(@"FACEBOOK RESPONSE -- %@",facebookFeedsArray);
            
            facebookInDict = [NSDictionary dictionaryWithObject:facebookFeedsArray forKey:@"Social"];
            [dataArray addObject:facebookInDict];

            [self removeLoadingView];
        }
   
        else if ([flagSocial isEqualToString:@"twitter"]) 
        {
        [tweetsDataArray removeAllObjects];
        tweetsDataArray=[DataResult parseTwitterTweets:responseJSONString];
         NSLog(@"TWITTER RESPONSE -- %@",tweetsDataArray);

         twitterInDict = [NSDictionary dictionaryWithObject:tweetsDataArray forKey:@"Social"];
         [dataArray addObject:twitterInDict];
            
        }

    //[activityView stopAnimating];
    
}

-(void)getFacebookData{
    if (![auth_key length] ==0) {
        flagSocial=@"facebook";
        NSString *strUrl=[NSString stringWithFormat:@"%@feed?access_token=%@",@"https://graph.facebook.com/TheSalmanKhanOfficial/",auth_key];
        
        NSLog(@"URL - %@",strUrl);
        
        url = [[NSURL alloc] initWithString:strUrl];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url:@"GET"];
        [request setDelegate:self];
        //[request setDidFinishSelector:@selector(requestFinished:)];
        [self showLoadingView:@"Loading ..."];
        [request startSynchronous];
        
    }

}
-(void)getTwitterData{
    if(![twitterAuthKey length] == 0)
    {
           flagSocial=@"twitter";
           NSString *postData = @"q=@BeingSalmanKhan";
           NSString *urlString = [NSString stringWithFormat:@"http://search.twitter.com/search.json?%@",postData];
           ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]:@"GET"];
          // [request setTimeOutSeconds:12];
           [request setDelegate:self];
           //[request setDidFinishSelector:@selector(requestFinished:)];
           [request startSynchronous];
    }
}

//- (ASIHTTPRequest *)getFacebookData{
//    
//    flagSocial=@"facebook";
//    NSString *strUrl=[NSString stringWithFormat:@"%@feed?access_token=%@",@"https://graph.facebook.com/TheSalmanKhanOfficial/",auth_key];
//    
//    NSLog(@"URL - %@",strUrl);
//    
//    url = [[NSURL alloc] initWithString:strUrl];
//    
//    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url:@"GET"];
//    [request setDelegate:self];
//   
//    [request setCompletionBlock:^{
//        self.facebook = @"facebook";
//    }];
//    return request;
//    
//    
//}
//- (ASIHTTPRequest *)getTwitterData{
//    
//       NSString *postData = @"q=@BeingSalmanKhan";
//       NSString *urlString = [NSString stringWithFormat:@"http://search.twitter.com/search.json?%@",postData];
//       ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]:@"GET"];
//        //   [request setTimeOutSeconds:12];
//       [request setDelegate:self];
//
//    [request setCompletionBlock:^{
//        self.twitter = @"twitter";
//    }];
//    return request;   
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)setTableView {
    tblView.delegate = self;
    tblView.dataSource = self;
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [dataArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"Facebook";
    else
        return @"Twitter";
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Social"];
    return [array count];
    
//    if (![facebookFeedsArray count]==0) {
//        return [facebookFeedsArray count];;
//    }
//    else {
//        return 50;
//    }

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog(@"Update table cell");
    UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:@"tableViewCellIdentifier"];
    
    [[NSBundle mainBundle] loadNibNamed:@"FeedsTweetsTableCell" owner:self options:nil];
    cell = self.tableCell;
    
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Social"];
    DataResult *model = [array objectAtIndex:indexPath.row];
    //NSString *cellValue = [array objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = model.strFeeds;
    cell.textLabel.font= [UIFont systemFontOfSize:14];
    cell.textLabel.numberOfLines=4;
    
//    // Configure the cell.
//    DataResult *model = [facebookFeedsArray objectAtIndex:indexPath.row];
//    
//    NSString *feedsData= model.strFeeds;
//    
//   // cell.imageView.frame=CGRectMake(0, 0, 70, 70);
//    
//    cell.textLabel.text=feedsData;
//    //lblTableContents.text=feedsData;
//    cell.imageView.image = [UIImage imageNamed:@"fb.png"];
//    self.tableCell = nil;
    
    return cell;
}

-(void)dealloc{
    [networkQueue release];
    [tblView release];
    [tableCell release];
    [tableContents release];
    [lblTableContents release];
    //[facebookFeedsArray release];
    //[tweetsDataArray release];
    [dataArray release];
    [commonLoadingView release];
    [super dealloc];
}
@end
