//
//  loginViewController.h
//  wlinke
//
//  Created by Liu Terence on 11-11-30.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface loginViewController : UIViewController<UITextFieldDelegate> {
	IBOutlet UITextField *txfldUserName;
	IBOutlet UITextField *txfldPassWord;
	IBOutlet UIButton *btnCheckBox;
	IBOutlet UIScrollView *scrlviewLogin;
	BOOL checkBox;
	UITextField *activeField;
	UIAlertView *baseAlert;
}
/*@property(nonatomic,retain)  UIButton *txfldUserName;
@property(nonatomic,retain)  UIButton  *txfldPassWord;
@property(nonatomic,retain)  UIButton  */
-(IBAction)buttonPressed_login:(id)sender;
-(IBAction)buttonPressed_signUp:(id)sender;
-(IBAction)buttonPressed_checkBox:(id)sender;
-(void)multiThread_login;
@end
