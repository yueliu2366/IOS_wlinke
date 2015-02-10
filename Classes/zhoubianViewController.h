//
//  zhoubianViewController.h
//  wlinke
//
//  Created by Liu Terence on 11-12-10.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kMemberCountValueTag 1
#define kCreateTimeValueTag 2
#define kNameValueTag 3
#define kCategoryValueTag 4
#define kDescriptionValueTag 5

@interface zhoubianViewController : UIViewController {
	IBOutlet UITableView *myTableView; 
	NSMutableArray *itemArray;
	UIAlertView *baseAlert;
}
@property(retain,nonatomic)UITableView *myTableView; 
@property(retain,nonatomic)	NSMutableArray *itemArray;
-(void)buttonPressed_allPlaces;
-(void)refreshAllPlaces;
@end
