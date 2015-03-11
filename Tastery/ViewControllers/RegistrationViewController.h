//
//  RegistrationViewController.h
//  Tastery
//
//  Created by Emman Kusumi on 9/22/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController {
    IBOutlet UITextField *txtFirstName, *txtLastName;
    IBOutlet UITextField *txtAddress;
    IBOutlet UITextField *txtCity;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtConfirm;
    IBOutlet UITextField *txtMobile;
    IBOutlet UITextField *txtTelephone;
    IBOutlet UITextField *txtPassword;
}

@end