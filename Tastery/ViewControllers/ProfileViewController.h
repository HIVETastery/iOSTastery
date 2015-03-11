//
//  ProfileViewController.h
//  Tastery
//
//  Created by Emman Kusumi on 10/13/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController {
    IBOutlet UITextField *txtFirstName, *txtLastName;
    IBOutlet UITextField *txtEmail, *txtTelephone, *txtMobile;
    IBOutlet UITextField *txtAddress;
    IBOutlet UITextField *txtPassword;
}

@end