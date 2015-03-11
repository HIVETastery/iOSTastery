//
//  TasterySocialManager.h
//  Tastery
//
//  Created by Emman Kusumi on 9/21/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UserObject.h"
#import "TasteryAccount.h"

@interface TasterySocialManager : NSObject

@property (nonatomic) FBLoginView *FBLogin;
@property (nonatomic) UserObject *FBUser;
@property (nonatomic) TasteryAccount *currentAccount;

+ (TasterySocialManager *) getTasterySocialManager;
+ (void)cancelSocialManager;

@end
