//
//  postWeiboViewController.m
//  wlinke
//
//  Created by Liu Terence on 12-3-17.
//  Copyright 2012 NCEPU. All rights reserved.
//

#import "postWeiboViewController.h"
#import"iToast.h"
#import"apiViewController.h"
#import"MySingleton.h"

@implementation postWeiboViewController

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)btnPressed_Post
{
	if([txt_postContent.text length]==0){
		[[iToast makeText:@"发送内容不能为空。"] show];
		return;
	} 
	 apiViewController *apiController=[[apiViewController alloc] init ];
	[apiController postWeibo:[MySingleton sharedSingleton].myTokenAll andContent:txt_postContent.text andvisibility:@"public"];
	 [apiController release];
	 
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
