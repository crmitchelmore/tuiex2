//
//  Command.h
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CommandAction) {
    Read,
    Post,
    Follow,
    Wall
};

@class User, Message;
@interface Command : NSObject

@property (nonatomic, copy) NSString *originalCommand;
@property (nonatomic, strong, readonly) User *user;
@property (nonatomic, assign, readonly) CommandAction action;
@property (nonatomic, strong, readonly) User *targetUser;
@property (nonatomic, strong, readonly) Message *message;
@property (nonatomic, assign, readonly) BOOL executed;



- (instancetype)initWithUser:(User *)user action:(CommandAction)action targetUser:(User *)target messageText:(NSString *)messageText originalCommand:(NSString *)originalCommand;

// Executes the command and returns an array of strings to write to the screen. Returns nil when nothing to write. Commands can only be executed once and would return an error. Check executed property
- (NSArray *)execute;
@end
