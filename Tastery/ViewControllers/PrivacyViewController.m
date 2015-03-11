//
//  PrivacyViewController.m
//  Tastery
//
//  Created by Emman Kusumi on 10/22/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "PrivacyViewController.h"
#import "MMDrawerBarButtonItem.h"
#import "TasteryAppManager.h"
#import "MMDrawerController.h"
#import "TasterySocialManager.h"
#import "HomeViewController.h"
#import "CartController.h"
#import "LoginController.h"
#import "ProfileViewController.h"
#import "TasteryAPIManager.h"

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

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
    
    [scrollView sizeToFit];
    [scrollView layoutIfNeeded];
    [scrollView setScrollEnabled:YES];
    [scrollView setContentSize:txtPrivacy.frame.size];
    
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
    
    [txtPrivacy setText:@"Tastery is a wholly-owned business of Tri-Star Culinary Concepts, Inc. (T-SCCI).  We collect the e-mail addresses of those who communicate with us via e-mail, aggregate information on the accessed or visited pages of consumers access or visit, and information volunteered by the consumer (such as survey information and/or site registrations). To notify you about our practices, we have developed this Privacy Policy, and personal information collected on or through this Site on our behalf will be treated in accordance with this Privacy Policy. By using this Site you consent to the use, storage and processing of your personal information and other information stored on this Site or submitted by you on or through this Site in accordance with this Privacy Policy. The information we collect is used to improve the content of our Web pages and the quality of our service.  This Privacy Policy is subject to the Site’s TERMS AND CONDITIONS OF USE.\n\nInformation is not shared with or sold to other organizations for commercial purposes, except to provide products or services you've requested, when we have your permission, or under the following circumstances:\n\n1. It is necessary to share information in order to investigate, prevent, or take action regarding illegal activities, suspected fraud, situations involving potential threats to the physical safety of any person, violations of Terms of Service, or as otherwise required by law.\n\n2. We transfer information about you if T-SCCI or Tastery is acquired by or merged with another company. In this event, T-SCCI or Tastery will notify you before information about you is transferred and becomes subject to a different privacy policy.\n\nInformation Gathering and Usage\n\n1. When you register with Tastery, we ask for information such as your name and email address.\n\n2. Tastery uses the information we collect for the following general purposes: products and services provision, geocoding and location mapping, identification and authentication, services improvement, contact, and research.\n\nCookies\n\n1. A cookie is a small amount of data, which often includes an anonymous unique identifier, that is sent to your browser from a web site's computers and stored on your computer's hard drive.\n\n2. Cookies are required to use the Tastery service.\n\n3. We use cookies to record current session information. You are required to log-in to your Tastery site after a certain period of time has elapsed to protect you against others accidentally accessing your account contents.\n\nData Storage\n\nTastery uses third party vendors and hosting partners to provide the necessary hardware, software, networking, storage, and related technology required to run Tastery. Although Tastery owns the code, databases, and all rights to the Tastery application, you retain all rights to your data.\n\nDisclosure\n\nTastery may disclose personally identifiable information under special circumstances, such as to comply with subpoenas or when your actions violate the Terms of Service.\n\nYou have the right to access personal information held about you, and may do so by contacting us at eat@tastery.com in accordance with the local applicable laws, any such access request may be subject to a fee to meet our costs in providing you with details of the personal information that we hold about you.  Subject to local applicable laws, you also have the right to object to any processing that is likely to cause you damage or distress and you also have the right to rectify, block, erase or destroy inaccurate data.\n\nChanges\n\nTastery reserves the right to update this policy as we see fit. We will notify you about significant changes by sending a notice to the primary email address specified in your Tastery account or by placing a prominent notice on our site. If you are a regular visitor to this Site, we recommend that you check this Privacy Policy on a regular basis.\n\nUpdating your Personal Information\n\nIt is important that the personal information that we hold about you is accurate, complete and up to date.  If any of your details change you can update us by amending your personal details on your account page.  You can also do this by e-mailing us at eat@tastery.com.\n\nSecurity\n\nWe have adopted the technical and organisational measures necessary to ensure the security of the personal data we collect, use and maintain, and prevent their alteration, loss, unauthorised processing or access, having regard to the state of the art, the nature of the data stored and the risks to which they are exposed by virtue of human action or physical or natural environment. However, as effective as our security measures are, no security system is impenetrable. We cannot guarantee the security of our database, nor can we guarantee that personal information you supply will not be intercepted while being transmitted to us over the internet. We ask that you do your part by maintaining in strict confidence any computer passwords you use to access the Internet or this Site.  We encourage responsible reporting of any vulnerabilities that may be found in our Sites or any application available through our Sites.\n\nQuestions\n\nPrivacy Policy Questions regarding this Privacy Policy should be directed to us at eat@tastery.com or by writing to the following address:"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
