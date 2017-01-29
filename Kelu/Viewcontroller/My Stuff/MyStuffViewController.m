//
//  MyStuffViewController.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "MyStuffViewController.h"
#import "SignUpViewController.h"

@interface MyStuffViewController ()

@end

@implementation MyStuffViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.refreshRequired)
    {
        self.refreshRequired = NO;
        //[self fetchDataForTheme];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self validateLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - initialization

-(void)validateLogin
{
    if ([(NSString*)[KKeyChain loadKeyChainValueForKey:kKeychainHasLoggedIn] isEqualToString:@"YES"])
    {
        [self initializeMyStuff];
    }
    else
    {
        [self initializeLogin];
    }
}

-(void)initializeMyStuff
{
    
}

-(void)initializeLogin
{
    SignUpViewController *signUpController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    if([self.navigationController respondsToSelector:@selector(showViewController:sender:)])
        [self.navigationController showViewController:signUpController sender:self];
    else
        [self.navigationController pushViewController:signUpController animated:YES];
}

@end
