//
//  CartTableCell.h
//  Tastery
//
//  Created by Emman Kusumi on 9/17/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartTableCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *lblDate, *lblItem, *lblQuantity, *lblDeliveryTime, *lblPrice;
@property (nonatomic) IBOutlet UITextField *txtQuantity, *txtDeliveryTime;

@end
