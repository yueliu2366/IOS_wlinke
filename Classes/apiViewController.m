    //
//  apiViewController.m
//  wlinke
//
//  Created by Liu Terence on 11-12-1.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import "apiViewController.h"
#import "XMLRPCRequest.h"
#import "XMLRPCResponse.h"
#import "XMLRPCConnection.h"
#import"wlinkeAppDelegate.h"
#import"MySingleton.h"

NSString * const KEY_USERNAME_PASSWORD = @"cn.3gie.bns.usernamepassword";
NSString * const KEY_USERNAME = @"cn.3gie.bns.username";
NSString * const KEY_PASSWORD = @"cn.3gie.bns.password";
NSString * const  SERVER_URL = @"http://bearcat001.gotoip3.com/xmlrpc";
NSString *const METHOD_LOGIN=@"we.userLogin";
NSString *const METHOD_ADDUSER=@"we.addUser";
NSString *const METHOD_GETPUBLICWB=@"we.getAllPublicWeibo";
NSString *const METHOD_POSTWEIBO=@"we.postWeibo";
NSString *const METHOD_GETGROUPDATA=@"we.getGroupDatasbyUserId";
NSString *const METHOD_GETPLACEDATA=@"we.getPlaceDatasbyCategory";
@implementation apiViewController

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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
//登陆的接口函数
-(BOOL)loginWithUserName:(NSString *)userName andPassword:(NSString *)passWord
{
	
	XMLRPCRequest *reqHello = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:SERVER_URL]];
	NSString *nothing=@"";
	[reqHello setMethod:METHOD_LOGIN withObjects:[NSArray arrayWithObjects:userName,passWord,nothing,nil]];
	
	id result=[self executeXMLRPCRequest:reqHello];
	[reqHello release];

	NSLog(@"%@",result);
	NSString *myToken=[result objectForKey:@"token"];
	
	[MySingleton sharedSingleton].myTokenAll=myToken;
	NSLog(@"The token is:%@",[MySingleton sharedSingleton].myTokenAll);//测试全局变量
	return YES;

	
}
//注册的接口函数
-(NSString *)signUpWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andRealName:(NSString *)realName
{
	XMLRPCRequest *reqHello = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:SERVER_URL]];
	NSString *nothing=@"";
	[reqHello setMethod:METHOD_ADDUSER withObjects:[NSArray arrayWithObjects:userName,passWord,realName,nothing,nil]];
	id result=[self executeXMLRPCRequest:reqHello];
	[reqHello release];
	NSString *flag=result;
	
	return flag;
	
	
	
}

-(id)getAllPublicWeibo:(NSString *)token andFilter:(NSString *)filter andFeed_id:(NSString *)feed_id
{
	XMLRPCRequest *reqHello = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:SERVER_URL]];
	[reqHello setMethod:METHOD_GETPUBLICWB withObjects:[NSArray arrayWithObjects:token,filter,feed_id,nil]];
	id result=[self executeXMLRPCRequest:reqHello];
	[reqHello release];
	//NSLog(@"%@",result);
	return result;
}

-(void)postWeibo:(NSString *)token andContent:(NSString *)content andvisibility:(NSString *)visibility
{
	XMLRPCRequest *reqHello = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:SERVER_URL]];
	[reqHello setMethod:METHOD_POSTWEIBO withObjects:[NSArray arrayWithObjects:token,content,visibility,nil]];
	id result=[self executeXMLRPCRequest:reqHello];
	[reqHello release];
	NSLog(@"%@",result);
	
}

-(id)getGroupData:(NSString *)token  andIs_admin:(NSString *)is_admin andpage:(NSString *)page andpage_count:(NSString *)page_count
{
	XMLRPCRequest *reqHello = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:SERVER_URL]];
	[reqHello setMethod:METHOD_GETGROUPDATA withObjects:[NSArray arrayWithObjects:token,is_admin,page,page_count,nil]];
	id result=[self executeXMLRPCRequest:reqHello];
	[reqHello release];
	NSLog(@"%@",result);
	return result;
	
}
-(id)getPlaceData:(NSString *)token andCategory:(NSString *)category andpage:(NSString *)page andpage_count:(NSString *)page_count
{
	XMLRPCRequest *reqHello = [[XMLRPCRequest alloc] initWithHost:[NSURL URLWithString:SERVER_URL]];
	[reqHello setMethod:METHOD_GETPLACEDATA	withObjects:[NSArray arrayWithObjects:token,category,page,page_count,nil]];
	id result=[self executeXMLRPCRequest:reqHello];
	[reqHello release];
	NSLog(@"%@",result);
	return result;
	
		
}

- (id)executeXMLRPCRequest:(XMLRPCRequest *)req {
	XMLRPCResponse *userInfoResponse = [XMLRPCConnection sendSynchronousXMLRPCRequest:req];
	return [userInfoResponse object];
}

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
