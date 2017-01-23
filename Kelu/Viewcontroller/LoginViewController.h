//
//  LoginViewController.h
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)signInButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *signUpView;

@end
