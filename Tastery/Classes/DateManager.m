//
//  DateManager.m
//  Tastery
//
//  Created by Emman Kusumi on 10/20/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "DateManager.h"

@implementation DateManager

+ (NSDate *) convertJSONDateToNSDate:(NSNumber *) ticks {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[ticks doubleValue]];
    return date;
}

+ (NSString *) stringForDate:(NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:date];
    return formattedDateString;
}

+ (NSString *) stringForTime:(NSDate *) time {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSString *formattedDateString = [dateFormatter stringFromDate:time];
    return formattedDateString;
}

@end
