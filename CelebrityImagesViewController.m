//
//  CelebrityImagesViewController.m
//  CelebrityApp
//
//  Created by nachi on 17/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CelebrityImagesViewController.h"
#import "AppStatus.h"
#import "ASIFormDataRequest.h"
#import "DataResult.h"
#import "AppStatus.h"

@implementation CelebrityImagesViewController
@synthesize imageView,tableCell,tblView,commonLoadingView;

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
    [self setTableView];
    self.navigationItem.title=@"Celebrity Images";
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)setTableView {
    tblView.delegate = self;
    tblView.dataSource = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void)viewDidAppear:(BOOL)animated{
    [tblView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{

    AppStatus *appStatus = [[AppStatus alloc]init];
    
    if([appStatus isAppOnline])
    {
        standardUserDefaults = [NSUserDefaults standardUserDefaults];
        NSString *auth_key=[standardUserDefaults objectForKey:@"FBAuthToken"];
        
    if(![auth_key length]==0){
        NSString *strUrl=[NSString stringWithFormat:@"%@photos?access_token=%@&fields=picture&limit=30",@"https://graph.facebook.com/336011213137278/",auth_key];
        //fields=picture&limit=3
        
        NSURL *url = [[NSURL alloc] initWithString:strUrl];
        // NSURL *url = [[NSURL alloc] initWithString:@""];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url:@"GET"];
        
        
        //  [request setPostValue:auth_key forKey:@"AUTH_KEY"];
        [request setDelegate:self];
        [request setDidFinishSelector:@selector(requestFinished:)];
        [self showLoadingView:@"Loading images..."];
        [request startAsynchronous];
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Please Connect user to facebook" message:@"Check Settings" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    }else 
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connectivity Error" message:@"Check  your connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
       self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - ASIHttpRequestDelegate
-(void)requestFinished:(ASIHTTPRequest *)request
{
    responseJSONString=[request responseString];
    NSLog(@"Facebook Response: %@",responseJSONString);
    facebookImageArray=[DataResult parseFacebookImage:responseJSONString];
    
    NSLog(@"RESPONSE -- %@",facebookImageArray);
    
    if([facebookImageArray count]==0){
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"no data to display" message:@"Check  your connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];        
        
    }else{
        [tblView reloadData];
    }
    
    [self removeLoadingView];

}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Connectivity Error" message:@"Check  your connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
    NSLog(@"Error in WebCall");
}


#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    if (facebookImageArray.count) {
        return [facebookImageArray count];
    }
    else {
        return 50;
    }
    
   // return 75;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"Update table cell");
    UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:@"tableViewCellIdentifier"];
    
    
    [[NSBundle mainBundle] loadNibNamed:@"tableCell" owner:self options:nil];
    cell = self.tableCell;
    
    //Place images 

    DataResult *model = [facebookImageArray objectAtIndex:indexPath.row];
    
    NSString *picture= model.strImage;
    
    NSURL *imageurl = [NSURL URLWithString:picture];
    
    NSData *imagedata = [[NSData alloc]initWithContentsOfURL:imageurl];
    
    UIImage *image = [[UIImage imageWithData: imagedata] stretchableImageWithLeftCapWidth:10 topCapHeight:10];
    //imageView.frame=CGRectMake(100, 100, 580, 420);
    imageView.image=image;
    
//    UIImage *image1 = [[UIImage imageNamed:@"chatBubble.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
  
    
    self.tableCell = nil;

    return cell;
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

-(void)dealloc{
    [imageView release];
    [tableCell release];
    [tblView release];
    [commonLoadingView release];
    [super dealloc];
}
@end
