//
//  CartController.h
//  Tastery
//
//  Created by Emman Kusumi on 9/17/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasteryAppManager.h"

@interface CartController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIActionSheetDelegate> {
    NSMutableArray *arrCartItems;
    TasteryAppManager *tastery;
    UITextField *txtTime;
    IBOutlet UITableView *tView;
    IBOutlet UILabel *lblVat, *lblTotal;
    IBOutlet UIDatePicker *datePicker;
}

- (IBAction)onShowDeliveryInfo:(id)sender;
- (IBAction)onDateChange:(UIDatePicker *)sender;

@end
