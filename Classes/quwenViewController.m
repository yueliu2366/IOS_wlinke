//
//  quwenViewController.m
//  wlinke
//
//  Created by Liu Terence on 11-12-10.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import "quwenViewController.h"
#import"MySingleton.h"
#import"apiViewController.h"
#import"postWeiboViewController.h"
#import "EGOImageView.h"
@implementation quwenViewController
@synthesize myTableView,myToken,itemArray;
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
-(void)viewDidLoad {
    [super viewDidLoad];
	self.itemArray=[NSMutableArray arrayWithCapacity:20];//申请数组空间，很重要

if (_refreshHeaderView == nil) { 
	EGORefreshTableHeaderView *view1=[[EGORefreshTableHeaderView alloc]
									  initWithFrame:CGRectMake(0.0f,10.0f-self.myTableView.bounds.size.height,
																self.myTableView.frame.size.width,self.view.bounds.size.height)];
	
	view1.delegate = self; 
	[self.myTableView addSubview:view1]; 
	_refreshHeaderView = view1; 
	[view1 release]; 
} 
[_refreshHeaderView refreshLastUpdatedDate];
   
	
	UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"发状态" style:UITabBarSystemItemContacts 
																	 target:self action:@selector(clickPostWeibo)];          
	self.navigationItem.leftBarButtonItem = anotherButton; 
	[anotherButton release];
    
   
	
	
}

