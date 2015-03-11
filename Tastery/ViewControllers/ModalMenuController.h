//
//  ModalMenuController.h
//  Tastery
//
//  Created by Max Von Ongkingco on 8/20/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuObject.h"

@interface ModalMenuController : UIViewController {
    IBOutlet UIImageView *imgMenu;
    IBOutlet UILabel *lblName;
    IBOutlet UITextView *lblDescription;
    IBOutlet UILabel *lblPrice;
}

@property (nonatomic) MenuObject *menuObject;

- (IBAction)onAddToCart:(id)sender;

@end
