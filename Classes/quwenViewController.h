//
//  quwenViewController.h
//  wlinke
//
//  Created by Liu Terence on 11-12-10.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"EGORefreshTableHeaderView.h"
#define kNameValueTag     1
#define kUpdateValueTag    2
#define kActivityValueTag    3
#define kImageValueTag 4
#define KtranspondValueTag 5
#define KcommentValueTag 6
#define KtranspondLabelTag 7
#define KcommentLabelTag 8
#define Ktranspond_contentValueTag 9
#define Ktran_comValueTag 10
@interface quwenViewController : UIViewController 
<UITableViewDataSource, UITableViewDelegate,EGORefreshTableHeaderDelegate>{
	IBOutlet UITableView *myTableView; 
	EGORefreshTableHeaderView *_refreshHeaderView; 
    BOOL _reloading; 
	NSString *myToken;
	NSMutableArray  *itemArray;
}
@property(retain,nonatomic)UITableView *myTableView; 
@property(retain,nonatomic)NSString *myToken;
@property(retain,nonatomic)NSMutableArray *itemArray;
- (void)reloadTableViewDataSource; 
- (void)doneLoadingTableViewData; 
-(void)clickPostWeibo;
-(void)myGetData;
@end
