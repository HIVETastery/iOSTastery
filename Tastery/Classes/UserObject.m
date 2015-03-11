//
//  UserObject.m
//  One
//
//  Created by Emman Kusumi on 8/24/14.
//  Copyright (c) 2014 MicahBenn. All rights reserved.
//

#import "UserObject.h"

@implementation UserObject

- (void) readFromDictionary:(NSDictionary *) dictionary {
    for(NSString *key in [dictionary allKeys]) {
        id value = [dictionary valueForKey:key];
        if([key isEqualToString:@"name"]) {
            [self setName:value];
        } else if([key isEqualToString:@"address"]) {
            [self setAddress:value];
        } else if([key isEqualToString:@"mobile"]) {
            [self setMobile:value];
        } else if([key isEqualToString:@"email"]) {
            [self setEmail:value];
        } else if([key isEqualToString:@"notes"]) {
            [self setNotes:value];
        }
    }
}

@end
