//
//  shequViewController.m
//  wlinke
//
//  Created by Liu Terence on 11-12-10.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import "shequViewController.h"
#import"apiViewController.h"
#import"MySingleton.h"

@implementation shequViewController
@synthesize myTableView,itemArray;
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
- (void)viewDidLoad {
    [super viewDidLoad];
	self.itemArray=[NSMutableArray arrayWithCapacity:50];//申请数组空间，很重要

	UIToolbar *mycustomToolBar;  
    NSMutableArray *mycustomButtons = [[NSMutableArray alloc] init];  
    UIBarButtonItem *myButton1 = [[[UIBarButtonItem alloc]  
								   initWithTitle:@"我的群"  
								   style:UIBarButtonItemStyleBordered  
								   target:self   
								   action:@selector(btnPressed_myGroup)]autorelease];  
    myButton1.width = 43;  
    [mycustomButtons addObject: myButton1];
	
    UIBarButtonItem *myButton2 = [[[UIBarButtonItem alloc]  
								   initWithTitle:@"所有群"  
								   style:UIBarButtonItemStyleBordered  
								   target:self   
								   action:@selector(action)]autorelease];  
    myButton2.width = 43;  
    [mycustomButtons addObject: myButton2];  
	
	UIBarButtonItem *myButton3 = [[[UIBarButtonItem alloc]  
								   initWithTitle:@"班级群"  
								   style:UIBarButtonItemStyleBordered  
								   target:self   
								   action:@selector(action)]autorelease];  
    myButton3.width = 43;  
    [mycustomButtons addObject: myButton3];
	
	UIBarButtonItem *myButton4 = [[[UIBarButtonItem alloc]  
								   initWithTitle:@"兴趣群"  
								   style:UIBarButtonItemStyleBordered  
								   target:self   
								   action:@selector(action)]autorelease];  
    myButton4.width = 43;  
    [mycustomButtons addObject: myButton4];   
	
	UIBarButtonItem *myButton5 = [[[UIBarButtonItem alloc]  
								   initWithTitle:@"娱乐群"  
								   style:UIBarButtonItemStyleBordered  
								   target:self   
								   action:@selector(action)]autorelease];  
    myButton5.width = 43;  
    [mycustomButtons addObject: myButton5]; 
	
	UIBarButtonItem *myButton6 = [[[UIBarButtonItem alloc]  
								   initWithTitle:@"创建群"  
								   style:UIBarButtonItemStyleBordered  
								   target:self   
								   action:@selector(action)]autorelease];  
    myButton6.width = 43;  
    [mycustomButtons addObject: myButton6];   
	
	
	
    mycustomToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, 0.0f,320.0f, 44.0f)];  
    //mycustomToolBar.center = CGPointMake(160.0f,200.0f);  
    mycustomToolBar.barStyle = UIBarStyleDefault;  
    [mycustomToolBar setItems:mycustomButtons animated:YES];  
    [mycustomToolBar sizeToFit];      
 
  [self.view addSubview:mycustomToolBar];  
   //   self.navigationItem.titleView = mycustomToolBar;//与上一句都可实现在上面叠加工具条  
    //将toolbar的颜色设置为透明，总之使用两个控件叠加完美  
    [mycustomToolBar release];  
    [mycustomButtons release];  
	
	
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"点名" style:UITabBarSystemItemContacts 
																	 target:self action:@selector(action)];          
	self.navigationItem.rightBarButtonItem = anotherButton; 
	[anotherButton release];
	
}

-(void)btnPressed_myGroup
{
	if([self.itemArray count]==0)
	{
	baseAlert = [[[UIAlertView alloc] initWithTitle:@"正在获取数据，耐心等待哦~" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];  
    [baseAlert show];  
	
    // Create and add the activity indicator  
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];  
    aiv.center = CGPointMake(baseAlert.bounds.size.width / 2.0f, baseAlert.bounds.size.height - 40.0f);  
    [aiv startAnimating];  
    [baseAlert addSubview:aiv];  
    [aiv release];
	//[NSThread detachNewThreadSelector:@selector(multiThread_login) toTarget:self withObject:nil];//启用多线程载入数据小菊花view
	[self performSelectorInBackground:@selector(refreshMyGroup) withObject:nil];
	
	}
	
}


