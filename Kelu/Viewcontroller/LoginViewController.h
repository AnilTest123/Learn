//
//  LoginViewController.h
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate <NSObject>

-(void)loginSuccessful;

@end
@interface LoginViewController : UIViewController
@property(nonatomic,weak) id<LoginViewControllerDelegate> delegate;
@end
