//
//  WhatWhoWhyController.h
//  Tastery
//
//  Created by Max Von Ongkingco on 8/19/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>

enum ViewType {
    ViewType_What = 1,
    ViewType_Who = 2,
    ViewType_Why = 3,
    ViewType_How = 4,
    ViewType_Gift = 5
};

NSInteger ViewType;

@interface WhatWhoWhyController : UIViewController <UIActionSheetDelegate> {
    IBOutlet UILabel *lblTitle;
    IBOutlet UITextView *lblDescription;
}

@property (nonatomic) NSInteger ViewType;
@property (nonatomic) NSString *Title, *Description;

@end
