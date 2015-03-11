//
//  RegistrationViewController.m
//  Tastery
//
//  Created by Emman Kusumi on 9/22/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "RegistrationViewController.h"
#import "PasswordViewController.h"
#import "TasteryAPIManager.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController

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
    
    UIBarButtonItem *confirm = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(onConfirm)];
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
    
    if([[txtEmail text] isEqualToString:[txtConfirm text]]) {
        TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];
        [api registerWithFirstName:[txtFirstName text]
                          lastName:[txtLastName text]
                             email:[txtEmail text]
                            mobile:[txtMobile text]
                         telephone:[txtTelephone text]
                           company:@""
                          address1:[txtAddress text]
                          address2:@""
                              city:[txtCity text]
                          password:[txtPassword text]
                      withCallback:^(NSDictionary *info) {
                          
                          NSDictionary *message = [info valueForKey:@"message"];
                          
                          NSMutableString *alertMessage = [NSMutableString new];
                          for(id key in [message allKeys]) {
                              NSString *value = [message valueForKey:key];
                              [alertMessage appendString:key];
                              [alertMessage appendString:@":"];
                              [alertMessage appendString:value];
                              [alertMessage appendString:@"\n"];
                          }
                          
                          if([alertMessage length] == 0) {
                              [alertMessage appendString:@"A link has been sent to your e-mail for activation of your account. Please activate first then login after."];
                              [[self navigationController] popViewControllerAnimated:YES];
                              
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tastery" message:alertMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                              [alert show];
                          } else {
                              UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tastery" message:alertMessage delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                              [alert show];
                          }
                      }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tastery" message:@"Error: Emails don't match." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)onBack {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
