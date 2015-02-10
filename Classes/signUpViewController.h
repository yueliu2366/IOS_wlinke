//
//  signUpViewController.h
//  wlinke
//
//  Created by Liu Terence on 11-12-1.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface signUpViewController : UIViewController<UITextFieldDelegate> {
	IBOutlet UITextField *txfldUserName;
	IBOutlet UITextField *txfldRealName;
	IBOutlet UITextField *txfldPassWord;
	IBOutlet UITextField *txfldPassWord_confirm;
	IBOutlet UIScrollView *scrlviewLogin;
	UITextField *activeField;
	UIAlertView *baseAlert;

}
-(IBAction)buttonPressed_login:(id)sender;
-(IBAction)buttonPressed_signUp:(id)sender;
@end
