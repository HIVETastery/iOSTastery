//
//  TasteryAPIManager.h
//  Tastery
//
//  Created by Emman Kusumi on 9/17/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageObject.h"
#import "MenuObject.h"
#import "CartItem.h"
#import "TasteryAccount.h"

@interface TasteryAPIManager : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    void (^completionBlock) (id object);
}

@property (nonatomic) NSString *currentUsername, *currentPassword;
@property (nonatomic) NSString *currentCity;
@property (nonatomic) NSDate *currentDate;
@property (nonatomic) NSMutableData *receivedData;

+ (TasteryAPIManager *) getTasteryAPIManager;
+ (void) cancelAPIManager;

- (void)getWhoWeAreWithCallback:(void (^)(PageObject *page))callback;
- (void)getWhatWeDoWithCallback:(void (^)(PageObject *page))callback;
- (void)getWhyWeDoWithCallback:(void (^)(PageObject *page))callback;
- (void)getHowWeDoWithCallback:(void (^)(PageObject *page))callback;
- (void)getGiftWithCallback:(void (^)(PageObject *page))callback;
- (void)getCartWithCallback:(void (^)(NSMutableArray *menuList)) callback;

- (void)getMenuWithCallback:(void (^)(NSMutableArray *menuList)) callback;
- (void)addToCartProductId:(NSString *) productId
                  quantity:(NSString *) quantity
                     place:(NSString *) place
              deliveryDate:(NSString *) deliveryDate
              WithCallback:(void (^)(NSDictionary *info))callback;
- (void)confirmCheckoutWithAddressId:(NSString *) addressId
                     shippingAddress:(NSString *) address
                        withCallback:(void (^)(NSDictionary *checkout))callback;
- (void)confirmOrderWithCallback:(void (^)(NSMutableDictionary *info)) callback;
- (void)confirmCheckOut:(void (^)(NSMutableDictionary *info)) callback;
- (void)validatePayment:(void (^)(NSMutableDictionary *info)) callback;
- (void)logoutWithCallback:(void (^)(NSMutableDictionary *info)) callback;
- (void)finalCheckout:(void (^)(NSMutableDictionary *info)) callback;

- (void)loginWithUsername:(NSString *) username
                 Password:(NSString *) password
             withCallback:(void (^)(TasteryAccount *account))callback;

- (void)registerWithFirstName:(NSString *) firstName
                     lastName:(NSString *) lastName
                        email:(NSString *) email
                       mobile:(NSString *) mobile
                    telephone:(NSString *) telephone
                      company:(NSString *) company
                     address1:(NSString *) address_1
                     address2:(NSString *) address_2
                         city:(NSString *) city
                     password:(NSString *) password withCallback:(void (^)(NSDictionary *info))callback;

- (void)registerSocialWithFirstName:(NSString *) firstName
                     lastName:(NSString *) lastName
                        email:(NSString *) email
                 withCallback:(void (^)(NSDictionary *info))callback;

- (void)forgotPasswordForEmail:(NSString *) email
                  withCallback:(void (^)(NSDictionary *info))callback;

- (void)postContactUsWithName:(NSString *) name
                       Mobile:(NSString *) mobile
                        Email:(NSString *) email
                      Enquiry:(NSString *) enquiry
                      Captcha:(NSString *) captcha
                 withCallback:(void (^)(NSDictionary *info))callback;

- (void)saveProfileWithFirstName:(NSString *) firstName
                        lastName:(NSString *) lastName
                           email:(NSString *) email
                          mobile:(NSString *) mobile
                       telephone:(NSString *) telephone
                         company:(NSString *) company
                        address1:(NSString *) address_1
                        address2:(NSString *) address_2
                            city:(NSString *) city
                        password:(NSString *) password
                    withCallback:(void (^)(NSDictionary *info))callback;
- (NSString *)getStringFromDate:(NSDate *) date;

@end
