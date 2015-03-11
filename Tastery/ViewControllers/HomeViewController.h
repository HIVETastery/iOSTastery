//
//  HomeViewController.h
//  Tastery
//
//  Created by Emman Kusumi on 8/16/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TasteryAppManager;
@class MenuObject;

enum ActionSheetType {
    ActionSheetType_Login = 0,
    ActionSheetType_Profile = 1,
    ActionSheetType_City = 2,
    ActionSheetType_Day = 3
};

@interface HomeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate> {
    TasteryAppManager *tastery;
    MenuObject *setMealForTheDay;
    NSString *selectedDay;
    NSMutableArray *arrMenuList, *arrMenuForTheDay;
    UILabel *lblCounter;
    IBOutlet UITableView *tblMenu;
    IBOutlet UIButton *btnAddAsSet;
    IBOutlet UIImageView *imgMenu1, *imgMenu2, *imgMenu3;
    IBOutlet UIButton *btnCity, *btnDay;
    IBOutlet UILabel *lblComingSoon;
}

@property (nonatomic) IBOutlet UIView *mainView;

+ (HomeViewController *)getHomeViewController;
- (IBAction)onShowInfo:(id)sender;
- (IBAction)onAddToCart:(id)sender;
- (IBAction)onCity:(id)sender;
- (IBAction)onDay:(id)sender;

@end
