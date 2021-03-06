//
//  MyStuffViewController.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "MyStuffViewController.h"
#import "LoginViewController.h"
typedef enum {
    kQuestionsForMe,
    kMyQuestions,
    kMyAnswers,
    kFavorites,
}kSegmentedControlIndex;

@interface MyStuffViewController ()<LoginViewControllerDelegate>
@property(nonatomic,strong)IBOutlet UISegmentedControl *segmentedControl;
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
    LoginViewController *loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    loginViewController.delegate = self;
    if([self.navigationController respondsToSelector:@selector(showViewController:sender:)])
        [self.navigationController showViewController:loginViewController sender:self];
    else
        [self.navigationController pushViewController:loginViewController animated:YES];
}

#pragma mark - Actions
- (IBAction)actionOnSegmentedControl:(id)sender {
    
}

#pragma mark - Delegate
#pragma mark LoginViewController Delegate
-(void)loginSuccessful
{
    [self validateLogin];
}

@end