-(void)refreshMyGroup
{
	 NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	apiViewController *apiController=[[apiViewController alloc] init ];
	id result=[apiController getGroupData:[MySingleton sharedSingleton].myTokenAll andIs_admin:@"0" andpage:@"" andpage_count:@""];
	NSArray *arr ;
	arr=result;

	for(id item in arr)
	{
		NSMutableDictionary *row=item;
		[self.itemArray addObject:row];
		
	}
	[apiController release];
	
	[baseAlert dismissWithClickedButtonIndex:0 animated:YES];//结束多线程小菊花VIEW

	NSLog(@"存进去的是：%@",self.itemArray);
	[self.myTableView reloadData];
	[pool drain];
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

#pragma mark -
#pragma mark UITableViewDataSource



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {//确定tableview cell有几行，非常重要
    return itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
	static NSString *CellTableIdentifier = @"CellTableIdentifier ";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellTableIdentifier];
	
	
	
	
	if (cell == nil) {
#ifdef __IPHONE_3_0__
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier: CellTableIdentifier] autorelease];
#else // Prior to 3.0, use this call which is available but deprecated in 3.0
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
                                       reuseIdentifier:CellTableIdentifier] autorelease];
#endif
		
		CGRect numLabelRect=CGRectMake(240, 60, 45, 25);
		UILabel *numLabel=[[UILabel alloc] initWithFrame:
							numLabelRect];
		numLabel.textAlignment=UITextAlignmentLeft;
		numLabel.text=@"群成员数";
		numLabel.font=[UIFont boldSystemFontOfSize:11];
		[cell.contentView addSubview:numLabel];
		[numLabel release];
		
		
		CGRect nameLabelRect=CGRectMake(0, 5, 40,20);
		UILabel *nameLabel=[[UILabel alloc] initWithFrame:
							 nameLabelRect];
		nameLabel.textAlignment=UITextAlignmentLeft;
	    nameLabel.text=@"群名：";
		nameLabel.font=[UIFont boldSystemFontOfSize:12];
		[cell.contentView addSubview:nameLabel];
		[nameLabel release];
		
		CGRect IdLabelRect=CGRectMake(0, 25, 40,20);
		UILabel *IdLabel=[[UILabel alloc] initWithFrame:
							IdLabelRect];
		IdLabel.textAlignment=UITextAlignmentLeft;
	    IdLabel.text=@"群号：";
		IdLabel.font=[UIFont boldSystemFontOfSize:12];
		[cell.contentView addSubview:IdLabel];
		[IdLabel release];
		
		CGRect decpLabelRect=CGRectMake(0, 45, 40,20);
		UILabel *decpLabel=[[UILabel alloc] initWithFrame:
						   decpLabelRect];
		decpLabel.textAlignment=UITextAlignmentLeft;
	    decpLabel.text=@"描述：";
		decpLabel.font=[UIFont boldSystemFontOfSize:12];
		[cell.contentView addSubview:decpLabel];
		[decpLabel release];
		
		
		CGRect nameValueRect = CGRectMake(30, 8, 100, 15);
        UILabel *nameValue = [[UILabel alloc] initWithFrame: 
                              nameValueRect];
        nameValue.tag = KGNameValueTag;
        [cell.contentView addSubview:nameValue];
        [nameValue release];
		
		CGRect IdValueRect = CGRectMake(30, 28, 100, 15);
        UILabel *IdValue = [[UILabel alloc] initWithFrame: 
                              IdValueRect];
        IdValue.tag = KGIdValueTag;
        [cell.contentView addSubview:IdValue];
        [IdValue release];
		
		CGRect decpValueRect = CGRectMake(30, 47, 100, 15);
        UILabel *decpValue = [[UILabel alloc] initWithFrame: 
							decpValueRect];
        decpValue.tag = KGDecpValueTag;
        [cell.contentView addSubview:decpValue];
        [decpValue release];
		
		CGRect numValueRect = CGRectMake(290, 65, 15, 15);
        UILabel *numValue = [[UILabel alloc] initWithFrame: 
							  numValueRect];
        numValue.tag = KGNumValueTag;
        [cell.contentView addSubview:numValue];
        [numValue release];
		
	}
	
	
	NSUInteger row = [indexPath row];
	NSDictionary *itemData = [self.itemArray objectAtIndex:row];
	
	UILabel *name = (UILabel *)[cell.contentView viewWithTag:KGNameValueTag];
	name.text = [itemData objectForKey:@"group_name"];
	
	UILabel *Id = (UILabel *)[cell.contentView viewWithTag:KGIdValueTag];
	Id.text = [itemData objectForKey:@"group_id"];
	
	UILabel *decp = (UILabel *)[cell.contentView viewWithTag:KGDecpValueTag];
	decp.text = [itemData objectForKey:@"group_destription"];
	
	UILabel *num = (UILabel *)[cell.contentView viewWithTag:KGNumValueTag];
	num.text = [itemData objectForKey:@"member_count"];
	num.font=[UIFont boldSystemFontOfSize:11];
	return cell;
    
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	return 80; 
}

@end
