//
//  TasterySocialManager.m
//  Tastery
//
//  Created by Emman Kusumi on 9/21/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "TasterySocialManager.h"

@implementation TasterySocialManager

static TasterySocialManager *tasterySocialManager = nil;

+ (TasterySocialManager *) getTasterySocialManager {
    if(tasterySocialManager == nil) {
        tasterySocialManager = [TasterySocialManager new];
    }
    return tasterySocialManager;
}

+ (void)cancelSocialManager {
    tasterySocialManager = nil;
}

@end
