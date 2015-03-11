//
//  ContactUsViewController.h
//  Tastery
//
//  Created by Emman Kusumi on 11/23/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactUsViewController : UIViewController <UIActionSheetDelegate> {
    IBOutlet UIWebView *webView;
    IBOutlet UITextField *txtName, *txtEmail, *txtMobile, *txtEnquiry, *txtCaptcha;
}

-(IBAction)onContinue:(id)sender;

@end
