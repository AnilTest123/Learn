//
//  SignUpViewController.m
//  Kelu
//
//  Created by Nagarajan SD on 24/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "SignUpViewController.h"
#import "SocialNetworkingView.h"

#define CONTINUE_BUTTON_CORNER_RADIUS 5.0f
#define CONTINUE_BUTTON_SHADOW_OFFSET 5.0f
#define CONTINUE_BUTTON_SHADOW_RADIUS 5.0f
#define CONTINUE_BUTTON_SHADOW_OPACITY 0.7f

@interface SignUpViewController () <SocialNetworkingViewDelegate>

@property (nonatomic, weak) IBOutlet UITextField *email;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, weak) IBOutlet UITextField *confirmPassword;
@property (nonatomic, weak) IBOutlet UIButton *continueButton;
@property (nonatomic, weak) IBOutlet UIView *socialView;

@end

@implementation SignUpViewController

#pragma mark - Life Cycle method

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Initialization

- (void)initialize
{
    [self initializeContinueButton];
    [self initializeSocialView];
}

- (void)initializeContinueButton
{
    [self customizeContinueButton];
}

- (void)initializeSocialView
{
    SocialNetworkingView *socialNetworkingView = [SocialNetworkingView initializeSocialNetworkingViewWithFrame:self.socialView.bounds];
    socialNetworkingView.delegate = self;
    [self.socialView addSubview:socialNetworkingView];
}


#pragma mark - Customization Method


- (void)customizeContinueButton
{
    self.continueButton.layer.cornerRadius = CONTINUE_BUTTON_CORNER_RADIUS;
    self.continueButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.continueButton.layer.shadowOffset = CGSizeMake(CONTINUE_BUTTON_SHADOW_OFFSET, CONTINUE_BUTTON_SHADOW_OFFSET);
    self.continueButton.layer.shadowRadius = CONTINUE_BUTTON_SHADOW_RADIUS;
    self.continueButton.layer.shadowOpacity = CONTINUE_BUTTON_SHADOW_OPACITY;
}

#pragma mark - Button Action Method

#pragma mark Sign In Button
- (IBAction)signUpButtonPressed:(UIButton *)sender
{
    
}

#pragma mark - Delegates

#pragma mark Social Networking View Delegates

- (void)facebookButtonPressed
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)twitterButtonPressed
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)googlePlusButtonPressed
{
    NSLog(@"%s", __FUNCTION__);
}



@end
