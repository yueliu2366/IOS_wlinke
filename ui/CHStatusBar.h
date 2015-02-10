//
//  CHStatusBar.h
//  BNS
//
//  Created by chenghaojun on 7/16/2011.
//  Copyright 2011 深圳趋势互联科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


//自定义状态栏，状态栏显示灰色背景并【indicator message】。用于耗时操作的状态栏信息提示
//例如：访问网络时，提示正在获取网络数据，或者正在提交数据至服务器等提示
@interface CHStatusBar : UIWindow {
	@private
		UILabel *lblStatus;
		UIActivityIndicatorView *indicator;
}


-(void)showWithStatusMessage:(NSString*)msg;
-(void)hide;


@end
