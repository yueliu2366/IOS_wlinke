//
//  ceoViewController.h
//  wlinke
//
//  Created by Liu Terence on 11-12-2.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ceoViewController : UITabBarController {
	UITabBarController *mainTabbarController;
	NSString *userName;
	NSString *passWord;
	

}
@property(nonatomic,retain)UITabBarController *mainTabbarController;
@property(nonatomic,retain)NSString *userName;
@property(nonatomic,retain)NSString *passWord;

-(void)changeTokenValue;
@end
