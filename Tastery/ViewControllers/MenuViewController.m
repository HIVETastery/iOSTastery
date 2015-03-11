//
//  MenuViewController.m
//  Tastery
//
//  Created by Emman Kusumi on 8/16/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "MenuViewController.h"
#import "TasteryAppManager.h"
#import "HomeViewController.h"
#import "WhatWhoWhyController.h"
#import "MMDrawerController.h"
#import "PrivacyViewController.h"
#import "ContactUsViewController.h"
#import "TermsViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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
    social = [TasterySocialManager getTasterySocialManager];
    
    [[self view] setBackgroundColor:[tastery blueColor]];
    [tView setBackgroundColor:[tastery blueColor]];
    [tView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSArray *arrMenu = @[@"Menu",@"Who",@"What",@"Why",@"How",@"Gift",@"Contact Us",@"Help/FAQ",@"Terms",@"Privacy"];
    
    [cell setBackgroundColor:[tastery blueColor]];
    [[cell textLabel] setTextColor:[tastery whiteColor]];
    [[cell textLabel] setText:[arrMenu objectAtIndex:[indexPath row]]];
    [[cell textLabel] setFont:[UIFont fontWithName:@"BrandonGrotesque-Regular" size:20.0]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WhatWhoWhyController *what = [WhatWhoWhyController new];
    HomeViewController *home = [HomeViewController getHomeViewController];
    PrivacyViewController *privacy = [PrivacyViewController new];
    ContactUsViewController *contact = [ContactUsViewController new];
    TermsViewController *terms = [TermsViewController new];
    
    for(UIView *view in [[home mainView] subviews]) {
        [view removeFromSuperview];
    }
    
    [[contact view] setUserInteractionEnabled:YES];
    [[home mainView] setUserInteractionEnabled:YES];
    
    id viewController = nil;
    
    switch ([indexPath row]) {
        case Menu_Home:
            // [[home mainView] setHidden:YES];
            viewController = home;
            break;
        case Menu_Who:
            [what setViewType:ViewType_Who];
            // [[home mainView] addSubview:[what view]];
            // [[home mainView] setHidden:NO];
            viewController = what;
            break;
        case Menu_What:
            [what setViewType:ViewType_What];
            // [[home mainView] addSubview:[what view]];
            // [[home mainView] setHidden:NO];
            viewController = what;
            break;
        case Menu_Why:
            [what setViewType:ViewType_Why];
            // [[home mainView] addSubview:[what view]];
            // [[home mainView] setHidden:NO];
            viewController = what;
            break;
        case Menu_How:
            [what setViewType:ViewType_How];
            // [[home mainView] addSubview:[what view]];
            // [[home mainView] setHidden:NO];
            viewController = what;
            break;
        case Menu_Gift:
            [what setViewType:ViewType_Gift];
            // [[home mainView] addSubview:[what view]];
            // [[home mainView] setHidden:NO];
            viewController = what;
            break;
        case Menu_ContactUs:
            // [[home mainView] addSubview:[contact view]];
            // [[home mainView] setHidden:NO];
            viewController = contact;
            break;
        case Menu_Help:
            [what setTitle:@"Help/FAQ"];
            [what setDescription:@"Coming Soon..."];
            // [[home mainView] addSubview:[what view]];
            // [[home mainView] setHidden:NO];
            viewController = what;
            break;
        case Menu_Terms:
            // [[home mainView] addSubview:[terms view]];
            // [[home mainView] setHidden:NO];
            viewController = terms;
            break;
        case Menu_Privacy:
            // [[home mainView] addSubview:[privacy view]];
            // [[home mainView] setHidden:NO];
            viewController = privacy;
            break;
        default:
            break;
    }
    /*
    if([indexPath row]>0) {
        [[home mainView] addSubview:[what view]];
        [[home mainView] setHidden:NO];
    } else {
        [[home mainView] setHidden:YES];
    }*/
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    [tastery setNavigationBarForViewController:viewController];
    [[tastery drawerViewController] setCenterViewController:nav];
    
    tastery = [TasteryAppManager getTasteryAppManager];
    [[tastery drawerViewController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
