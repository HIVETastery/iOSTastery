//
//  PageObject.h
//  Tastery
//
//  Created by Emman Kusumi on 9/22/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageObject : NSObject

@property (nonatomic) NSString *heading_title;
@property (nonatomic) NSString *page_description;

- (void) readFromDictionary:(NSDictionary *) dictionary;

@end
