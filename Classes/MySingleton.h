//
//  MySingleton.h
//  wlinke
//
//  Created by Liu Terence on 12-3-10.
//  Copyright 2012 NCEPU. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MySingleton : NSObject {
	NSString *myTokenAll;
}
+ (MySingleton *)sharedSingleton;
@property (nonatomic,retain) NSString *myTokenAll;
@end
