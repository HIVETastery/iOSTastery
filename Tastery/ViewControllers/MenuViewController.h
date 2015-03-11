//
//  MenuViewController.h
//  Tastery
//
//  Created by Emman Kusumi on 8/16/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TasteryAppManager.h"
#import "TasterySocialManager.h"

enum Menu {
    Menu_Home = 0,
    Menu_Who  = 1,
    Menu_What = 2,
    Menu_Why = 3,
    Menu_How = 4,
    Menu_Gift = 5,
    Menu_ContactUs = 6,
    Menu_Help = 7,
    Menu_Terms = 8,
    Menu_Privacy = 9
};

NSInteger Menu;

@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    TasteryAppManager *tastery;
    TasterySocialManager *social;
    IBOutlet UITableView *tView;
}

@end