-(void)clickPostWeibo
{
	postWeiboViewController *postWeiboController=[[postWeiboViewController alloc] init];
	postWeiboController.title=@"发状态";
	[self.navigationController pushViewController:postWeiboController animated:YES];
	
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.myTableView=nil; 
    _refreshHeaderView=nil; 
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
		
		
     /*   CGRect nameLabelRect = CGRectMake(40, 10, 70, 15);
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameLabelRect];
        nameLabel.textAlignment = UITextAlignmentLeft;
        nameLabel.text = @"用户名:";
        nameLabel.font = [UIFont boldSystemFontOfSize:12];
        [cell.contentView addSubview: nameLabel];
        [nameLabel release];*/
        
		
		
        CGRect nameValueRect = CGRectMake(40, 10, 70, 15);
        UILabel *nameValue = [[UILabel alloc] initWithFrame: 
                              nameValueRect];
        nameValue.tag = kNameValueTag;
        nameValue.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:nameValue];
        [nameValue release];
        
        CGRect updateValueRect = CGRectZero;
        UILabel *updateValue = [[UILabel alloc] initWithFrame: 
								updateValueRect];
        updateValue.tag = kUpdateValueTag;
        [cell.contentView addSubview:updateValue];
        [updateValue release];
		
	/*	CGRect updateValueRect = CGRectMake(40, 30, 200, 100);
		UITextView *updateValue=[[UITextView alloc] initWithFrame:updateValueRect];
		//updateValue.backgroundColor=[UIColor grayColor];
        updateValue.backgroundColor=[UIColor clearColor];
		updateValue.editable=NO;
		
		updateValue.tag=kUpdateValueTag;
		[cell.contentView addSubview:updateValue];
		[updateValue release];*/
		
		
		CGRect activityValueRect = CGRectMake(210, 10, 200, 15);
        UILabel *activityValue = [[UILabel alloc] initWithFrame: 
								  activityValueRect];
        activityValue.tag = kActivityValueTag;
        [cell.contentView addSubview:activityValue];
        activityValue.backgroundColor=[UIColor clearColor];
        [activityValue release];
		
		
		CGRect imageRect=CGRectMake(0, 5, 38, 38);
		EGOImageView *tempView = [[EGOImageView alloc] initWithFrame:imageRect];
		tempView.tag=kImageValueTag;
		[cell.contentView addSubview:tempView];
		[tempView release];
		
		
        CGRect tran_comValueRect=CGRectZero;
        UILabel *tran_comValueLabel=[[UILabel alloc] initWithFrame:tran_comValueRect];
        tran_comValueLabel.tag=Ktran_comValueTag;
        [cell.contentView addSubview:tran_comValueLabel];
        tran_comValueLabel.backgroundColor=[UIColor clearColor];
		[tran_comValueLabel release];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background2.png"]];
        cell.backgroundView = bgImageView;    
        [bgImageView release];
        
        CGRect transpond_contentValueRect=CGRectMake(60, 0, 0, 0);
        UILabel *transpond_contentValue=[[UILabel alloc] initWithFrame:transpond_contentValueRect];
        transpond_contentValue.tag=Ktranspond_contentValueTag;
        [cell.contentView addSubview:transpond_contentValue];
        [transpond_contentValue release];
	}
	
	NSUInteger row = [indexPath row];
	NSDictionary *itemData = [self.itemArray objectAtIndex:row];
	EGOImageView *imageView=(EGOImageView *)[cell.contentView viewWithTag:kImageValueTag];
	//imageView.image=[itemData objectForKey:@"user_avatar"];
    imageView.placeholderImage=[UIImage imageNamed:@"default_avatar.png"];
    imageView.imageURL=[NSURL URLWithString:[itemData objectForKey:@"user_avatar"]];
    //[NSThread detachNewThreadSelector:@selector(getPicture:) toTarget:self withObject:indexPath];

    
    
    
	UILabel *name = (UILabel *)[cell.contentView viewWithTag:kNameValueTag];
	name.text = [itemData objectForKey:@"display_name"];
	
	
	UILabel *activity=(UILabel *)[cell.contentView viewWithTag:kActivityValueTag];
	[activity setFont:[UIFont fontWithName:@"Helvetica Neue" size:11]];
	activity.text=[itemData objectForKey:@"create_time"];
	
    NSString *myText=[itemData objectForKey:@"feed_content"];
    UIFont *myFont=[UIFont fontWithName:@"Arial" size:12];
    CGFloat constrainedSize = 265.0f;
    CGSize textSize = [myText sizeWithFont: myFont
                         constrainedToSize:CGSizeMake(constrainedSize, CGFLOAT_MAX)
                             lineBreakMode:UILineBreakModeWordWrap];
    UILabel *update = (UILabel *)[cell.contentView viewWithTag:kUpdateValueTag];
    CGRect labelFrame=CGRectMake(40, 25, textSize.width, textSize.height);
    [update setFrame:labelFrame];
    [update setFont:myFont];
    [update setText:myText];
    update.backgroundColor=[UIColor clearColor];
    update.lineBreakMode=UILineBreakModeWordWrap;
    update.numberOfLines=0;
    
	/*UITextView *update=(UITextView *)[cell.contentView viewWithTag:kUpdateValueTag];
	update.text=[itemData objectForKey:@"feed_content"];*/
	
	
    
    UILabel *transpond_contentLabel=(UILabel *)[cell.contentView viewWithTag:Ktranspond_contentValueTag];
    id temp=[itemData objectForKey:@"source_feed"];
     NSString *str5=[temp objectForKey:@"feed_content"];
    NSString *tran_myText=nil;
    if([str5 isKindOfClass:[NSString class]])
    {
    
    NSString *str1=[[NSString alloc] initWithFormat:@"转自"];
    NSString *str2=[temp objectForKey:@"display_name"];
    NSString *str3=[[NSString alloc] initWithFormat:@":"];    
    NSString *str4=[[NSString alloc] initWithFormat:@"%@%@%@",str1,str2,str3];
    NSString *str5=[temp objectForKey:@"feed_content"];
      tran_myText=[[NSString alloc] initWithFormat:@"%@%@",str4,str5];
    }
    
//    NSString *tran_myText=[temp objectForKey:@"feed_content"];
    UIFont *tran_myFont=[UIFont fontWithName:@"Arial" size:12];
    CGFloat tran_constrainedSize = 245.0f;
    CGSize tran_textSize = [tran_myText sizeWithFont: tran_myFont
                         constrainedToSize:CGSizeMake(tran_constrainedSize, CGFLOAT_MAX)
                             lineBreakMode:UILineBreakModeWordWrap];
    CGRect tran_labelFrame=CGRectMake(60, textSize.height+25, tran_textSize.width, tran_textSize.height);
    [transpond_contentLabel setFrame:tran_labelFrame];
    [transpond_contentLabel setFont:tran_myFont];
    [transpond_contentLabel setText:tran_myText];
