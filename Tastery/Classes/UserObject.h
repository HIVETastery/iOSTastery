//
//  UserObject.h
//  One
//
//  Created by Emman Kusumi on 8/24/14.
//  Copyright (c) 2014 MicahBenn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserObject : NSObject

@property (nonatomic) NSString *Name;
@property (nonatomic) NSString *Address;
@property (nonatomic) NSString *Mobile;
@property (nonatomic) NSString *Email;
@property (nonatomic) NSString *Notes;

- (void) readFromDictionary:(NSDictionary *) dictionary;

@end