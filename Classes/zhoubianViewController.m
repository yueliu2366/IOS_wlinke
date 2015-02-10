//
//  zhoubianViewController.m
//  wlinke
//
//  Created by Liu Terence on 11-12-10.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import "zhoubianViewController.h"
#import "apiViewController.h"
#import "MySingleton.h"

@implementation zhoubianViewController
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
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"全部地点" style:UITabBarSystemItemContacts 
																	 target:self action:@selector(buttonPressed_allPlaces)];          
	
	self.navigationItem.leftBarButtonItem = anotherButton; 
	[anotherButton release];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(void)buttonPressed_allPlaces
{
	if([self.itemArray count]==0)
	{
		baseAlert = [[[UIAlertView alloc] initWithTitle:@"正在获取数据，等等哦~" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];  
		[baseAlert show];  
		
		// Create and add the activity indicator  
		UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];  
		aiv.center = CGPointMake(baseAlert.bounds.size.width / 2.0f, baseAlert.bounds.size.height - 40.0f);  
		[aiv startAnimating];  
		[baseAlert addSubview:aiv];  
		[aiv release];
		//[NSThread detachNewThreadSelector:@selector(multiThread_login) toTarget:self withObject:nil];//启用多线程载入数据小菊花view
		[self performSelectorInBackground:@selector(refreshAllPlaces) withObject:nil];
		
	}
	
}


-(void)refreshAllPlaces
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	apiViewController *apiController=[[apiViewController alloc] init ];
	id result=[apiController getPlaceData:[MySingleton sharedSingleton].myTokenAll andCategory:@"" andpage:@"" andpage_count:@""];
	NSArray *arr ;
	arr=result;
	for(id item in arr)
	{
		NSMutableDictionary *row=item;
		
		NSString *timesp=[item objectForKey:@"create_time"];
		NSTimeInterval time=[timesp doubleValue];
		NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
		id mydate=[confromTimesp description];
		[row setObject:mydate forKey:@"create_time"];
		
		[self.itemArray addObject:row];
		
	}
	[apiController release];
	
	[self.myTableView reloadData];
	[baseAlert dismissWithClickedButtonIndex:0 animated:YES];//结束多线程小菊花VIEW

	[pool drain];
	
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
		numLabel.text=@"活动人数";
		numLabel.font=[UIFont boldSystemFontOfSize:11];
		[cell.contentView addSubview:numLabel];
		[numLabel release];
		
		
		CGRect nameLabelRect=CGRectMake(0, 5, 40,20);
		UILabel *nameLabel=[[UILabel alloc] initWithFrame:
							nameLabelRect];
		nameLabel.textAlignment=UITextAlignmentLeft;
	    nameLabel.text=@"地点名称：";
		nameLabel.font=[UIFont boldSystemFontOfSize:12];
		[cell.contentView addSubview:nameLabel];
		[nameLabel release];
		
		CGRect cateLabelRect=CGRectMake(0, 25, 40,20);
		UILabel *cateLabel=[[UILabel alloc] initWithFrame:
						  cateLabelRect];
		cateLabel.textAlignment=UITextAlignmentLeft;
	    cateLabel.text=@"类型：";
		cateLabel.font=[UIFont boldSystemFontOfSize:12];
		[cell.contentView addSubview:cateLabel];
		[cateLabel release];
		
		CGRect decpLabelRect=CGRectMake(0, 45, 40,20);
		UILabel *decpLabel=[[UILabel alloc] initWithFrame:
							decpLabelRect];
		decpLabel.textAlignment=UITextAlignmentLeft;
	    decpLabel.text=@"描述：";
		decpLabel.font=[UIFont boldSystemFontOfSize:12];
		[cell.contentView addSubview:decpLabel];
		[decpLabel release];
		
		CGRect timeLabelRect=CGRectMake(0, 60, 150, 20);
		UILabel *timeLabel=[[UILabel alloc] initWithFrame:timeLabelRect];
		timeLabel.textAlignment=UITextAlignmentLeft;
		timeLabel.text=@"创建时间:";
		timeLabel.font=[UIFont boldSystemFontOfSize:11];
		[cell.contentView addSubview:timeLabel];
		[timeLabel release];
		
		CGRect nameValueRect = CGRectMake(30, 8, 100, 15);
        UILabel *nameValue = [[UILabel alloc] initWithFrame: 
                              nameValueRect];
        nameValue.tag = kNameValueTag;
        [cell.contentView addSubview:nameValue];
        [nameValue release];
		
		CGRect cateValueRect = CGRectMake(30, 28, 100, 15);
        UILabel *cateValue = [[UILabel alloc] initWithFrame: 
							cateValueRect];
        cateValue.tag = kCategoryValueTag;
        [cell.contentView addSubview:cateValue];
        [cateValue release];
		
		CGRect decpValueRect = CGRectMake(30, 47, 200, 15);
        UILabel *decpValue = [[UILabel alloc] initWithFrame: 
							  decpValueRect];
        decpValue.tag = kDescriptionValueTag;
        [cell.contentView addSubview:decpValue];
        [decpValue release];
		
		CGRect numValueRect = CGRectMake(290, 65, 15, 15);
        UILabel *numValue = [[UILabel alloc] initWithFrame: 
							 numValueRect];
        numValue.tag = kMemberCountValueTag;
        [cell.contentView addSubview:numValue];
        [numValue release];
		
		CGRect timeValueRect=CGRectMake(60, 62, 150, 15);
		UILabel *timeValue=[[UILabel alloc] initWithFrame:timeValueRect];
		timeValue.tag=kCreateTimeValueTag;
		[cell.contentView addSubview:timeValue];
		[timeValue release];
	}
	
	
	NSUInteger row = [indexPath row];
	NSDictionary *itemData = [self.itemArray objectAtIndex:row];
	
	UILabel *name = (UILabel *)[cell.contentView viewWithTag:kNameValueTag];
	name.text = [itemData objectForKey:@"place_name"];
	
	UILabel *Id = (UILabel *)[cell.contentView viewWithTag:kCategoryValueTag];
	Id.text = [itemData objectForKey:@"place_category"];
	
	UILabel *decp = (UILabel *)[cell.contentView viewWithTag:kDescriptionValueTag];
	decp.text = [itemData objectForKey:@"place_destription"];
	decp.font=[UIFont boldSystemFontOfSize:11];
	
	UILabel *num = (UILabel *)[cell.contentView viewWithTag:kMemberCountValueTag];
	num.text = [itemData objectForKey:@"member_count"];
	num.font=[UIFont boldSystemFontOfSize:11];
	
	UILabel *time=(UILabel *)[cell.contentView viewWithTag:kCreateTimeValueTag];
	time.text=[itemData objectForKey:@"create_time"];
	time.font=[UIFont boldSystemFontOfSize:11];
	
	
	return cell;
    
	
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
	return 85; 
}

@end
