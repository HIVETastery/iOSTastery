//
//  DeliveryInfoController.m
//  Tastery
//
//  Created by Emman Kusumi on 9/17/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "DeliveryInfoController.h"
#import "TasteryAppManager.h"
#import "TasteryAPIManager.h"
#import "TasterySocialManager.h"
#import "TermsViewController.h"

@interface DeliveryInfoController ()

@end

@implementation DeliveryInfoController

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
    
    TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
    [[self navigationItem] setTitleView:[tastery getNavigationBarForTitle:@"Delivery Info"]];
    
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    
    TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
    TasteryAccount *account = [social currentAccount];
    
    [txtFirstName setText:[account firstname]];
    [txtLastName setText:[account lastname]];
    [txtEmail setText:[account email]];
    [txtTelephone setText:[account telephone]];
    [txtMobile setText:[account mobile]];
    [txtAddress setText:@""];
    [txtPassword setText:[api currentPassword]];
    
    UIBarButtonItem *checkOut = [[UIBarButtonItem alloc] initWithTitle:@"Confirm" style:UIBarButtonItemStylePlain target:self action:@selector(onCheckout)];
    [checkOut setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont fontWithName:@"GearedSlab-Thin" size:20.0], NSFontAttributeName,
                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    [[self navigationItem] setRightBarButtonItem:checkOut];
    
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
            [lbl setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:16.0]];
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

- (void)onCheckout {
    TasterySocialManager *app = [TasterySocialManager getTasterySocialManager];
    TasteryAccount *account = [app currentAccount];
    
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    [api confirmCheckoutWithAddressId:[account address_id]
                      shippingAddress:[txtAddress text]
                         withCallback:^(NSDictionary *checkout) {
                             
                             TermsViewController *terms = [TermsViewController getTermsViewController];
                             [terms setType:1];
                             [[self navigationController] pushViewController:terms animated:YES];
                             
        
    }];
    
}

#pragma mark UIAlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [[self navigationController] popToRootViewControllerAnimated:YES];
}

- (void)onBack {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
