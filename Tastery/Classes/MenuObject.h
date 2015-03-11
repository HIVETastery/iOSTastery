//
//  MenuObject.h
//  Tastery
//
//  Created by Emman Kusumi on 9/30/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuObject : NSObject

@property (nonatomic,copy) NSString *day;
@property (nonatomic,copy) NSString *menu_description;
@property (nonatomic,copy) NSString *href;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *price;
@property (nonatomic,copy) NSString *product_id;
@property (nonatomic,copy) NSString *rating;
@property (nonatomic,copy) NSString *reviews;
@property (nonatomic,copy) NSString *special;
@property (nonatomic,copy) NSString *thumb;

- (void)readFromDictionary:(NSDictionary *) values;

@end