//transpond_contentLabel.backgroundColor=[UIColor clearColor];
    transpond_contentLabel.lineBreakMode=UILineBreakModeWordWrap;
    transpond_contentLabel.numberOfLines=0;
    transpond_contentLabel.backgroundColor=[UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:0.5];
	
	/*
	UILabel *transpond=(UILabel *)[cell.contentView viewWithTag:KtranspondValueTag];
    CGRect transpondRect=CGRectMake(255, textSize.height+tran_textSize.height +29, 15, 15);
    transpond.frame=transpondRect;
	transpond.text=[itemData objectForKey:@"transpond_count"];
	
	UILabel *comment=(UILabel *)[cell.contentView viewWithTag:KcommentValueTag];
    CGRect commentRect=CGRectMake(295, textSize.height+tran_textSize.height +29, 15, 15);
    comment.frame=commentRect;
	comment.text=[itemData objectForKey:@"comment_count"];
	
	UILabel *transpondLabel=(UILabel *)[cell.contentView viewWithTag:KtranspondLabelTag];
    CGRect transpondLabelRect=CGRectMake(240, textSize.height+tran_textSize.height +29, 15, 15);
    transpondLabel.frame=transpondLabelRect;
    
    UILabel *commentLabel=(UILabel *)[cell.contentView viewWithTag:KcommentLabelTag];
    CGRect commentLabelRect=CGRectMake(280, textSize.height+tran_textSize.height +29, 15, 15);
    commentLabel.frame=commentLabelRect;
	*/
    
    UILabel *tran_comment=(UILabel *)[cell.contentView viewWithTag:Ktran_comValueTag];
    CGRect tran_commentRect=CGRectMake(240, textSize.height+tran_textSize.height +25, 60, 15);
    tran_comment.frame=tran_commentRect;
    NSString *str1=[[NSString alloc] initWithFormat:@"转:"];
    NSString *str2=[itemData objectForKey:@"transpond_count"];
    NSString *str3=[[NSString alloc] initWithFormat:@"评:"];    
    NSString *str4=[itemData objectForKey:@"comment_count"];
    str5=[[NSString alloc] initWithFormat:@"%@%@ %@%@",str1,str2,str3,str4];
    tran_comment.text=str5;
    tran_comment.font=tran_myFont;
	//可用！	
	
	/*if(row!=([self.itemArray count]-1))
	{
		NSDictionary *itemData = [self.itemArray objectAtIndex:row+1];
		UILabel *name = (UILabel *)[cell.contentView viewWithTag:kNameValueTag];
		name.text = [itemData objectForKey:@"display_name"];
		UILabel *update = (UILabel *)[cell.contentView viewWithTag:kUpdateValueTag];
		update.text = [itemData objectForKey:@"latest_update"];
		UILabel *activity=(UILabel *)[cell.contentView viewWithTag:kActivityValueTag];
		[activity setFont:[UIFont fontWithName:@"Helvetica Neue" size:8]];
		activity.text=[itemData objectForKey:@"last_activity"];
		
		UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:kImageValueTag];
		imageView.image=[itemData objectForKey:@"user_avatar"];
		
		
	}*/

	return cell;
    
	
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
{ 
   //return 150;
NSUInteger row = [indexPath row];
	NSDictionary *itemData = [self.itemArray objectAtIndex:row];
    NSString *myText=[itemData objectForKey:@"feed_content"];
    UIFont *myFont=[UIFont fontWithName:@"Arial" size:12];
    CGFloat constrainedSize = 265.0f;
    CGSize textSize = [myText sizeWithFont: myFont
                         constrainedToSize:CGSizeMake(constrainedSize, CGFLOAT_MAX)
                             lineBreakMode:UILineBreakModeWordWrap];
    
    
    id temp=[itemData objectForKey:@"source_feed"];
    NSString *tran_myText=[temp objectForKey:@"feed_content"];
    UIFont *tran_myFont=[UIFont fontWithName:@"Arial" size:12];
    CGFloat tran_constrainedSize = 245.0f;
    CGSize tran_textSize = [tran_myText sizeWithFont: tran_myFont
                                   constrainedToSize:CGSizeMake(tran_constrainedSize, CGFLOAT_MAX)
                                       lineBreakMode:UILineBreakModeWordWrap];
   
    
    return  textSize.height+tran_textSize.height+50;
}


/*
-(void)getPicture
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
   
    NSUInteger row =0;
    NSInteger itemCount=[itemArray count];
	NSDictionary *itemData = [self.itemArray objectAtIndex:row];
    UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
	UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:kImageValueTag];
	//imageView.image=[itemData objectForKey:@"user_avatar"];    
    id avatar_url=nil;
    avatar_url=[itemData objectForKey:@"user_avatar"];
    if ([avatar_url isKindOfClass:[UIImage class]]) {
        imageView.image=avatar_url;
    }
    else
    {
       //get image with given url;
    NSURL *url=[NSURL URLWithString:avatar_url];
    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    imageView.image=image;
    [itemData setObject:image forKey:@"user_avatar"];
    [self.itemArray replaceObjectAtIndex:row withObject:itemData];
    }
    
    [pool drain];

}
 */

