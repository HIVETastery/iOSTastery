//
//  TasteryAPIManager.m
//  Tastery
//
//  Created by Emman Kusumi on 9/17/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "TasteryAPIManager.h"
#import "NSString+HTML.h"

#define mainUrl @"http://tastery.ph/index.php?route="

#define whoWeArePath        @"product/category&path=60&json"
#define whatWeDoPath        @"product/category&path=61&json"
#define whyWeDoItPath       @"product/category&path=62&json"
#define howWeDoItPath       @"product/category&path=63&json"
#define giftPath            @"product/category&path=64_65&json"
#define loginPath           @"account/login&json"
#define logoutPath          @"account/logout"
#define forgotPasswordPath  @"account/forgotten"
#define registerPath        @"account/register&json"
#define registerSocialPath  @"account/getfb&json"
#define menuPath            @"common/home&json"
#define addToCartPath       @"checkout/cart/add"
#define viewCartPath        @"checkout/cart&json"
#define checkoutPath        @"checkout/shipping_address/validate"
#define validatePaymentPath @"checkout/payment_method/validate"
#define confirmOrderPath    @"checkout/confirm&json"
#define validateAccountPath @"checkout/register/validate"
#define finalCheckoutPath   @"checkout/checkout"
#define contactUsPath       @"information/contact&json"
#define generateCaptchaPath @"information/contact/captcha"
#define confirmCheckoutPath @"payment/cod/confirm"

@implementation TasteryAPIManager

static TasteryAPIManager *tasteryAPIManager = nil;

+ (TasteryAPIManager *) getTasteryAPIManager {
    if(tasteryAPIManager == nil) {
        tasteryAPIManager = [TasteryAPIManager new];
    }
    return tasteryAPIManager;
}

+ (void) cancelAPIManager {
    tasteryAPIManager = nil;
}

- (void)getWhoWeAreWithCallback:(void (^)(PageObject *page))callback {
    completionBlock = callback;
    [self makeGetRequestForPath:whoWeArePath];
}

- (void)getWhatWeDoWithCallback:(void (^)(PageObject *page))callback {
    completionBlock = callback;
    [self makeGetRequestForPath:whatWeDoPath];
}

- (void)getWhyWeDoWithCallback:(void (^)(PageObject *page))callback {
    completionBlock = callback;
    [self makeGetRequestForPath:whyWeDoItPath];
}

- (void)getHowWeDoWithCallback:(void (^)(PageObject *page))callback {
    completionBlock = callback;
    [self makeGetRequestForPath:howWeDoItPath];
}

- (void)getGiftWithCallback:(void (^)(PageObject *page))callback {
    completionBlock = callback;
    [self makeGetRequestForPath:giftPath];
}

- (void)getMenuWithCallback:(void (^)(NSMutableArray *menuList)) callback {
    completionBlock = callback;
    [self makeGetRequestForPath:menuPath];
}

- (void)getCartWithCallback:(void (^)(NSMutableArray *menuList)) callback {
    completionBlock = callback;
    [self makeGetRequestForPath:viewCartPath];
}

- (void)confirmOrderWithCallback:(void (^)(NSMutableDictionary *info)) callback {
    completionBlock = callback;
    [self makeGetRequestForPath:confirmOrderPath];
}

- (void)logoutWithCallback:(void (^)(NSMutableDictionary *info)) callback {
    completionBlock = callback;
    [self makeGetRequestForPath:logoutPath];
}

- (void)finalCheckout:(void (^)(NSMutableDictionary *info)) callback {
    completionBlock = callback;
    [self makeGetRequestForPath:finalCheckoutPath];
}

- (void)loginWithUsername:(NSString *) username
                 Password:(NSString *) password
             withCallback:(void (^)(TasteryAccount *account))callback {
    
    NSDictionary *login = [[NSDictionary alloc] initWithObjectsAndKeys:username,@"email",password,@"password",nil];
    [self setCurrentUsername:username];
    [self setCurrentPassword:password];
    
    completionBlock = callback;
    [self makePostRequestForPath:loginPath withValues:login];
}

- (void)registerWithFirstName:(NSString *) firstName
                     lastName:(NSString *) lastName
                        email:(NSString *) email
                       mobile:(NSString *) mobile
                    telephone:(NSString *) telephone
                      company:(NSString *) company
                     address1:(NSString *) address_1
                     address2:(NSString *) address_2
                         city:(NSString *) city
                     password:(NSString *) password
                 withCallback:(void (^)(NSDictionary *info))callback {
    
    NSDictionary *signup = [[NSDictionary alloc] initWithObjectsAndKeys:firstName,@"firstname",lastName,@"lastname",email,@"email",mobile,@"mobile",telephone,@"telephone",@"--",@"company",address_1,@"address_1",@"--",@"address_2",city,@"city",password,@"password",password,@"confirm",@"1",@"agree",nil];
    
    completionBlock = callback;
    [self makePostRequestForPath:registerPath withValues:signup];
}

