//
//  TermsViewController.h
//  Tastery
//
//  Created by Emman Kusumi on 11/21/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate> {
    IBOutlet UITextView *txtTerms;
}

@property (nonatomic) NSInteger type;

+ (TermsViewController *) getTermsViewController;

@end
