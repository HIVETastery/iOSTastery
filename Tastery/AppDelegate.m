//
//  AppDelegate.m
//  Tastery
//
//  Created by Emman Kusumi on 8/16/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "HomeViewController.h"
#import "MenuViewController.h"
#import "STTwitterAPI.h"
#import "TasteryAppManager.h"
#import "TasteryAPIManager.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    [self initializeFBLibrary];
    [self setupNavBar];
    
    HomeViewController *home = [HomeViewController getHomeViewController];
    MenuViewController *menu = [MenuViewController new];
    
    UINavigationController *navHome = [[UINavigationController alloc] initWithRootViewController:home];
    UINavigationController *navMenu = [[UINavigationController alloc] initWithRootViewController:menu];
    
    [self setNavigationBarForViewController:home];
    [self setNavigationBarForViewController:menu];
    
    MMDrawerController *drawer = [[MMDrawerController alloc] initWithCenterViewController:navHome leftDrawerViewController:navMenu];
    [drawer setShowsShadow:NO];
    [drawer setRestorationIdentifier:@"MMDrawer"];
    [drawer setMaximumLeftDrawerWidth:130.0];
    
    [drawer setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawer setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [[self window] setRootViewController:drawer];
    
    TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
    [tastery setHomeViewController:home];
    [tastery setMenuViewController:menu];
    [tastery setDrawerViewController:drawer];
    
    [[self window] setTintColor:[UIColor whiteColor]];
    [[self window] setBackgroundColor:[UIColor whiteColor]];
    [[self window] makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    NSLog(@"URL SCHEME %@",[url scheme]);
    
    if ([[url scheme] isEqualToString:@"myapp"]) {
        NSDictionary *d = [self parametersDictionaryFromQueryString:[url query]];
        NSString *token = d[@"oauth_token"];
        NSString *verifier = d[@"oauth_verifier"];
        
        TasteryAppManager *app = [TasteryAppManager getTasteryAppManager];
        [[app getTwitterClient] postAccessTokenRequestWithPIN:verifier successBlock:^(NSString *oauthToken, NSString *oauthTokenSecret, NSString *userID, NSString *screenName) {
            
            [[app getTwitterClient] getUsersShowForUserID:nil orScreenName:screenName includeEntities:nil successBlock:^(NSDictionary *user) {
                
                /*
                 {
                 "contributors_enabled" = 0;
                 "created_at" = "Fri Jul 01 13:55:16 +0000 2011";
                 "default_profile" = 0;
                 "default_profile_image" = 0;
                 description = "My ignorance amuses me";
                 entities =     {
                 description =         {
                 urls =             (
                 );
                 };
                 };
                 "favourites_count" = 10;
                 "follow_request_sent" = 0;
                 "followers_count" = 87;
                 following = 0;
                 "friends_count" = 126;
                 "geo_enabled" = 1;
                 id = 327390815;
                 "id_str" = 327390815;
                 "is_translation_enabled" = 0;
                 "is_translator" = 0;
                 lang = en;
                 "listed_count" = 1;
                 location = "Olongapo City, Philippines";
                 name = "Emman Kusumi";
                 "needs_phone_verification" = 0;
                 notifications = 0;
                 "profile_background_color" = 1A1B1F;
                 "profile_background_image_url" = "http://abs.twimg.com/images/themes/theme9/bg.gif";
                 "profile_background_image_url_https" = "https://abs.twimg.com/images/themes/theme9/bg.gif";
                 "profile_background_tile" = 0;
                 "profile_banner_url" = "https://pbs.twimg.com/profile_banners/327390815/1408269254";
                 "profile_image_url" = "http://pbs.twimg.com/profile_images/2309477422/6y0aa9t2d03vkilb1sli_normal.jpeg";
                 "profile_image_url_https" = "https://pbs.twimg.com/profile_images/2309477422/6y0aa9t2d03vkilb1sli_normal.jpeg";
                 "profile_link_color" = ED2F2F;
                 "profile_location" = "<null>";
                 "profile_sidebar_border_color" = 000000;
                 "profile_sidebar_fill_color" = 252429;
                 "profile_text_color" = 666666;
                 "profile_use_background_image" = 1;
                 protected = 0;
                 "screen_name" = emmandroidy;
                 status =     {
                 contributors = "<null>";
                 coordinates = "<null>";
                 "created_at" = "Wed Nov 19 03:11:20 +0000 2014";
                 entities =         {
                 hashtags =             (
                 );
                 symbols =             (
                 );
                 urls =             (
                 {
                 "display_url" = "instagram.com/p/vkNSd6Bdtq/";
                 "expanded_url" = "http://instagram.com/p/vkNSd6Bdtq/";
                 indices =                     (
                 20,
                 42
                 );
                 url = "http://t.co/rL0BDlHV0r";
                 }
                 );
                 "user_mentions" =             (
                 );
                 };
                 "favorite_count" = 0;
                 favorited = 0;
                 geo = "<null>";
                 id = 534906743025696768;
                 "id_str" = 534906743025696768;
                 "in_reply_to_screen_name" = "<null>";
                 "in_reply_to_status_id" = "<null>";
                 "in_reply_to_status_id_str" = "<null>";
                 "in_reply_to_user_id" = "<null>";
                 "in_reply_to_user_id_str" = "<null>";
                 lang = en;
                 place = "<null>";
                 "possibly_sensitive" = 0;
                 "retweet_count" = 0;
                 retweeted = 0;
                 source = "<a href=\"http://instagram.com\" rel=\"nofollow\">Instagram</a>";
                 text = "Goodbye 5. Hello 6! http://t.co/rL0BDlHV0r";
                 truncated = 0;
                 };
                 "statuses_count" = 615;
                 suspended = 0;
                 "time_zone" = "Hong Kong";
                 url = "<null>";
                 "utc_offset" = 28800;
                 verified = 0;
                 }
                 */
                
                TasteryAccount *account = [TasteryAccount new];
                [account readFromDictionary:(NSDictionary *)user];
                
                NSMutableDictionary *info = [NSMutableDictionary new];
                [info setValue:account forKey:@"Account"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getTwitterEmail" object:nil userInfo:info];
                
            } errorBlock:^(NSError *error) {
                //
            }];
        } errorBlock:^(NSError *error) {
            NSLog(@"-- %@", [error localizedDescription]);
        }];
        
        return YES;
    } else {
        BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
        return wasHandled;
    }
}

- (void)initializeFBLibrary {
    [FBLoginView class];
}

- (void)setNavigationBarForViewController:(UIViewController *) view {
    TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
    [tastery setBlueColor:[UIColor colorWithRed:0 green:0.325 blue:0.459 alpha:1]];
    [tastery setWhiteColor:[UIColor whiteColor]];
    
    [[[view navigationController] navigationBar] setBarTintColor:[tastery blueColor]];
    [[[view navigationController] navigationBar] setTranslucent:NO];
    [[[view navigationController] navigationBar] setAlpha:1.00];
}

- (void)setupNavBar {
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 0);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"GearedSlab-Thin" size:21.0], NSFontAttributeName, nil]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0 green:0.325 blue:0.459 alpha:1]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont
                                                                           fontWithName:@"GearedSlab-Thin" size:21], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:attributes];
    
    // Set Font
    /*
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
    
    /*[[UILabel appearance] setFont:[UIFont fontWithName:@"BrandonGrotesque-Light" size:14.0]];
    [[[UIButton appearance] titleLabel] setFont:[UIFont fontWithName:@"BrandonGrotesque-Light" size:14.0]];
    [[UITextField appearance] setFont:[UIFont fontWithName:@"BrandonGrotesque-Light" size:14.0]];
    [[UITextView appearance] setFont:[UIFont fontWithName:@"BrandonGrotesque-Light" size:14.0]];*/
}

- (NSDictionary *)parametersDictionaryFromQueryString:(NSString *)queryString {
    
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
    NSArray *queryComponents = [queryString componentsSeparatedByString:@"&"];
    
    for(NSString *s in queryComponents) {
        NSArray *pair = [s componentsSeparatedByString:@"="];
        if([pair count] != 2) continue;
        
        NSString *key = pair[0];
        NSString *value = pair[1];
        
        md[key] = value;
    }
    
    return md;
}

@end
