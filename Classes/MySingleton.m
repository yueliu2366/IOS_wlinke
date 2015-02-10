//
//  MySingleton.m
//  wlinke
//
//  Created by Liu Terence on 12-3-10.
//  Copyright 2012 NCEPU. All rights reserved.
//

#import "MySingleton.h"


@implementation MySingleton
@synthesize myTokenAll;
+ (MySingleton *)sharedSingleton
{
	static MySingleton *sharedSingleton;
	
	@synchronized(self)
	{
		if (!sharedSingleton)
			sharedSingleton = [[MySingleton alloc] init];
		
		return sharedSingleton;
	}
}
@end
