//
//  Bwitter.h
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User, Command;
@interface Bwitter : NSObject

- (NSArray *)bwitterUsers;
- (NSArray *)executeCommandFromString:(NSString *)commandString;

- (Command *)commandFromString:(NSString *)commandString;
- (User *)findUserWithUserName:(NSString *)userName;
@end
