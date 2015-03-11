//
//  TasteryAccount.h
//  Tastery
//
//  Created by Emman Kusumi on 10/13/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TasteryAccount : NSObject

@property (nonatomic) NSString *address_id;
@property (nonatomic) NSString *address;
@property (nonatomic) BOOL approved;
@property (nonatomic) NSString *cart;
@property (nonatomic) NSString *confirm_code;
@property (nonatomic) NSString *customer_group_id;
@property (nonatomic) NSString *customer_id;
@property (nonatomic) NSString *date_added;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *fax;
@property (nonatomic) NSString *firstname;
@property (nonatomic) NSString *ip;
@property (nonatomic) NSString *lastname;
@property (nonatomic) NSString *mobile;
@property (nonatomic) NSString *newsletter;
@property (nonatomic) NSString *password;
@property (nonatomic) NSString *salt;
@property (nonatomic) NSString *status;
@property (nonatomic) NSString *store_id;
@property (nonatomic) NSString *telephone;
@property (nonatomic) NSString *token;
@property (nonatomic) NSString *wishlist;

- (void)readFromDictionary:(NSDictionary *) values;

@end

/*
account =     {
    "address_id" = 193;
    approved = 1;
    cart = "a:0:{}";
    "cart_sched" = "a:0:{}";
    "confirm_code" = "";
    "customer_group_id" = 1;
    "customer_id" = 178;
    "date_added" = "2014-10-01 22:06:33";
    email = "kusumimarkemman@gmail.com";
    fax = "";
    firstname = Emman;
    ip = "112.210.182.113";
    lastname = Kusumi;
    mobile = 11111111;
    newsletter = 0;
    password = 7a66eeec796f6b85743581b5b21e1ef7aa83abb1;
    salt = b709c38d8;
    status = 1;
    "store_id" = 0;
    telephone = 22222222;
    token = "";
    wishlist = "";
};
message =     {
    status = success;
};
session =     {
    data =         {
        cart =             {
            "100::" = 1;
            "101::" = 1;
            "102::" = 1;
        };
        "cart_sched" =             {
            "100::" =                 {
                "delivery_date" = 0;
                dtime = "";
                odate = 1413253531;
                place = "<null>";
            };
            "101::" =                 {
                "delivery_date" = 0;
                dtime = "";
                odate = 1413253531;
                place = "<null>";
            };
            "102::" =                 {
                "delivery_date" = 0;
                dtime = "";
                odate = 1413253531;
                place = "<null>";
            };
        };
        currency = PHP;
        "customer_id" = 178;
        "fb_145634418964354_state" = 069b6e9e5cdc4d06cb69494a49ac83ea;
        language = en;
        "setting_twitter" =             {
            "layout_id" = 1;
            "not_use_selector" = 1;
            position = "content_top";
            selector = "";
            "sort_order" = "-1";
            status = 1;
        };
        vouchers =             (
        );
    };
};
*/