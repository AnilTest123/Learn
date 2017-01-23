//
//  RootViewController.m
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "RootViewController.h"
#define MENU_WIDTH 200
@interface RootViewController ()

@end

@implementation RootViewController

- (void)awakeFromNib
{
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    self.delegate = self;
    self.menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    CGRect bounds = [self resizeForLandscapeViewIfAny];
    self.menuViewSize = CGSizeMake(MENU_WIDTH, bounds.size.height);
}

-(CGRect)resizeForLandscapeViewIfAny{
    CGRect bounds = [[UIScreen mainScreen] bounds]; // portrait bounds
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);
    }
    return bounds;
}

-(void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController
{
    CGRect bounds = [self resizeForLandscapeViewIfAny];
    [self resizeMenuViewControllerToSize:CGSizeMake(MENU_WIDTH, bounds.size.height)];
}
@end
