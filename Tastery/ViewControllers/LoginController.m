//
//  LoginController.m
//  Tastery
//
//  Created by Max Von Ongkingco on 8/19/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "LoginController.h"
#import "TasteryAppManager.h"
#import "UserObject.h"
#import "TasterySocialManager.h"
#import "RegistrationViewController.h"
#import "TasteryAPIManager.h"
#import "STTwitterAPI.h"

@interface LoginController ()

@end

@implementation LoginController

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTwitterEmail:) name:@"getTwitterEmail" object:nil];
    
    TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
    [[self navigationItem] setTitleView:[tastery getNavigationBarForTitle:@"Login"]];
    
    for(UIView *view in [[self view] subviews]) {
        if([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            [[btn layer] setCornerRadius:25.0];
        }
    }
    
    [btnFBLogin setDelegate:self];
    [btnFBLogin setReadPermissions:@[@"public_profile", @"email", @"user_friends", @"read_stream",@"public_profile"]];
    
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

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onFBLogin:(UIButton *)sender {
    for (id obj in [btnFBLogin subviews]) {
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton * loginButton =  obj;
            [loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
        if ([obj isKindOfClass:[UILabel class]]){
            UILabel * loginLabel =  obj;
            loginLabel.text = @"";
            loginLabel.textAlignment = NSTextAlignmentCenter;
            [loginLabel setFont:[UIFont systemFontOfSize:27]];
            [loginLabel setHidden:YES];
        }
    }
}

- (IBAction)onTWLogin:(UIButton *)sender {
    TasteryAppManager *app = [TasteryAppManager getTasteryAppManager];
    [[app getTwitterClient] postTokenRequest:^(NSURL *url, NSString *oauthToken) {
        [[UIApplication sharedApplication] openURL:url];
    } authenticateInsteadOfAuthorize:NO
                              forceLogin:@(YES)
                              screenName:nil
                           oauthCallback:@"myapp://twitter_access_tokens/"
                              errorBlock:^(NSError *error) {
                                  NSLog(@"-- error: %@", [error localizedDescription]);
                              }];
}

- (void) getTwitterEmail:(NSNotification *) notif {
    NSMutableDictionary *info = [notif userInfo];
    TasteryAccount *account = [info valueForKey:@"Account"];
    
    TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
    [social setCurrentAccount:account];
    
    UIAlertView *alertViewChangeName = [[UIAlertView alloc]initWithTitle:@"Tastery"
                                                                 message:[NSString stringWithFormat:@"%@, what is your email address?",[account firstname]]
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:@"Save",nil];
    alertViewChangeName.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertViewChangeName show];
}

#pragma mark Facebook SDK

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
    UserObject *userObject = [UserObject new];
    [userObject readFromDictionary:(NSDictionary *)user];
    [social setFBUser:userObject];
    
    TasteryAccount *account = [TasteryAccount new];
    [account readFromDictionary:(NSDictionary *)user];
    [social setCurrentAccount:account];
    
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    [api registerSocialWithFirstName:[account firstname]
                            lastName:[account lastname]
                               email:[account email] withCallback:^(NSDictionary *info) {
        
                                   
                                   
    }];

    [self performSelector:@selector(dismiss) withObject:nil afterDelay:1.0];
}


- (void)dismiss {
    TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
    if([social currentAccount] != nil) {
        [[self navigationController] popToRootViewControllerAnimated:YES];
    }
}

- (IBAction)onLogin:(id)sender {
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
    
    [api loginWithUsername:[txtEmail text]
                  Password:[txtPassword text]
              withCallback:^(TasteryAccount *account) {
        
            if([account approved] == YES) {
                TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
                [social setCurrentAccount:account];
            }
                  
        
    }];
    
    [[self navigationController] popToRootViewControllerAnimated:YES];
    
}

- (IBAction)onRegister:(id)sender {
    RegistrationViewController *registerView = [RegistrationViewController new];
    [[self navigationController] pushViewController:registerView animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    TasterySocialManager *social = [TasterySocialManager getTasterySocialManager];
    TasteryAccount *account = [social currentAccount];
    
    if(buttonIndex != [alertView cancelButtonIndex]) {
        
        [[self navigationController] popToRootViewControllerAnimated:YES];
        
        NSString *email = [[alertView textFieldAtIndex:0] text];
        [account setEmail:email];
        
        TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
        [api registerSocialWithFirstName:[account firstname]
                                lastName:@" "
                                   email:[account email] withCallback:^(NSDictionary *info) {
                                       
                                       
                                       
                                   }];
    }
}

- (void)onBack {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)onForgotPassword:(id)sender {
    if([[txtEmail text] length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tastery"
                                                        message:@"Email Address field is empty!"
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    } else {
        TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
        [api forgotPasswordForEmail:[txtEmail text]
                       withCallback:^(NSDictionary *info) {
                           
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tastery"
                                                                           message:@"A new password has been sent to your email."
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"Ok"
                                                                 otherButtonTitles:nil];
                           [alert show];
            
        }];
    }
}

@end
