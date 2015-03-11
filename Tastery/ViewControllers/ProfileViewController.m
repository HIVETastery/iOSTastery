//
//  ProfileViewController.m
//  Tastery
//
//  Created by Emman Kusumi on 10/13/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "ProfileViewController.h"
#import "TasterySocialManager.h"
#import "TasteryAppManager.h"
#import "TasteryAPIManager.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

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
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    
    TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
    [[self navigationItem] setTitleView:[tastery getNavigationBarForTitle:@"Profile"]];

    TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
    TasteryAccount *account = [social currentAccount];
    
    [txtFirstName setText:[account firstname]];
    [txtLastName setText:[account lastname]];
    [txtEmail setText:[account email]];
    [txtTelephone setText:[account telephone]];
    [txtMobile setText:[account mobile]];
    [txtAddress setText:@""];
    [txtPassword setText:[api currentPassword]];
    
    UIBarButtonItem *confirm = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(onConfirm)];
    [confirm setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont fontWithName:@"GearedSlab-Thin" size:20.0], NSFontAttributeName,
                                     [UIColor whiteColor], NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    [[self navigationItem] setRightBarButtonItem:confirm];
    
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

- (void)onConfirm {
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    [api saveProfileWithFirstName:[txtFirstName text]
                         lastName:[txtLastName text]
                            email:[txtEmail text]
                           mobile:[txtMobile text]
                        telephone:[txtTelephone text]
                          company:@""
                         address1:[txtAddress text]
                         address2:@""
                             city:@""
                         password:[txtPassword text]
                     withCallback:^(NSDictionary *info) {
        
                         
                         
    }];
}

- (void)onBack {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
