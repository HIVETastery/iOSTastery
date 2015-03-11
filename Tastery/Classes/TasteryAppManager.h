//
//  TasteryAppManager.h
//  Tastery
//
//  Created by Emman Kusumi on 8/30/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HomeViewController;
@class MenuViewController;
@class MMDrawerController;
@class STTwitterAPI;

@interface TasteryAppManager : NSObject

@property (nonatomic) UIColor *whiteColor;
@property (nonatomic) UIColor *blueColor;

@property (nonatomic) HomeViewController *homeViewController;
@property (nonatomic) MenuViewController *menuViewController;
@property (nonatomic) MMDrawerController *drawerViewController;

@property (nonatomic) NSMutableArray *cartList;
@property (nonatomic) STTwitterAPI *twitter;

+(TasteryAppManager *)getTasteryAppManager;
+(void)cancelAppManager;

-(UILabel *)getNavigationBarForTitle:(NSString *) title;
-(void)getNavigationBar:(UINavigationItem *) navigationItem;
- (void)setNavigationBarForViewController:(UIViewController *) view;
- (UILabel *)setLabel:(UILabel *) label withHtml:(NSString*) html;
- (STTwitterAPI *) getTwitterClient;

@end
