//
//  Bwitter.m
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import "Bwitter.h"
#import "Command.h"
#import "User.h"

@interface Bwitter ()

@property (nonatomic, strong) NSMutableArray *users;
@property (nonatomic, strong) NSMutableArray *commandHistory;
@end
@implementation Bwitter


- (instancetype)init
{
    self = [super init];
    if (self) {
        _users = [NSMutableArray new];
        _commandHistory = [NSMutableArray new];
    }
    return self;
}

+ (NSString *)messageToken
{
    return @"->";
}

- (NSArray *)executeCommandFromString:(NSString *)commandString
{
    Command *command = [self commandFromString:commandString];
    [self.commandHistory addObject:command];
    return [command execute];
}

- (Command *)commandFromString:(NSString *)commandString;
{
    //Split commands here!
    NSArray *components = [commandString componentsSeparatedByString:@" "];
    NSString *userName = components.firstObject;
    CommandAction action = Read;
    User *user = [self findOrCreateUserWithUserName:userName];
    User *targetUser = nil;
    NSString *messageText = nil;
    
    if (components.count == 1) { //Reading
        action = Read;
    } else if (components.count == 2) { //Wall
        action = Wall;
    } else if ([components[1] isEqualToString:[Bwitter messageToken]]) { //Post
        action = Post;
        NSInteger startOfMessage = userName.length + [Bwitter messageToken].length + 2; //2 Spaces and length of message token
        messageText = [commandString substringFromIndex: startOfMessage];
    } else if ([components[1] isEqualToString:@"follows"]) { //Follows
        action = Follow;
        targetUser = [self findUserWithUserName:components[2]];
    } else {
        NSAssert(false, @"Crash!");
    }
    
    return [[Command alloc] initWithUser:user action:action targetUser:targetUser messageText:messageText originalCommand:commandString];;
}


- (NSArray *)bwitterUsers
{
    return [self.users copy];
}


- (User *)findUserWithUserName:(NSString *)userName
{
    for (User *user in self.users) {
        if ([user.userName isEqualToString:userName]) {
            return user;
        }
    }
    return nil;
}

- (User *)findOrCreateUserWithUserName:(NSString *)userName
{
    User *user = [self findUserWithUserName:userName];
    if (!user) {
        user = [[User alloc] initWithUserName:userName];
        [self.users addObject:user];
    }
    return user;
}
@end
