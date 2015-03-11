//
//  DateManager.h
//  Tastery
//
//  Created by Emman Kusumi on 10/20/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateManager : NSDate

+ (NSDate *) convertJSONDateToNSDate:(NSNumber *) ticks;
+ (NSString *) stringForDate:(NSDate *) date;
+ (NSString *) stringForTime:(NSDate *) time;

@end