- (void)registerSocialWithFirstName:(NSString *) firstName
                     lastName:(NSString *) lastName
                        email:(NSString *) email
                 withCallback:(void (^)(NSDictionary *info))callback {
    
    NSDictionary *signup = [[NSDictionary alloc] initWithObjectsAndKeys:firstName,@"firstname",lastName,@"lastname",email,@"email",nil];
    
    completionBlock = callback;
    [self makePostRequestForPath:registerSocialPath withValues:signup];
}

- (void)forgotPasswordForEmail:(NSString *) email
                  withCallback:(void (^)(NSDictionary *info))callback {
    
    NSDictionary *password = [[NSDictionary alloc] initWithObjectsAndKeys:email,@"email",nil];
    
    completionBlock = callback;
    [self makePostRequestForPath:forgotPasswordPath withValues:password];
}

- (void)addToCartProductId:(NSString *) productId
                     quantity:(NSString *) quantity
                        place:(NSString *) place
                 deliveryDate:(NSString *) deliveryDate
                 WithCallback:(void (^)(NSDictionary *info))callback {
    
    completionBlock = callback;
    
    // 'product_id=' + product_id + '&quantity=' + quantity+ '&place=' + place+ '&deliverydate=' + delivery_date,
    
    NSDictionary *cart = [[NSDictionary alloc] initWithObjectsAndKeys:productId,@"product_id",quantity,@"quantity",place,@"place",deliveryDate,@"deliverydate",nil];
    [self makePostRequestForPath:addToCartPath withValues:cart];
}

- (void)confirmCheckoutWithAddressId:(NSString *) addressId
                     shippingAddress:(NSString *) address
                        withCallback:(void (^)(NSDictionary *checkout))callback {
    
    completionBlock = callback;
    
    NSDictionary *checkOut = [[NSDictionary alloc] initWithObjectsAndKeys:address,@"shipping_address",addressId,@"address_id",nil];
    [self makePostRequestForPath:checkoutPath withValues:checkOut];
}

- (void)confirmCheckOut:(void (^)(NSMutableDictionary *info)) callback {
    completionBlock = callback;
    [self makeGetRequestForPath:confirmCheckoutPath];
}

- (void)validatePayment:(void (^)(NSMutableDictionary *info)) callback {
    completionBlock = callback;
    [self makeGetRequestForPath:validatePaymentPath];
}

- (void)postContactUsWithName:(NSString *) name
                       Mobile:(NSString *) mobile
                        Email:(NSString *) email
                      Enquiry:(NSString *) enquiry
                      Captcha:(NSString *) captcha
                 withCallback:(void (^)(NSDictionary *info))callback {
    completionBlock = callback;
    
    NSDictionary *info = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"name",mobile,@"mobile",email,@"email",enquiry,@"enquiry",captcha,@"captcha",nil];
    [self makePostRequestForPath:contactUsPath withValues:info];
}

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
                    withCallback:(void (^)(NSDictionary *info))callback {
    
    NSDictionary *signup = [[NSDictionary alloc] initWithObjectsAndKeys:firstName,@"firstname",lastName,@"lastname",email,@"email",mobile,@"mobile",telephone,@"telephone",company,@"company",address_1,@"address_1",address_2,@"address_2",city,@"city",password,@"password",@"1",@"confirm",@"1",@"agree",nil];
    
    completionBlock = callback;
    [self makePostRequestForPath:validateAccountPath withValues:signup];
}

/* ==============================
    REQUEST
 ===============================*/

- (void)makeGetRequestForPath:(NSString *) string {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",mainUrl,string];
    
    NSLog(@"Start makeGetRequestForPath: %@",urlString);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                             [NSURL URLWithString:urlString]];
    [request setValue:string forHTTPHeaderField:@"RequestPath"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                delegate:self];
    
    [connection start];
}

- (void)makePostRequestForPath:(NSString *) string withValues:(NSDictionary *) value {
    NSString *urlString = [NSString stringWithFormat:@"%@%@",mainUrl,string];
    
    NSLog(@"Start makePostRequestForPath: %@",urlString);
    
    NSData *postData = [self encodeDictionary:value];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mainUrl,string]]];
    [request setHTTPMethod:@"POST"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:string forHTTPHeaderField:@"RequestPath"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self];
    [connection start];
}

