//
//  Command.m
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import "Command.h"
#import "Message.h"
#import "User.h"

@interface Command ()
@property (nonatomic, assign) BOOL executed;
@end

@implementation Command


- (instancetype)initWithUser:(User *)user action:(CommandAction)action targetUser:(User *)target messageText:(NSString *)messageText originalCommand:(NSString *)originalCommand
{
    self = [super init];
    if (self) {
        _user = user;
        _action = action;
        _targetUser = target;
        _message = [[Message alloc] initWithUser:user messageText:messageText];
        _originalCommand = originalCommand;
        _executed = NO;
    }
    return self;
}


- (NSArray *)execute
{
    if (!self.executed) {
        self.executed = YES;
        switch (self.action) {
            case Read:
                return [Message stringsFromMessages:[self.user timeline] inFormat:TimelineFormat];
                break;
            case Post:
                [self.user postMessage:self.message];
                break;
            case Follow:
                [self.user followUser:self.targetUser];
                break;
            case Wall:
                return [Message stringsFromMessages:[self.user wall] inFormat:WallFormat];
                break;
        }
    }
    return nil;
}


@end
