//
//  User.m
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import "User.h"
#import "Message.h"

@interface User ()

@property (nonatomic, strong) NSMutableSet *followingSet;
@property (nonatomic, strong) NSMutableArray *timelineArray;
@end
@implementation User

- (instancetype)initWithUserName:(NSString *)userName
{
    self = [super init];
    if (self) {
        _userName = userName;
        _followingSet = [NSMutableSet new];
        _timelineArray = [NSMutableArray new];
    }
    return self;
}


- (NSSet *)following
{
    return [self.followingSet copy];
}

- (NSArray *)timeline
{
    return [self.timelineArray copy];
}

- (void)postMessage:(Message *)message
{
    [self.timelineArray addObject:message];
}

- (void)followUser:(User *)user
{
    [self.followingSet addObject:user];
}

- (NSArray *)wall
{
    NSMutableArray *allPosts = [[self timeline] mutableCopy];
    for (User *user in self.following) {
        [allPosts addObjectsFromArray:[user timeline]];
    }
    return [allPosts sortedArrayWithOptions:NSSortStable usingComparator:^NSComparisonResult(Message *obj1, Message* obj2) {
        return [obj1.timeOfMessage compare:obj2.timeOfMessage];
    }];
}


- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[User class]]) {
        return NO;
    }
    
    return [self isEqualToUser:object];
}

- (BOOL)isEqualToUser:(User *)user
{
    return [self.userName isEqualToString:user.userName];
}

- (NSUInteger)hash
{
    return [self.userName hash];
}
@end
