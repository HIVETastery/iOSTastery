//
//  LoginController.h
//  Tastery
//
//  Created by Max Von Ongkingco on 8/19/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginController : UIViewController <FBLoginViewDelegate, UIAlertViewDelegate> {
    IBOutlet FBLoginView *btnFBLogin;
    IBOutlet UITextField *txtEmail, *txtPassword;
}

- (IBAction)onLogin:(id)sender;
- (IBAction)onRegister:(id)sender;
- (IBAction)onFBLogin:(UIButton *)sender;
- (IBAction)onTWLogin:(UIButton *)sender;
- (IBAction)onForgotPassword:(id)sender;

@end
