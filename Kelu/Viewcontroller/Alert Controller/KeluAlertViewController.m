//
//  KeluAlertViewController.m
//  Kelu
//
//  Created by Anil Chopra on 25/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "KeluAlertViewController.h"


@implementation KeluAlertViewController

+ (void)showAlertControllerWithTitle:(NSString *)controllerTitle message:(NSString *)controllerMessage acceptActionTitle:(NSString *)acceptActionTitle acceptActionBlock:(void (^)(UIAlertAction *))acceptActionBlock dismissActionTitle:(NSString *)dismissActionTitle dismissActionBlock:(void (^)(UIAlertAction *))dismissActionBlock presentingViewController:(UIViewController*)controller
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:controllerTitle
                                                                             message:controllerMessage
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    if (acceptActionTitle != nil)
    {
        UIAlertAction *acceptAction = [UIAlertAction actionWithTitle:acceptActionTitle
                                                               style:UIAlertActionStyleDefault
                                                             handler:acceptActionBlock];
        [alertController addAction:acceptAction];
    }
    
    if (dismissActionTitle != nil)
    {
        UIAlertAction *dismissAction = [UIAlertAction actionWithTitle:dismissActionTitle
                                                                style:UIAlertActionStyleCancel
                                                              handler:dismissActionBlock];
        [alertController addAction:dismissAction];
    }
    
    if (controller != nil)
    {
        [controller presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        controller = [self topMostController];
        [controller presentViewController:alertController animated:YES completion:nil];
    }
}

+ (id)getRootViewController
{
    id rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if([rootViewController isKindOfClass:[UINavigationController class]])
    {
        rootViewController = ((UINavigationController *)rootViewController).viewControllers.firstObject;
    }
    if([rootViewController isKindOfClass:[UITabBarController class]])
    {
        rootViewController = ((UITabBarController *)rootViewController).selectedViewController;
    }
    return rootViewController;
}

+ (id) topMostController
{
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController)
    {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

@end
