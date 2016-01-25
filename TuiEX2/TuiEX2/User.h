//
//  User.h
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Message;
@interface User : NSObject

@property (nonatomic, copy) NSString *userName;

//Returns set of users
- (NSSet *)following;
//Returns array of messages
- (NSArray *)timeline;
- (NSArray *)wall;

- (void)postMessage:(Message *)message;
- (void)followUser:(User *)user;


- (instancetype)initWithUserName:(NSString *)userName;
- (BOOL)isEqualToUser:(User *)user;




@end
