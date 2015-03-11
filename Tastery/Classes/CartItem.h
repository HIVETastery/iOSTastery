//
//  CartItem.h
//  Tastery
//
//  Created by Emman Kusumi on 9/17/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartItem : NSObject

@property (nonatomic) NSString *ddate;
@property (nonatomic) NSMutableArray *dtime;
@property (nonatomic) NSString *href;
@property (nonatomic) NSString *key;
@property (nonatomic) NSString *model;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *odate;
@property (nonatomic) NSMutableArray *option;
@property (nonatomic) NSString *place;
@property (nonatomic) NSString *price;
@property (nonatomic) NSString *profile_description;
@property (nonatomic) NSString *profile_name;
@property (nonatomic) NSNumber *quantity;
@property (nonatomic) NSString *recurring;
@property (nonatomic) NSString *remove;
@property (nonatomic) NSString *reward;
@property (nonatomic) NSNumber *stock;
@property (nonatomic) NSString *thumb;
@property (nonatomic) NSString *total;
@property (nonatomic) NSString *deliveryTime;

- (void)readFromDictionary:(NSDictionary *) values;

@end
