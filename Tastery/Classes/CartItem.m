//
//  CartItem.m
//  Tastery
//
//  Created by Emman Kusumi on 9/17/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "CartItem.h"
#import "DateManager.h"

@implementation CartItem

- (void)readFromDictionary:(NSDictionary *) values {
    
    if([values respondsToSelector:@selector(allKeys)]) {
        for(id key in [values allKeys]) {
            id value = [values valueForKey:key];
            
            if([key isEqualToString:@"ddate"]) {
                [self setDdate:value];
            } else if([key isEqualToString:@"dtime"]) {
                [self setDtime:value];
            } else if([key isEqualToString:@"href"]) {
                [self setHref:value];
            } else if([key isEqualToString:@"key"]) {
                [self setKey:value];
            } else if([key isEqualToString:@"model"]) {
                [self setModel:value];
            } else if([key isEqualToString:@"name"]) {
                [self setName:value];
            } else if([key isEqualToString:@"odate"]) {
                // NSDate *date = [DateManager convertJSONDateToNSDate:value];
                [self setOdate:value];
            } else if([key isEqualToString:@"option"]) {
                [self setOption:value];
            } else if([key isEqualToString:@"place"]) {
                [self setPlace:value];
            } else if([key isEqualToString:@"price"]) {
                [self setPrice:value];
            } else if([key isEqualToString:@"profile_description"]) {
                [self setProfile_description:value];
            } else if([key isEqualToString:@"profile_name"]) {
                [self setProfile_name:value];
            } else if([key isEqualToString:@"quantity"]) {
                [self setQuantity:value];
            } else if([key isEqualToString:@"recurring"]) {
                [self setRecurring:value];
            } else if([key isEqualToString:@"remove"]) {
                [self setRemove:value];
            } else if([key isEqualToString:@"reward"]) {
                [self setReward:value];
            } else if([key isEqualToString:@"stock"]) {
                [self setStock:value];
            } else if([key isEqualToString:@"thumb"]) {
                [self setThumb:value];
            } else if([key isEqualToString:@"total"]) {
                [self setTotal:value];
            }
            
        }
    }
}

@end