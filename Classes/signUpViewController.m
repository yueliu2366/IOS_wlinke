//
//  signUpViewController.m
//  wlinke
//
//  Created by Liu Terence on 11-12-1.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import "signUpViewController.h"
#import "loginViewController.h"
#import"iToast.h"
#import"apiViewController.h"
#import"ceoViewController.h"
@implementation signUpViewController

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
	//设置键盘
	txfldUserName.returnKeyType=UIReturnKeyDone;
	txfldRealName.returnKeyType=UIReturnKeyDone;
	txfldPassWord.returnKeyType=UIReturnKeyDone;
	txfldPassWord_confirm.returnKeyType=UIReturnKeyDone;
	txfldUserName.delegate=self;
	txfldRealName.delegate=self;
	txfldPassWord.delegate=self;
	txfldPassWord_confirm.delegate=self;
	[txfldPassWord setSecureTextEntry:YES];
	[txfldPassWord_confirm setSecureTextEntry:YES];
	
	
	
	// 注册键盘事件监听器，键盘消失和键盘显示
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)buttonPressed_login:(id)sender
{
	loginViewController *loginController=[[loginViewController alloc] init ];
	[self presentModalViewController:loginController animated:YES];
	[loginController release];
}

-(IBAction)buttonPressed_signUp:(id)sender//点击后触发小菊花
{
	//判断用户名密码是否为空
	if([txfldUserName.text length]==0){
		[[iToast makeText:@"请输入用户名"] show];
		return;
	}
	if([txfldRealName.text length]==0){
		[[iToast makeText:@"请输入姓名"] show];
		return;
	}
	if([txfldPassWord.text length]==0){
		[[iToast makeText:@"请输入密码"] show];
		return;
	}
	if([txfldPassWord_confirm.text length]==0){
		[[iToast makeText:@"请再次输入密码"] show];
		return;
	}
	
	if(![txfldPassWord.text isEqualToString:txfldPassWord_confirm.text])
	{
		[[iToast makeText:@"您两次输入的密码不同，请核对"] show];
		return;
	}
	baseAlert = [[[UIAlertView alloc] initWithTitle:@"正在提交，请等待" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];  
    [baseAlert show];  
	
    // Create and add the activity indicator  
    UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];  
    aiv.center = CGPointMake(baseAlert.bounds.size.width / 2.0f, baseAlert.bounds.size.height - 40.0f);  
    [aiv startAnimating];  
    [baseAlert addSubview:aiv];  
    [aiv release];
	[NSThread detachNewThreadSelector:@selector(multiThread_signup) toTarget:self withObject:nil];//启用多线程载入数据小菊花view
}

-(void)multiThread_signup//点击注册后，与服务器交互的函数
{
	apiViewController *apiController=[[apiViewController alloc] init ];
	NSString *useName=[txfldUserName text];
	NSString *passWord=[txfldPassWord text];
	NSString *realName=[txfldRealName text];
	NSString * flag=[[NSString alloc] initWithString: [apiController signUpWithUserName:useName andPassWord:passWord andRealName:realName]];
	[apiController release];
	
	[baseAlert dismissWithClickedButtonIndex:0 animated:YES];//结束多线程小菊花VIEW
	 
	if([flag isEqualToString:@"existing_user_login"])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" 
														message:@"该邮箱已被注册过"
													   delegate:nil 
											  cancelButtonTitle:@"确定" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	 if([flag isEqualToString:@"invalid_username"]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" 
														message:@"邮箱的格式错误"
													   delegate:nil 
											  cancelButtonTitle:@"确定" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		 return;
	}
	 if([flag isEqualToString:@"invalid_password"]){
		 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" 
														 message:@"密码必须是数字或字母的组合"
														delegate:nil 
											   cancelButtonTitle:@"确定" 
											   otherButtonTitles:nil];
		 [alert show];
		 [alert release];
		 return;
	}
	
	if([flag isEqualToString:@"invalid_displayname"]){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" 
														message:@"用户名必须是汉字，字母，数字，空格的组合"
													   delegate:nil 
											  cancelButtonTitle:@"确定" 
											  otherButtonTitles:nil];
		[alert show];
		[alert release];
		return;
	}
	
	baseAlert = [[[UIAlertView alloc] initWithTitle:@"注册成功，2秒后将自动跳转页面" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil] autorelease];  
    [baseAlert show];  
    // Create and add the activity indicator  
   // UIActivityIndicatorView *aiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];  
    //aiv.center = CGPointMake(baseAlert.bounds.size.width/2, baseAlert.bounds.size.height-40 );  
    //[aiv startAnimating];  
    //[baseAlert addSubview:aiv];  
    //[aiv release];
	[NSThread detachNewThreadSelector:@selector(multiThread_freeze) toTarget:self withObject:nil];//启用多线程载入数据小菊花view
	/*[NSTimer scheduledTimerWithTimeInterval:3.0f
                                     target:self
                                   selector:@selector(dismissAlert:)
                                   userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alert, @"alert", @"testing ", @"key" ,nil]  //如果不用传递参数，那么可以将此项设置为nil.
                                    repeats:NO];
	
*/

}

-(void)multiThread_freeze
{
	[NSThread sleepForTimeInterval:2.0];
	[baseAlert dismissWithClickedButtonIndex:0 animated:YES];//结束多线程小菊花VIEW
	ceoViewController *ceoController=[[ceoViewController alloc] init];
	[self presentModalViewController:ceoController animated:YES];
	[ceoController release];
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

	[textField resignFirstResponder];
	return YES;
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


@end
