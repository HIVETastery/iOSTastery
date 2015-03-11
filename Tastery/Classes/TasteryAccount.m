//
//  TasteryAccount.m
//  Tastery
//
//  Created by Emman Kusumi on 10/13/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "TasteryAccount.h"

@implementation TasteryAccount

- (void)readFromDictionary:(NSDictionary *) values {
    
    if([values respondsToSelector:@selector(allKeys)]) {
        for(id key in [values allKeys]) {
            @try {
                id value = [values valueForKey:key];
                if([key isEqualToString:@"approved"]) {
                    if([value isEqualToString:@"1"]) {
                        [self setApproved:YES];
                    }
                } else if([key isEqualToString:@"cart"]) {
                } else if([key isEqualToString:@"cart_sched"]) {
                } else if([key isEqualToString:@"description"]) {
                } else if([key isEqualToString:@"name"]) {
                    [self setFirstname:value];
                } else if([key isEqualToString:@"first_name"]) {
                    [self setFirstname:value];
                } else if([key isEqualToString:@"last_name"]) {
                    [self setLastname:value];
                } else {
                    if([self respondsToSelector:NSSelectorFromString(key)]) {
                        [self setValue:value forKey:key];
                    } else {
                        // [self setValue:value forKey:key];
                    }
                }
            }
            @catch (NSException *exception) {
                NSLog(@"Undefined Key : %@", key);
            }
        }
    }
}

/*
 {
 email = "kusumi.emman@gmail.com";
 "first_name" = Emman;
 gender = male;
 id = 1419434441631326;
 "last_name" = Kusumi;
 link = "https://www.facebook.com/app_scoped_user_id/1419434441631326/";
 locale = "en_US";
 name = "Emman Kusumi";
 timezone = 8;
 "updated_time" = "2014-11-27T14:05:50+0000";
 verified = 0;
 }
 */

@end
