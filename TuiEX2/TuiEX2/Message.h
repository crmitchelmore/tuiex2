//
//  Message.h
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, MessageFormat) {
    WallFormat,
    TimelineFormat
};
@class User;
@interface Message : NSObject

@property (nonatomic, copy) NSString *messageText;
@property (nonatomic, copy) NSDate *timeOfMessage;
@property (nonatomic, strong, readonly) User *user; //Keep a reference to the poster so we can format messages for the wall


- (instancetype)initWithUser:(User *)user messageText:(NSString *)messageText;
- (NSString *)formattedMessageFor:(MessageFormat)format;
+ (NSArray *)stringsFromMessages:(NSArray *)messages inFormat:(MessageFormat)format;
@end
