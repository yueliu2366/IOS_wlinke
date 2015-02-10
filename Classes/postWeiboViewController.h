//
//  postWeiboViewController.h
//  wlinke
//
//  Created by Liu Terence on 12-3-17.
//  Copyright 2012 NCEPU. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface postWeiboViewController : UIViewController {
	IBOutlet UITextField *txt_postContent;

}

-(IBAction)btnPressed_Post;

@end
