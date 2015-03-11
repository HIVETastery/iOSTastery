//
//  MenuObject.m
//  Tastery
//
//  Created by Emman Kusumi on 9/30/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "MenuObject.h"

@implementation MenuObject

- (void)readFromDictionary:(NSDictionary *) values {
    
    if([values respondsToSelector:@selector(allKeys)]) {
        for(id key in [values allKeys]) {
            id value = [values valueForKey:key];
            
            if([key isEqualToString:@"day"]) {
                [self setDay:value];
            } else if([key isEqualToString:@"description"]) {
                [self setMenu_description:value];
            } else if([key isEqualToString:@"href"]) {
                [self setHref:value];
            } else if([key isEqualToString:@"name"]) {
                [self setName:value];
            } else if([key isEqualToString:@"price"]) {
                [self setPrice:value];
            } else if([key isEqualToString:@"product_id"]) {
                [self setProduct_id:value];
            } else if([key isEqualToString:@"rating"]) {
                [self setRating:value];
            } else if([key isEqualToString:@"reviews"]) {
                [self setReviews:value];
            } else if([key isEqualToString:@"special"]) {
                [self setSpecial:value];
            } else if([key isEqualToString:@"thumb"]) {
                [self setThumb:value];
            }
            
        }
    }
}

@end


//day = Thursday;
//description = "<p>Spirals Pasta.Bacon.Pumpkin.Peas.Cream.Parmesan Cheese.Foccacia</p>
//\n";
//href = "http://tastery.ph/index.php?route=product/product&amp;product_id=61";
//name = "Bacon, Pumpkin and Peas Pasta";
//price = "\U20b1199.00";
//"product_id" = 61;
//rating = 0;
//reviews = "Based on 0 reviews.";
//special = 0;
//thumb = "http://tastery.ph/image/cache/data/october week 1/Bacon, Pumpkin and Peas Pasta-300x300.jpg";
