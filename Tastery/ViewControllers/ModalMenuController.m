//
//  ModalMenuController.m
//  Tastery
//
//  Created by Max Von Ongkingco on 8/20/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "ModalMenuController.h"
#import "TasteryAPIManager.h"
#import "TasteryAppManager.h"

@interface ModalMenuController ()

@end

@implementation ModalMenuController

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
    TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
    [[self navigationItem] setTitleView:[tastery getNavigationBarForTitle:@"Menu"]];
    
    MenuObject *menu = [self menuObject];
    
    [lblName setText:[menu name]];
    [lblDescription setText:[menu menu_description]];
    [lblPrice setText:[menu price]];
    
    if([menu thumb]) {
        if([[menu thumb] isKindOfClass:[NSString class]]) {
            NSString *encodedString = [menu thumb];
            encodedString = [encodedString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            
            NSURL *url = [NSURL URLWithString:encodedString];
            [self downloadImageWithURL:url completionBlock:^(BOOL succeeded, UIImage *image) {
                
                if(succeeded == YES) {
                    
                    [imgMenu setImage:image];
                    
                }
                
            }];
            
            // UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            // [[cell imgMenu] setImage:image];
        }
    }
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (IBAction)onAddToCart:(id)sender {
    TasteryAPIManager *api = [TasteryAPIManager getTasteryAPIManager];

    NSString *date = [api getStringFromDate:[NSDate date]];
    
    [api addToCartProductId:[[self menuObject] product_id]
                   quantity:@"1"
                      place:[api currentCity]
               deliveryDate:date
               WithCallback:^(NSDictionary *info) {
                  
                   TasteryAppManager *tastery = [TasteryAppManager getTasteryAppManager];
                   [[tastery cartList] addObject:[self menuObject]];
                   [[self navigationController] popToRootViewControllerAnimated:YES];
                   
               }];
}

- (void)onBack {
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
