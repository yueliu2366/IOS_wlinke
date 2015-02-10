//
//  apiViewController.h
//  wlinke
//
//  Created by Liu Terence on 11-12-1.
//  Copyright 2011 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>

//用户名和密码保存的key值，用户名和密码保存在keychain中。
extern NSString * const KEY_USERNAME_PASSWORD;
extern NSString * const KEY_USERNAME;
extern NSString * const KEY_PASSWORD;

extern  NSString * const  SERVER_URL ;
extern NSString * const METHOD_LOGIN ;
extern NSString *const METHOD_ADDUSER;

@interface apiViewController : UIViewController {
	
}

-(BOOL)loginWithUserName:(NSString *)userName andPassword:(NSString *)passWord;
-(NSString *)signUpWithUserName:(NSString *)userName andPassWord:(NSString *)passWord andRealName:(NSString *)realName;
-(id)getAllPublicWeibo:(NSString *)token andFilter:(NSString *)filter andFeed_id:(NSString *)feed_id;
-(void)postWeibo:(NSString *)token andContent:(NSString *)content andvisibility:(NSString *)visibility;
-(id)getGroupData:(NSString *)token  andIs_admin:(NSString *)is_admin andpage:(NSString *)page andpage_count:(NSString *)page_count;
@end
