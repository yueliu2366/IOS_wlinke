//
//  shequViewController.h
//  wlinke
//
//  Created by Liu Terence on 11-12-10.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KGNameValueTag 1
#define KGTypeValueTag 2
#define KGNumValueTag 3
#define KGDecpValueTag 4
#define KGTimeValueTag 5
#define KGIdValueTag 6

@interface shequViewController : UIViewController
<UITableViewDataSource, UITableViewDelegate>{
	IBOutlet UITableView *myTableView; 
	NSMutableArray *itemArray;
	UIAlertView *baseAlert;

}
@property(retain,nonatomic)UITableView *myTableView; 
@property(retain,nonatomic)	NSMutableArray *itemArray;
-(void)btnPressed_myGroup;
-(void)refreshMyGroup;
@end
