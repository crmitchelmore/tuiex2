//
//  TuiEX2Tests.m
//  TuiEX2Tests
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Bwitter.h"
#import "Command.h"
#import "User.h"
#import "Message.h"

@interface TuiEX2Tests : XCTestCase

@property (nonatomic, strong) Bwitter *bwitter;
@end

@implementation TuiEX2Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.bwitter = [Bwitter new];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testCreatingPostCommandCreatesUser
{
    XCTAssert([[self.bwitter bwitterUsers] count] == 0, @"Users count should be 0");
    
    [self alicePost1];
    XCTAssert([[self.bwitter bwitterUsers] count] == 1, @"Users count should be 2");
    
    User *alice = [self findAlice];
    XCTAssert([alice.userName isEqualToString:@"Alice"], @"User created with incorrect username");
    
    [self bobPost1];
    [self bobPost2];
    XCTAssert([[self.bwitter bwitterUsers] count] == 2, @"Users count should be 2");
}

- (void)testAliceCanPostMessageToTimeline
{
    [self alicePost1];
    User *alice = [self findAlice];

    XCTAssert([alice timeline].count == 1, @"Post not added to timeline");

    Message *firstMessage = [[alice timeline] firstObject];
    XCTAssert([firstMessage.messageText isEqualToString:@"I love the weather today"], @"Incorrect message created");
}

- (void)testICanViewAliceAndBobsTimelines
{
    [self first3posts];
    NSArray *results = [self.bwitter executeCommandFromString:@"Alice"];
    XCTAssert(results.count == 1, @"Should be 1 message returned to output");
    
    results = [self.bwitter executeCommandFromString:@"Bob"];
    XCTAssert(results.count == 2, @"Should be 2 message returned to output");
    
    User *bob = [self findBob];
    XCTAssert([bob timeline].count == 2, @"Posts not added to timeline");
}

- (void)testCharlieCanFollowAliceAndBob
{
    [self first3posts];
    [self charliePost1];
    User *charlie = [self findCharlie];
    XCTAssert(charlie.following.count == 0, @"Charlie should be following no one");
    User *alice = [self findAlice];
    [charlie followUser:alice];
    XCTAssert(charlie.following.count == 1, @"Charlie should be following 1 person");
    XCTAssert([[charlie.following anyObject] isEqualToUser:alice], @"Charlie should be following Alice");
    
    [charlie followUser:[self findBob]];
    XCTAssert(charlie.following.count == 2, @"Charlie should be following 2 people");
}

- (void)testCharlieCanSubscribeToAliceAndBobsTimelinesAndViewWall
{
    
    [self first3posts];
    [self charliePost1];
    User *charlie = [self findCharlie];
    User *alice = [self findAlice];
    User *bob = [self findBob];
    [charlie followUser:alice];

    NSArray *results = [self.bwitter executeCommandFromString:@"Charlie wall"];
    XCTAssert(results.count == 2, @"Should be 2 message returned to output");
    XCTAssert([charlie wall].count == 2, @"Should be 2 messages on Charlie's wall");

    [charlie followUser:bob];
    
    results = [self.bwitter executeCommandFromString:@"Charlie wall"];
    XCTAssert(results.count == 4, @"Should be 4 message returned to output");
    XCTAssert([charlie wall].count == 4, @"Should be 4 messages on Charlie's wall");
}


- (void)alicePost1 {[self.bwitter executeCommandFromString:@"Alice -> I love the weather today"];}
- (void)bobPost1 {[self.bwitter executeCommandFromString:@"Bob -> Damn! We lost!"];}
- (void)bobPost2 {[self.bwitter executeCommandFromString:@"Bob -> Good game though."];}
- (void)charliePost1 {[self.bwitter executeCommandFromString:@"Charlie -> I'm in New York today! Anyone want to have a coffee?"];}
- (void)first3posts { [self alicePost1]; [self bobPost1]; [self bobPost2]; }
- (User *)findAlice { return [self.bwitter findUserWithUserName:@"Alice"];}
- (User *)findBob { return [self.bwitter findUserWithUserName:@"Bob"];}
- (User *)findCharlie { return [self.bwitter findUserWithUserName:@"Charlie"];}
@end
