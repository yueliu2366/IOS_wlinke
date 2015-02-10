//
//  loginViewController.m
//  wlinke
//
//  Created by Liu Terence on 11-11-30.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import "loginViewController.h"
#import"ceoViewController.h"
#import"CHKeychain.h"
#import"iToast.h"
#import"CHStatusBar.h"

#import"signUpViewController.h"
#import"apiViewController.h"
@implementation loginViewController




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

	checkBox=YES;
	//设置记住密码按钮的图片
	[btnCheckBox setBackgroundImage:[UIImage imageNamed:@"checkbox_nor.png"] forState:UIControlStateNormal];
	[btnCheckBox setBackgroundImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateSelected];
	[btnCheckBox setBackgroundImage:[UIImage imageNamed:@"checkbox_checked.png"] forState:UIControlStateHighlighted];
	btnCheckBox.adjustsImageWhenHighlighted=YES;
	btnCheckBox.selected=checkBox;
	
	//设置键盘
	txfldUserName.returnKeyType=UIReturnKeyNext;
	txfldPassWord.returnKeyType=UIReturnKeyGo;
	txfldUserName.delegate=self;
	txfldPassWord.delegate=self;
	[txfldPassWord setSecureTextEntry:YES];
	
	NSMutableDictionary *usernamepasswordKVPairs = (NSMutableDictionary *)[CHKeychain load:KEY_USERNAME_PASSWORD];
	txfldUserName.text = [usernamepasswordKVPairs objectForKey:KEY_USERNAME];
	txfldPassWord.text = [usernamepasswordKVPairs objectForKey:KEY_PASSWORD];
	
	
	// 注册键盘事件监听器，键盘消失和键盘显示
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];

}

-(IBAction)buttonPressed_login:(id)sender//点击登陆后触发小菊花
{
	//判断用户名密码是否为空
	if([txfldUserName.text length]==0){
		[[iToast makeText:@"请输入用户名"] show];
		return;
	}
	if([txfldPassWord.text length]==0){
		[[iToast makeText:@"请输入密码"] show];
		return;
	}
	
	baseAlert = [[[UIAlertView alloc] initWithTitle:@"正在登陆" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];  
    [baseAlert show];  
	
    // Create and add the activity indicator  
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];  
    aiv.center = CGPointMake(baseAlert.bounds.size.width / 2.0f, baseAlert.bounds.size.height - 40.0f);  
    [aiv startAnimating];  
    [baseAlert addSubview:aiv];  
    [aiv release];
	//[NSThread detachNewThreadSelector:@selector(multiThread_login) toTarget:self withObject:nil];//启用多线程载入数据小菊花view
	[self performSelectorInBackground:@selector(multiThread_login) withObject:nil];//与上句等效，用于同个对象中开新线程。
	
}


-(void)multiThread_login//点击登陆后，与服务器交互的函数
{
	 NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];//防止just leaking!
	
	
	apiViewController *apiController=[[apiViewController alloc] init ];
	NSString *useName=[txfldUserName text];
	NSString *passWord=[txfldPassWord text];
	
	BOOL flag=[apiController loginWithUserName:useName andPassword:passWord];
	[apiController release];

[baseAlert dismissWithClickedButtonIndex:0 animated:YES];//结束多线程小菊花VIEW
	
	// TODO 登录成功之后记录密码
	if (flag==YES) {
		if(checkBox==YES){
			NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
			[usernamepasswordKVPairs setObject:txfldUserName.text forKey:KEY_USERNAME];
			[usernamepasswordKVPairs setObject:txfldPassWord.text forKey:KEY_PASSWORD];
			[CHKeychain save:KEY_USERNAME_PASSWORD data:usernamepasswordKVPairs];
		}
		//此处present正常登陆界面语句
		ceoViewController *ceoController=[[ceoViewController alloc] init];
		ceoController.userName=[txfldUserName text];
		ceoController.passWord=txfldPassWord.text;
		[self presentModalViewController:ceoController.mainTabbarController animated:YES];
		[ceoController release];

		
	}else {
		[CHKeychain delete:KEY_USERNAME_PASSWORD];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" 
														message:@"账号或密码错误，请重新输入"
													   delegate:nil 
											  cancelButtonTitle:@"确定" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
	
	
	[pool drain];// prevent from just leaking
	

}

-(IBAction)buttonPressed_signUp:(id)sender
{
	signUpViewController *signUpController=[[signUpViewController alloc] init];
	[self presentModalViewController:signUpController animated:YES];
	[signUpController release];
}

-(IBAction)buttonPressed_checkBox:(id)sender
{

	
	checkBox=(!checkBox);
	
	[btnCheckBox setSelected:checkBox];
}

#pragma mark -
#pragma mark 滚动scrollview 使被隐藏的textfield显示在屏幕正确的位置（软键盘的上方）
// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification {
	NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
	
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrlviewLogin.contentInset = contentInsets;
    scrlviewLogin.scrollIndicatorInsets = contentInsets;
	
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
	// 输入项区域被认为定高
	CGPoint activeFieldRect = activeField.frame.origin;
	activeFieldRect.y += 80;//本句用来调整滚动的幅度，艹，一句话不就完了。搞那么多麻烦的封装干什么呢！架构比较重要，不是这么个屁语法。
    if (!CGRectContainsPoint(aRect, activeFieldRect) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeFieldRect.y-kbSize.height);
        [scrlviewLogin setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrlviewLogin.contentInset = contentInsets;
    scrlviewLogin.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	switch (textField.returnKeyType) {
		case UIReturnKeyNext:
			[txfldPassWord becomeFirstResponder];
			break;
		case UIReturnKeyGo:
			[textField resignFirstResponder];
			//[self login:btn];
			break;
		default:
			break;
	}
	return YES;
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
	[txfldUserName dealloc];
	[txfldPassWord dealloc];
	[btnCheckBox dealloc];
	[scrlviewLogin dealloc];
	
}


@end
