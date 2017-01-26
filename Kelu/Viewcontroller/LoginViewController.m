//
//  LoginViewController.m
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "SignUpViewController.h"
#import "SocialNetworkingView.h"

#define CONTINUE_BUTTON_CORNER_RADIUS 5.0f
#define CONTINUE_BUTTON_SHADOW_OFFSET 5.0f
#define CONTINUE_BUTTON_SHADOW_RADIUS 5.0f
#define CONTINUE_BUTTON_SHADOW_OPACITY 0.7f

@interface LoginViewController () <SocialNetworkingViewDelegate>
{
    
}

@property (nonatomic, weak) IBOutlet UITextField *email;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, weak) IBOutlet UIView *signUpView;
@property (nonatomic, weak) IBOutlet UIButton *continueButton;
@property (nonatomic, weak) IBOutlet UIView *socialView;

@end

@implementation LoginViewController

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
    [self initializeSignupView];
    [self initializeContinueButton];
    [self initializeSocialView];
}

- (void)initializeSignupView
{
    [self addSingleTapGestureOnSignUpView];
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

- (void)addSingleTapGestureOnSignUpView
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSignUpViewTapped:)];
    singleTap.numberOfTouchesRequired = 1;
    singleTap.numberOfTapsRequired = 1;
    [self.signUpView addGestureRecognizer:singleTap];
}

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
- (IBAction)signInButtonPressed:(UIButton *)sender
{
    if ([[self.password text] length])
    {
        [KeluActivityIndicator showIndicator:self.view animated:YES];
        [[ApiResponseHandler sharedApiResponseHandlerInstance] signInUserWith:[self getUserSignInParameters]
                                                     withSuccessCompletionBlock:^(NSString *responseData) {
                                                         [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
                                                         [KKeyChain saveKeyChainValue:@"YES" forKey:kKeychainHasLoggedIn];
                                                         NSLog(@"%@",responseData);
                                                         [((AppDelegate*)[[UIApplication sharedApplication] delegate]) instantiateViewController];
                                                         
                                                     } withFailureCompletionBlock:^(NSError *error) {
                                                         
                                                         [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
                                                         [KeluAlertViewController showAlertControllerWithTitle:@"Error"
                                                                                                       message:error.localizedDescription
                                                                                             acceptActionTitle:@"OK"
                                                                                             acceptActionBlock:nil
                                                                                            dismissActionTitle:nil
                                                                                            dismissActionBlock:nil
                                                                                      presentingViewController:self];
                                                     }];
    }
    else
    {
        [KeluAlertViewController showAlertControllerWithTitle:@"Error"
                                                      message:@"Enter username and password"
                                            acceptActionTitle:@"OK"
                                            acceptActionBlock:^(UIAlertAction * _Nullable action) {
                                                self.password.text = @"";
                                            }
                                           dismissActionTitle:nil
                                           dismissActionBlock:nil
                                     presentingViewController:self];
    }

}

#pragma mark Forgot Password Button
- (IBAction)forgotPasswordButtonPressed:(UIButton *)sender
{
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Gesture Handler

#pragma mark SignUp View Tap Gesture

- (void)handleSignUpViewTapped:(UIGestureRecognizer *)sender
{
    SignUpViewController *signUpViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"SignUpViewController"];
    if([self.navigationController respondsToSelector:@selector(showViewController:sender:)])
        [self.navigationController showViewController:signUpViewController sender:self];
    else
        [self.navigationController pushViewController:signUpViewController animated:YES];
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

#pragma mark - Get Params
- (NSMutableDictionary *)getUserSignInParameters
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:[self.email text] forKey:@"username"];
    [parameters setObject:[self.password text] forKey:@"password"];
    return parameters;
}
@end
