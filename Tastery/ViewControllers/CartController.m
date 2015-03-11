//
//  CartController.m
//  Tastery
//
//  Created by Emman Kusumi on 9/17/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "CartController.h"
#import "CartTableCell.h"
#import "CartItem.h"
#import "TasteryAppManager.h"
#import "TasteryAPIManager.h"
#import "DeliveryInfoController.h"
#import "MenuObject.h"
#import "DateManager.h"
#import "TasterySocialManager.h"

@interface CartController ()

@end

@implementation CartController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    tastery = [TasteryAppManager getTasteryAppManager];
    [[self navigationItem] setTitleView:[tastery getNavigationBarForTitle:@"Cart"]];
    
    arrCartItems = [NSMutableArray new];
    
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    [api getCartWithCallback:^(NSMutableArray *menuList) {
        if([menuList count]>0) {
            arrCartItems = menuList;
            [tView reloadData];
            
            double totalAmount = 0;
            for(CartItem *cart in arrCartItems) {
                NSString *txtTotal = [[cart total] stringByReplacingOccurrencesOfString:@"₱" withString:@""];
                double numTotal = [txtTotal doubleValue];
                totalAmount = totalAmount + numTotal;
            }
            
            double vat = totalAmount - (totalAmount / 1.12);
            NSString *totalVat = [NSString stringWithFormat:@"₱%.2f",vat];
            NSString *totalPrice = [NSString stringWithFormat:@"₱%.2f",totalAmount];
            
            [lblVat setText:totalVat];
            [lblTotal setText:totalPrice];
            
        }
    }];
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                          target:self
                                                                          action:@selector(onEdit)];
    [edit setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIFont fontWithName:@"GearedSlab-Thin" size:20.0], NSFontAttributeName,
                                        [UIColor whiteColor], NSForegroundColorAttributeName,
                                        nil] 
                              forState:UIControlStateNormal];
    [[self navigationItem] setRightBarButtonItem:edit];
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(onBack)];
    [back setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                  [UIFont fontWithName:@"GearedSlab-Thin" size:20.0], NSFontAttributeName,
                                  [UIColor whiteColor], NSForegroundColorAttributeName,
                                  nil]
                        forState:UIControlStateNormal];
    [[self navigationItem] setLeftBarButtonItem:back];
    
    for(UIView *view in [[self view] subviews]) {
        if([view isKindOfClass:[UILabel class]]) {
            UILabel *lbl = (UILabel *)view;
            [lbl setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:12.0]];
        } else if([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [[btn titleLabel] setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:16.0]];
        } else if([view isKindOfClass:[UITextField class]]) {
            UITextField *txt = (UITextField *)view;
            [txt setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:16.0]];
        } else if([view isKindOfClass:[UITextView class]]) {
            UITextView *txt = (UITextView *)view;
            [txt setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:16.0]];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShowDeliveryInfo:(id)sender {
    TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
    if([social currentAccount] == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:@"Please login first before proceeding to checkout."
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        // CartItem *cartItem = [arrCartItems objectAtIndex:[indexPath row]];
        
        BOOL isComplete = YES;
        for(CartItem *cartItem in arrCartItems) {
            if([cartItem deliveryTime] == nil) {
                isComplete = NO;
            }
        }
        
        if(isComplete == YES) {
            DeliveryInfoController *deliveryInfo = [DeliveryInfoController new];
            [[self navigationController] pushViewController:deliveryInfo animated:YES];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:@"Please complete all fields before proceeding."
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrCartItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strCellIdentifier = @"CellStop";
    
    CartTableCell *cell = (CartTableCell *)[tableView dequeueReusableCellWithIdentifier:strCellIdentifier];
    
    if(cell==nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartTableCell" owner:self options:nil];
        cell = [topLevelObjects firstObject];
    }
    
    CartItem *cartItem = [arrCartItems objectAtIndex:[indexPath row]];
    
    NSString *date = [cartItem odate];
    
    [[cell lblDate] setText:date];
    [[cell lblItem] setText:[cartItem name]];
    [[cell txtQuantity] setText:[[cartItem quantity] stringValue]];
    [[cell txtDeliveryTime] setText:[cartItem deliveryTime]];
    
    [[cell txtQuantity] setTag:0];
    [[cell txtQuantity] setDelegate:self];
    
    [[cell txtDeliveryTime] setTag:[indexPath row]+1000];
    [[cell txtDeliveryTime] setDelegate:self];
    
    [[cell lblPrice] setText:[cartItem price]];
    
    [[cell lblDate] setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:10.0]];
    [[cell lblItem] setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:10.0]];
    [[cell txtQuantity] setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:10.0]];
    [[cell txtDeliveryTime] setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:10.0]];
    [[cell txtQuantity] setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:10.0]];
    [[cell lblPrice] setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:10.0]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrCartItems removeObjectAtIndex:[indexPath row]];
        [tView reloadData];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if([textField tag]==0) {
        txtTime = nil;
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
        
        UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                 target:self
                                                                                 action:@selector(onDone)];
        [btnDone setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:@"GearedSlab-Thin" size:20.0], NSFontAttributeName,
                                      [UIColor whiteColor], NSForegroundColorAttributeName,
                                      nil]
                            forState:UIControlStateNormal];
        [[self navigationItem] setRightBarButtonItem:btnDone];
        
        return YES;
    } else if([textField tag]>999) {
        CartItem *cartItem = [arrCartItems objectAtIndex:0];
        NSMutableArray *dtime = [cartItem dtime];
        
        NSMutableDictionary *first = [dtime firstObject];
        NSMutableDictionary *last = [dtime lastObject];
        
        txtTime = textField;
        
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Choose Delivery Time"
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:[first valueForKey:@"delivery_time"], [last valueForKey:@"delivery_time"], nil];
        [action showInView:[self view]];
        
        return NO;
    }
    return NO;
}

- (void)onDone {
    [[self view] endEditing:YES];
    [[self navigationItem] setRightBarButtonItem:nil];
}

- (IBAction)onDateChange:(UIDatePicker *)sender {
    NSString *time = [DateManager stringForTime:[sender date]];
    [txtTime setText:time];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex != [actionSheet cancelButtonIndex]) {
        CartItem *cartItem = [arrCartItems objectAtIndex:0];
        NSMutableArray *dtime = [cartItem dtime];
        
        NSMutableDictionary *first = [dtime firstObject];
        NSMutableDictionary *last = [dtime lastObject];
        
        if(buttonIndex == 0) {
            [txtTime setText:[first valueForKey:@"delivery_time"]];
        } else {
            [txtTime setText:[last valueForKey:@"delivery_time"]];
        }
        
        int index = [txtTime tag] - 1000;
        cartItem = [arrCartItems objectAtIndex:index];
        [cartItem setDeliveryTime:[txtTime text]];
        [tView reloadData];
    }
}

- (void)onEdit {
    [super setEditing:YES animated:YES];
    [tView setEditing:YES animated:YES];
    [tView reloadData];
    
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                          target:self
                                                                          action:@selector(onEditDone)];
    [done setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont fontWithName:@"GearedSlab-Thin" size:20.0], NSFontAttributeName,
                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    [[self navigationItem] setRightBarButtonItem:done];
}

- (void)onEditDone {
    [super setEditing:YES animated:NO];
    [tView setEditing:NO animated:YES];
    [tView reloadData];
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                          target:self
                                                                          action:@selector(onEdit)];
    [edit setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont fontWithName:@"GearedSlab-Thin" size:20.0], NSFontAttributeName,
                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    [[self navigationItem] setRightBarButtonItem:edit];
}

- (void)onBack {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
