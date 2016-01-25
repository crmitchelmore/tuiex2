//
//  Message.m
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import "Message.h"
#import "User.h"

@implementation Message

- (instancetype)initWithUser:(User *)user messageText:(NSString *)messageText;
{
    self = [super init];
    if (self) {
        _messageText = messageText;
        _timeOfMessage = [NSDate date];
        _user = user;
    }
    return self;
}

+ (NSDateFormatter *)messageDateFormatter
{
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [NSDateFormatter new];
        formatter.doesRelativeDateFormatting = YES;
        formatter.dateStyle = NSDateFormatterNoStyle;
        formatter.timeStyle = NSDateFormatterShortStyle;

    }
    return formatter;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ - %@ (%@)", self.user.userName, self.messageText, [[Message messageDateFormatter] stringFromDate:self.timeOfMessage]];
}

- (NSString *)formattedMessageFor:(MessageFormat)format
{
    if (format == TimelineFormat) {
        return [NSString stringWithFormat:@"%@ (%@)", self.messageText, [[Message messageDateFormatter] stringFromDate:self.timeOfMessage]];
    }
    return [self description];
}

+ (NSArray *)stringsFromMessages:(NSArray *)messages inFormat:(MessageFormat)format
{
    NSMutableArray *strings = [NSMutableArray new];
    for (Message *message in messages) {
        [strings addObject: [message formattedMessageFor:format]];
    }
    return strings;
}
@end
