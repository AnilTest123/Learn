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

typedef enum : NSUInteger {
    kSignUpSuccess,
    kSignUpError,
    kEmailAddressError,
    kPasswordMismatchError
} SignUpStatus;

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
    [ViewCustomEffect setShadowEffectOnButton:self.continueButton];
}

#pragma mark - Button Action Method

#pragma mark Sign In Button
- (IBAction)signUpButtonPressed:(UIButton *)sender
{
    if ([self validateEmailAddress:[self.email text]])
    {
        if ([[self.password text] isEqualToString:[self.confirmPassword text]])
        {
            [KeluActivityIndicator showIndicator:self.view animated:YES];
            [[ApiResponseHandler sharedApiResponseHandlerInstance] registerUserWith:[self getUserRegisterParameters]
                                                         withSuccessCompletionBlock:^(NSString *responseData) {
                                                             [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
                                                             
                                                             [self showAlertErrorMessageForSignUpErrorType:kSignUpSuccess error:nil];
                                                             
                                                         } withFailureCompletionBlock:^(NSError *error) {
                                                             
                                                             [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
                                                             [self showAlertErrorMessageForSignUpErrorType:kSignUpError error:error.localizedDescription];
                                                         }];
        }
        else
        {
            [self showAlertErrorMessageForSignUpErrorType:kPasswordMismatchError error:nil];
        }
    }
    else
    {
        [self showAlertErrorMessageForSignUpErrorType:kEmailAddressError error:nil];
    }
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

#pragma mark - Private Method

- (NSMutableDictionary *)getUserRegisterParameters
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:[self.email text] forKey:@"email"];
    [parameters setObject:[self.email text] forKey:@"username"];
    [parameters setObject:[self.password text] forKey:@"password"];
    return parameters;
}

- (BOOL) validateEmailAddress: (NSString *) emailAddress
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailAddress];
}

- (void)showAlertErrorMessageForSignUpErrorType:(SignUpStatus)errorType error:(NSString *)error
{
    NSString *message = @"", *title = @"";
    if (errorType == kEmailAddressError)
    {
        title = @"Invalid Email Address";
        message = @"Please enter the valid email address to sign up";
    }
    else if(errorType == kPasswordMismatchError)
    {
        title = @"Password Mismatch";
        message = @"Please enter the password and confirm password same";
    }
    else if (errorType == kSignUpSuccess)
    {
        title = @"Success";
        message = @"Sign Up successfully completed please login with your username and password";
    }
    else
    {
        title = @"Error";
        message = error;
    }
    [KeluAlertViewController showAlertControllerWithTitle:title
                                                  message:message
                                        acceptActionTitle:@"OK"
                                        acceptActionBlock:^(UIAlertAction * _Nullable action) {
                                            switch (errorType) {
                                                case kSignUpSuccess:
                                                    [self signUpSuccess];
                                                    break;
                                                case kSignUpError:
                                                    [self userAleradyExist];
                                                    break;
                                                case kEmailAddressError:
                                                    [self clearAllSignUpFields];
                                                    break;
                                                case kPasswordMismatchError:
                                                    [self clearPasswordConfirmPasswordField];
                                                    break;
                                                default:
                                                    break;
                                            }
                                        }
                                       dismissActionTitle:nil
                                       dismissActionBlock:nil
                                 presentingViewController:self];
}

- (void)clearAllSignUpFields
{
    self.email.text = @"";
    self.password.text = @"";
    self.confirmPassword.text = @"";
}

- (void)clearPasswordConfirmPasswordField
{
    self.password.text = @"";
    self.confirmPassword.text = @"";
}

- (void)signUpSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)userAleradyExist
{
    [self clearAllSignUpFields];
}

@end
