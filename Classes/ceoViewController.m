//
//  ceoViewController.m
//  wlinke
//
//  Created by Liu Terence on 11-12-2.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import "ceoViewController.h"
#import"quwenViewController.h"
#import"shequViewController.h"
#import"zhoubianViewController.h"
#import"wojuViewController.h"
#import"shezhiViewController.h"

@implementation ceoViewController
@synthesize userName,passWord,mainTabbarController;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*
- (void)viewDidLoad {
 
}
*/
-(void)loadView{
	[super viewDidLoad];
	mainTabbarController=[[UITabBarController alloc] init ];
	NSMutableArray *mainTabbarArray = [[NSMutableArray alloc] initWithCapacity:5];
	//add first tab named 趣闻
	quwenViewController *quwenController=[[quwenViewController alloc] init];
	quwenController.title=@"趣闻";
	[quwenController.tabBarItem initWithTitle:@"趣闻" image:[UIImage imageNamed:@"freshnews.png"] tag:1];
	UINavigationController *quwenNavController=[[UINavigationController alloc] initWithRootViewController:quwenController];
    quwenNavController.navigationBar.tintColor=[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.5f] ;
        
    
	[mainTabbarArray addObject:quwenNavController];
	[quwenController release];
	[quwenNavController release];
	
	
	//add second tab named 社区
	shequViewController *shequController=[[shequViewController alloc] init];
	shequController.title=@"社区";
	[shequController.tabBarItem initWithTitle:@"社区" image:[UIImage imageNamed:@"community.png"] tag:2];
	UINavigationController *shequNavController=[[UINavigationController alloc] initWithRootViewController:shequController];
	[mainTabbarArray addObject:shequNavController];
	[shequController release];
	[shequNavController release];
	
	//add third tab named 周边
	zhoubianViewController *zhoubianController=[[zhoubianViewController alloc] init];
	zhoubianController.title=@"周边";
	[zhoubianController.tabBarItem initWithTitle:@"周边" image:[UIImage imageNamed:@"round.png"] tag:3];
	UINavigationController *zhoubianNavController=[[UINavigationController alloc] initWithRootViewController:zhoubianController];
	[mainTabbarArray addObject:zhoubianNavController];
	[zhoubianController release];
	[zhoubianNavController release];
	
	//add fourth tab named 蜗居
	wojuViewController *wojuController=[[wojuViewController alloc] init];
	wojuController.title=@"蜗居";
	[wojuController.tabBarItem initWithTitle:@"蜗居" image:[UIImage imageNamed:@"homepage.png"] tag:4];
	UINavigationController *wojuNavController=[[UINavigationController alloc] initWithRootViewController:wojuController];
	[mainTabbarArray addObject:wojuNavController];
	[wojuController release];
	[wojuNavController release];
	//add fifth tab named 设置
	shezhiViewController *shezhiController=[[shezhiViewController alloc] init];
	shezhiController.title=@"设置";
	[shezhiController.tabBarItem initWithTitle:@"设置" image:[UIImage imageNamed:@"setting.png"] tag:4];
	UINavigationController *shezhiNavController=[[UINavigationController alloc] initWithRootViewController:shezhiController];
	[mainTabbarArray addObject:shezhiNavController];
	[shezhiController release];
	[shezhiNavController release];
	
	
	mainTabbarController.viewControllers=mainTabbarArray;
	[mainTabbarArray release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