#pragma mark – 
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{ 
    NSLog(@"==开始加载数据");
	
    _reloading = YES; 
}

- (void)doneLoadingTableViewData{ 
	NSLog(@"启用多线程");
	//[self performSelectorInBackground:@selector(myGetData) withObject:nil];//有可能导致菊花结束还没开始绘图。
	[self performSelector:@selector(myGetData)];

    
    NSLog(@"===加载完数据"); 
	NSLog(@"获取数据后item array count is:%d",[itemArray count]);
	[myTableView reloadData];//reload the tableview	
	NSLog(@"刷新视图结束");
    _reloading = NO; 
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView]; 
} 
-(void)myGetData
{
	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	apiViewController *apiController=[[apiViewController alloc] init ];
	id result;
	NSString *avatar_url=nil;
	NSArray *arr ;
	NSLog(@"获取数据前item array count is:%d",[itemArray count]);
	NSDictionary *error_flag= [[NSDictionary alloc]initWithObjectsAndKeys:@"no_weibo",@"error",nil];
	if ([self.itemArray count]==0)
	{
		result=[apiController getAllPublicWeibo:[MySingleton sharedSingleton].myTokenAll andFilter:@"" andFeed_id:@""];
		arr=result;
		for(id item in arr)
		{
			NSLog(@"item 是 %@",item);
			if([item isEqual:error_flag] )
			{
				NSLog(@"没有最新微博");
				return;
			}
			
		}
		
		for (id item in arr) 
		{
			
			NSMutableDictionary *row=item;
			
		//	avatar_url=[item objectForKey:@"user_avatar"];
			//get image with given url;
		//	NSURL *url=[NSURL URLWithString:avatar_url];
		//	UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
		//	[row setObject:image forKey:@"user_avatar"];
			
			//timestamp to time 
			NSString *timesp=[item objectForKey:@"create_time"];
			NSTimeInterval time=[timesp doubleValue];
			NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
			id mydate=[confromTimesp description];
			[row setObject:mydate forKey:@"create_time"];
			
			
			[self.itemArray addObject:row];
			
		}	
		NSLog(@"在第一个if里面元素个数是 %d",[self.itemArray count]);
		
	}
	else {
		id firstItem=[itemArray objectAtIndex:0];
		NSString *FeedId=[firstItem objectForKey:@"feed_id"];
		result=[apiController getAllPublicWeibo:[MySingleton sharedSingleton].myTokenAll andFilter:@"new" andFeed_id:FeedId];
		NSLog(@"新获得的内容：%@",result);
		arr=result;
		for(id item in arr)
		{
			NSLog(@"item 是 %@",item);
			if([item isEqual:error_flag] )
			{
				NSLog(@"没有最新微博");
				return;
			}
			
		}
		int numInTempArray=[arr count]-1;
		NSMutableArray *reArr=[NSMutableArray arrayWithCapacity:20];
		[reArr addObjectsFromArray:arr];
		for(id item in arr)
		{
			[reArr replaceObjectAtIndex:numInTempArray withObject:item];
			numInTempArray=numInTempArray-1;
		}
		NSLog(@"翻转后的数组：%@",reArr);
		for (id item in reArr) 
		{
			NSMutableDictionary *row=item;
			//avatar_url=[item objectForKey:@"user_avatar"];
			//get image with given url;
		//	NSURL *url=[NSURL URLWithString:avatar_url];
		//	UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
		//	[row setObject:image forKey:@"user_avatar"];
			
			//timestamp to time 
			NSString *timesp=[item objectForKey:@"create_time"];
			NSTimeInterval time=[timesp doubleValue];
			NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:time];
			id mydate=[confromTimesp description];
			[row setObject:mydate forKey:@"create_time"];
			
			
			[self.itemArray insertObject:row atIndex:0];
			
		}	
	}
	
	
	[apiController release];
	


	NSLog(@"多线程结束");
	
	[pool drain];
}
#pragma mark – 
#pragma mark UIScrollViewDelegate Methods 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView]; 
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{ 
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView]; 

} 
#pragma mark – 
#pragma mark EGORefreshTableHeaderDelegate Methods 
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource]; 
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0]; 
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading; 
} 
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];     
} 
@end
