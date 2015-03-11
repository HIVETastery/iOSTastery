//
//  WhatWhoWhyController.m
//  Tastery
//
//  Created by Max Von Ongkingco on 8/19/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "WhatWhoWhyController.h"
#import "TasteryAPIManager.h"
#import "MMDrawerBarButtonItem.h"
#import "TasteryAppManager.h"
#import "MMDrawerController.h"
#import "TasterySocialManager.h"
#import "HomeViewController.h"
#import "CartController.h"
#import "LoginController.h"
#import "ProfileViewController.h"

@interface WhatWhoWhyController ()

@end

@implementation WhatWhoWhyController

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
    
    MMDrawerBarButtonItem *btnMenu = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(onMenu)];
    [[self navigationItem] setLeftBarButtonItem:btnMenu];
    
    UIBarButtonItem *btnAction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(onAction:)];
    [[self navigationItem] setRightBarButtonItem:btnAction];
    
    TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
    [tastery getNavigationBar:[self navigationItem]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
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
    
    [lblTitle setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:26.0]];
    
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    
    
    if([self ViewType] == ViewType_Who) {
        [api getWhoWeAreWithCallback:^(PageObject *page) {
            [lblTitle setText:[page heading_title]];
            [lblDescription setText:[page page_description]];
        }];
    } else if([self ViewType] == ViewType_What) {
        [api getWhatWeDoWithCallback:^(PageObject *page) {
            [lblTitle setText:[page heading_title]];
            [lblDescription setText:[page page_description]];
        }];
    } else if([self ViewType] == ViewType_Why) {
        [api getWhyWeDoWithCallback:^(PageObject *page) {
            [lblTitle setText:[page heading_title]];
            [lblDescription setText:[page page_description]];
        }];
    } else if([self ViewType] == ViewType_How) {
        [api getHowWeDoWithCallback:^(PageObject *page) {
            [lblTitle setText:[page heading_title]];
            [lblDescription setText:[page page_description]];
        }];
    } else if([self ViewType] == ViewType_Gift) {
        [api getGiftWithCallback:^(PageObject *page) {
            [lblTitle setText:[page heading_title]];
            [lblDescription setText:[page page_description]];
        }];
    } else {
        [lblTitle setText:[self Title]];
        [lblDescription setText:[self Description]];
    }
    
}

- (void)onMenu {
    TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
    [[tastery drawerViewController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark UIActionSheet

- (void)onAction:(UIBarButtonItem *) sender {
    
    UIActionSheet *action = nil;
    TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
    if([social currentAccount] == nil) {
        action = [[UIActionSheet alloc]
                  initWithTitle:@""
                  delegate:self
                  cancelButtonTitle:@"Cancel"
                  destructiveButtonTitle:nil
                  otherButtonTitles:@"Cart",@"Login", nil];
        [action setTag:ActionSheetType_Login];
    } else {
        action = [[UIActionSheet alloc]
                  initWithTitle:@""
                  delegate:self
                  cancelButtonTitle:@"Cancel"
                  destructiveButtonTitle:nil
                  otherButtonTitles:@"Cart",@"Profile",@"Logout", nil];
        [action setTag:ActionSheetType_Profile];
    }
    [action showFromBarButtonItem:sender animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex != [actionSheet cancelButtonIndex]) {
        if([actionSheet tag] == ActionSheetType_Login) {
            if(buttonIndex == 0) {
                CartController *cart = [CartController new];
                [[self navigationController] pushViewController:cart animated:YES];
            } else {
                LoginController *login = [LoginController new];
                [[self navigationController] pushViewController:login animated:YES];
            }
        } else if([actionSheet tag] == ActionSheetType_Profile) {
            if(buttonIndex == 0) {
                CartController *cart = [CartController new];
                [[self navigationController] pushViewController:cart animated:YES];
            } else if(buttonIndex == 1) {
                ProfileViewController *profile = [ProfileViewController new];
                [[self navigationController] pushViewController:profile animated:YES];
            } else {
                TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
                [api logoutWithCallback:^(NSMutableDictionary *info) {
                    [TasteryAPIManager cancelAPIManager];
                    [TasteryAppManager cancelAppManager];
                    [TasterySocialManager cancelSocialManager];
                    [[self navigationController] popToRootViewControllerAnimated:YES];
                }];
            }
        }
    }
}

@end
