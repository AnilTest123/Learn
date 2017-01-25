//
//  KeluAlertViewController.h
//  Kelu
//
//  Created by Nagarajan SD on 25/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeluAlertViewController : UIAlertController

+ (void)showAlertControllerWithTitle:( NSString *)controllerTitle
                             message:(NSString *)controllerMessage
                   acceptActionTitle:(NSString *)acceptActionTitle
                   acceptActionBlock:(void (^ __nullable)(UIAlertAction *action))acceptActionBlock
                  dismissActionTitle:(NSString *)dismissActionTitle
                  dismissActionBlock:(void (^ __nullable)(UIAlertAction *action))dismissActionBlock
            presentingViewController:(UIViewController *)controller;

@end
