//
//  TasteryAppManager.m
//  Tastery
//
//  Created by Emman Kusumi on 8/30/14.
//  Copyright (c) 2014 Kusumi. All rights reserved.
//

#import "TasteryAppManager.h"
#import "STTwitterAPI.h"

@implementation TasteryAppManager

static TasteryAppManager *tasteryAppManager = nil;

+(TasteryAppManager *)getTasteryAppManager {
    if(tasteryAppManager==nil) {
        tasteryAppManager = [TasteryAppManager new];
    }
    return tasteryAppManager;
}

+(void)cancelAppManager {
    tasteryAppManager = nil;
}

-(UILabel *)getNavigationBarForTitle:(NSString *) title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:[UIFont fontWithName:@"GearedSlab-Thin" size:24]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:title];
    [label sizeToFit];
    return label;
}

-(void)getNavigationBar:(UINavigationItem *) navigationItem {
    [navigationItem setTitleView:[[UIImageView alloc]
                                  initWithImage:[UIImage imageNamed:@"navBar"]]];
}

- (void)setNavigationBarForViewController:(UIViewController *) view {
    [[[view navigationController] navigationBar] setBarTintColor:[self blueColor]];
    [[[view navigationController] navigationBar] setTranslucent:NO];
    [[[view navigationController] navigationBar] setAlpha:1.00];
}

- (UILabel *)setLabel:(UILabel *) label withHtml:(NSString*) html {
    NSError *err = nil;
    [label setAttributedText:[[NSAttributedString alloc]
                             initWithData: [html dataUsingEncoding:NSUTF8StringEncoding]
                             options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                             documentAttributes: nil
                             error: &err]];
    if(err) {
        NSLog(@"Unable to parse label text: %@", err);
    }
    return label;
}

- (STTwitterAPI *) getTwitterClient {
    if([self twitter] == nil) {
        [self setTwitter:[STTwitterAPI twitterAPIWithOAuthConsumerKey:@"3HEwYBXmrJnP3iZqH611JIVF4"
                                                      consumerSecret:@"siz6XrXB0PdLXnZgKx5LGjSzDywhM7vlyiVYkGbBlLF1Ba8hdK"]];
    }
    return [self twitter];
}

@end