#pragma mark NSURLDelegate

//- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
//    
//}

- (void) connection:(NSURLConnection *)connection
 didReceiveResponse:(NSURLResponse *)response {
    // connection is starting, clear buffer
    [self setReceivedData:[NSMutableData new]];
    [[self receivedData] setLength:0];
}

- (void) connection:(NSURLConnection *)connection
     didReceiveData:(NSData *)data {
    // data is arriving, add it to the buffer
    [[self receivedData] appendData:data];
}

- (void)connection:(NSURLConnection*)connection
  didFailWithError:(NSError *)error {
    // something went wrong, clean up interface as needed
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // all done, we are ready to rock and roll
    // do something with self.receivedData
    
    NSError* error;
    
    NSString* newStr = [[NSString alloc] initWithData:[self receivedData] encoding:NSUTF8StringEncoding];
    
    NSLog(@"didReceiveData Raw: %@", newStr);
    
    /*newStr = [self stringByStrippingHTML:newStr];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"<pre>" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\\r" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\\n" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\\t" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\\\"" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];*/
    newStr = [newStr stringByConvertingHTMLToPlainText];
    newStr = [newStr stringByDecodingHTMLEntities];
    newStr = [newStr stringByRemovingNewLinesAndWhitespace];
    
    NSData *jsonData = [newStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:kNilOptions
                                                           error:&error];
    
    /*NSDictionary* json = [NSJSONSerialization
     JSONObjectWithData:newData
     options:kNilOptions
     error:&error];*/
    
    
    if(error != nil) {
        NSLog(@"didReceiveData Error: %@", [error localizedFailureReason]);
    } else {
        NSLog(@"didReceiveData Json: %@", json);
    }
    
    NSString *path = [[connection currentRequest] valueForHTTPHeaderField:@"RequestPath"];
    
    if([path rangeOfString:menuPath].length > 0) {
        NSMutableArray *menuList = [json valueForKey:@"products"];
        if(menuList != nil) {
            NSMutableArray *menuArray = [NSMutableArray new];
            
            for(NSDictionary *item in menuList) {
                MenuObject *menu = [MenuObject new];
                [menu readFromDictionary:item];
                [menuArray addObject:menu];
            }
            
            completionBlock(menuArray);
        }
    } else if([path rangeOfString:viewCartPath].length > 0) {
        NSMutableArray *carList = (NSMutableArray *)json;
        
        NSMutableArray *cartArray = [NSMutableArray new];
        for(NSDictionary *item in carList) {
            CartItem *cart = [CartItem new];
            [cart readFromDictionary:item];
            [cartArray addObject:cart];
        }
        
        completionBlock(cartArray);
        
    } else if([path rangeOfString:loginPath].length > 0) {
        
        NSMutableDictionary *message = [json valueForKey:@"message"];
        NSMutableDictionary *account = [message valueForKey:@"account"];
        if(account != nil) {
            TasteryAccount *tasteryAccount = [TasteryAccount new];
            [tasteryAccount readFromDictionary:account];
            completionBlock(tasteryAccount);
        } else {
            if([message isKindOfClass:[NSDictionary class]]) {
                NSString *warning = [message valueForKey:@"warning"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:warning delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Success" message:@"" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
        }
        
    } else if([path rangeOfString:registerPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:contactUsPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:generateCaptchaPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:checkoutPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:addToCartPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:confirmCheckoutPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:validatePaymentPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:confirmOrderPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:logoutPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:forgotPasswordPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:finalCheckoutPath].length > 0) {
        completionBlock(json);
    } else if([path rangeOfString:forgotPasswordPath].length > 0) {
        completionBlock(json);
    } else {
        NSMutableDictionary *pageInfo = [json valueForKey:@"page"];
        if(pageInfo != nil && [pageInfo count] > 0) {
            PageObject *page = [PageObject new];
            [page readFromDictionary:pageInfo];
            completionBlock(page);
        }
    }
    
}

- (NSData*)encodeDictionary:(NSDictionary*)dictionary {
    NSMutableArray *parts = [[NSMutableArray alloc] init];
    for (NSString *key in dictionary) {
        NSString *encodedValue = [[dictionary objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
        [parts addObject:part];
    }
    NSLog(@"Post Data : %@",parts);
    NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
    return [encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)stringByStrippingHTML:(NSString*)str {
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound) {
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    }
    return str;
}

- (NSString *)getStringFromDate:(NSDate *) date {
    NSDateFormatter* df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"EEE MMM. dd, yyyy"];
    return [df stringFromDate:date];
}

@end
