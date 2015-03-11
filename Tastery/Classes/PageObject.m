//
//  PageObject.m
//  Tastery
//
//  Created by Emman Kusumi on 9/22/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "PageObject.h"

@implementation PageObject

- (void) readFromDictionary:(NSDictionary *) dictionary {

    for(NSString *key in [dictionary allKeys]) {
        id value = [dictionary valueForKey:key];
        
        if([key isEqualToString:@"description"]) {
            [self setPage_description:value];
        } else if([key isEqualToString:@"heading_title"]) {
            [self setHeading_title:value];
        }
    }
}

@end
