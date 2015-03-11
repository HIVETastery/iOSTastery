//
//  HomeViewController.m
//  Tastery
//
//  Created by Emman Kusumi on 8/16/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "HomeViewController.h"
#import "MMDrawerBarButtonItem.h"

#import "MMDrawerController.h"
#import "LoginController.h"
#import "ModalMenuController.h"
#import "CartController.h"
#import "ProfileViewController.h"

#import "TasteryAppManager.h"
#import "TasteryAPIManager.h"
#import "TasterySocialManager.h"

#import "MenuTableViewCell.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

static HomeViewController *homeViewController = nil;

+ (HomeViewController *)getHomeViewController {
    if(homeViewController==nil) {
        homeViewController = [HomeViewController new];
    }
    return homeViewController;
}

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
    
    tastery = [TasteryAppManager getTasteryAppManager];
    [tastery getNavigationBar:[self navigationItem]];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday] - 1;
    
    [self onSelectDayForIndex:weekday];
    [self onSelectCityForIndex:0];
    
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    [api getMenuWithCallback:^(NSMutableArray *menuList) {
        arrMenuList = menuList;
        [self onSelectDayForIndex:weekday];
        [self onSelectCityForIndex:0];
    }];
    
    [[btnAddAsSet layer] setBorderWidth:2.0];
    [[btnDay layer] setBorderWidth:2.0];
    [[btnCity layer] setBorderWidth:2.0];
    
    [[btnAddAsSet layer] setBorderColor:[[tastery blueColor] CGColor]];
    [[btnDay layer] setBorderColor:[[tastery blueColor] CGColor]];
    [[btnCity layer] setBorderColor:[[tastery blueColor] CGColor]];
    
    [tastery setCartList:[NSMutableArray new]];
    
    lblCounter = [[UILabel alloc] initWithFrame:
                  CGRectMake(295,2,20,20)];
    lblCounter.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    lblCounter.backgroundColor = [UIColor clearColor];
    lblCounter.font = [UIFont systemFontOfSize:12];
    lblCounter.textAlignment = NSTextAlignmentCenter;
    lblCounter.layer.cornerRadius = 10;
    lblCounter.clipsToBounds = YES;
    [[[self navigationController] navigationBar] addSubview:lblCounter];
    
    [lblComingSoon.layer setBorderWidth:2];
    [lblComingSoon.layer setBorderColor:[tastery blueColor].CGColor];
    
    [lblComingSoon setHidden:YES];
    [tblMenu setHidden:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self mainView] setUserInteractionEnabled:YES];
    [lblCounter setHidden:NO];
    [self displayCounter];
    
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

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [lblCounter setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayCounter {
    if([[tastery cartList] count] > 0) {
        lblCounter.text = [NSString stringWithFormat:@"%lu",(unsigned long)[[tastery cartList] count]];
        lblCounter.textColor = [UIColor whiteColor];
        lblCounter.backgroundColor = [UIColor redColor];
        [lblCounter setHidden:NO];
    } else {
        [lblCounter setHidden:NO];
    }
}

- (void)onSelectDayForIndex:(NSInteger) index {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = [comps weekday] - 2;

    if(index > 4) {
        index = weekday;
    }
    
    NSArray *arrMenu = @[@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",@"Saturday",@"Sunday"];
    NSString *day = [arrMenu objectAtIndex:index];
    [btnDay setTitle:[day uppercaseString] forState:UIControlStateNormal];
    
    if(index > weekday) {
        //[tblMenu setUserInteractionEnabled:YES];
        [tblMenu setAlpha:1.0];
        [btnAddAsSet setEnabled:YES];
        [btnAddAsSet setAlpha:1.0];
    } else {
        //[tblMenu setUserInteractionEnabled:NO];
        [tblMenu setAlpha:0.2];
        [btnAddAsSet setEnabled:NO];
        [btnAddAsSet setAlpha:0.2];
    }
    
    arrMenuForTheDay = [NSMutableArray new];
    for(MenuObject *menu in arrMenuList) {
        if([[menu day] isEqualToString:day]) {
            [arrMenuForTheDay addObject:menu];
        }
        
        NSString *setDay = [NSString stringWithFormat:@"%@SetMeal",day];
        if([[menu day] isEqualToString:setDay]) {
            setMealForTheDay = menu;
        }
    }
    
    [tblMenu reloadData];
    selectedDay = [arrMenu objectAtIndex:index];
}

- (void)onSelectCityForIndex:(NSInteger) index {
    NSArray *arrMenu = @[@"Taguig",@"Alabang",@"Makati",@"Ortigas/Libis"];
    NSString *city = [arrMenu objectAtIndex:index];
    [btnCity setTitle:[city uppercaseString] forState:UIControlStateNormal];
    
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    [api setCurrentCity:city];
    
    if(index == 0 || index == 2) {
        [lblComingSoon setHidden:YES];
        [tblMenu setHidden:NO];
    } else {
        [lblComingSoon setHidden:NO];
        [tblMenu setHidden:YES];
    }
}

- (void)onMenu {
    tastery = [TasteryAppManager getTasteryAppManager];
    [[tastery drawerViewController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)onShowInfo:(id)sender {
    [lblCounter setHidden:YES];
    ModalMenuController *menu = [ModalMenuController new];
    [[self navigationController] pushViewController:menu animated:YES];
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrMenuForTheDay count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";

    MenuTableViewCell *cell = (MenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if(cell==nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MenuTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    MenuObject *menu = [arrMenuForTheDay objectAtIndex:[indexPath row]];
    
    if([menu thumb]) {
        if([[menu thumb] isKindOfClass:[NSString class]]) {
            NSString *encodedString = [menu thumb];
            encodedString = [encodedString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            NSURL *url = [NSURL URLWithString:encodedString];
            [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
                
                if(succeeded == YES) {
                    
                    [[cell imgMenu] setImage:image];
                    
                }
                
            }];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MenuObject *menu = [arrMenuForTheDay objectAtIndex:[indexPath row]];
    ModalMenuController *modal = [ModalMenuController new];
    [modal setMenuObject:menu];
    [[self navigationController] pushViewController:modal animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (IBAction)onAddToCart:(id)sender {
    [[tastery cartList] addObject:setMealForTheDay];
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    
    NSString *date = [api getStringFromDate:[NSDate date]];
    
    [api addToCartProductId:[setMealForTheDay product_id]
                   quantity:@"1"
                      place:[api currentCity]
               deliveryDate:date
               WithCallback:^(NSDictionary *info) {
        
                   
    }];
    
    [self displayCounter];
}

- (IBAction)onCity:(id)sender {
    UIActionSheet *action = [[UIActionSheet alloc]
                             initWithTitle:@""
                             delegate:self
                             cancelButtonTitle:@"Cancel"
                             destructiveButtonTitle:nil
                             otherButtonTitles:@"Taguig",@"Alabang",@"Makati",@"Ortigas/Libis",nil];
    [action setTag:ActionSheetType_City];
    [action showInView:[self view]];
}

- (IBAction)onDay:(id)sender {
    UIActionSheet *action = [[UIActionSheet alloc]
                             initWithTitle:@""
                             delegate:self
                             cancelButtonTitle:@"Cancel"
                             destructiveButtonTitle:nil
                             otherButtonTitles:@"Monday",@"Tuesday",@"Wednesday",@"Thursday",@"Friday",nil];
    [action setTag:ActionSheetType_Day];
    [action showInView:[self view]];
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
                    
                    [tastery setCartList:[NSMutableArray new]];
                    
                    [[self navigationController] popToRootViewControllerAnimated:YES];
                }];
            }
        } else if([actionSheet tag] == ActionSheetType_City) {
            [self onSelectCityForIndex:buttonIndex];
        } else if([actionSheet tag] == ActionSheetType_Day) {
            [self onSelectDayForIndex:buttonIndex];
        }
    }
}

@end
