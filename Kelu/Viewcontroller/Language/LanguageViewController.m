//
//  LanguageViewController.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "LanguageViewController.h"
#import "LanguageTableView.h"
#import "LanguageResponse.h"

@interface LanguageViewController () <LanguageTableViewDelegate>
{
    LanguageResponse *languageResponse;
}

@property (weak, nonatomic) IBOutlet LanguageTableView *languageTableView;
@property (weak, nonatomic) IBOutlet UIView *headingView;

@end

@implementation LanguageViewController

#pragma mark - Life Cycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    [self fetchLanguages];
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
    [self customizeHeadingView];
    [self initializeLanguageTableView];
}

- (void)customizeHeadingView
{
    [ViewCustomEffect setShadowEffectOnView:self.headingView];
}

- (void)initializeLanguageTableView
{
    self.languageTableView.languageDelegate = self;
}

#pragma mark - Delegates

#pragma mark - Language Table View Deleages

- (void)setSelectedLanguage:(LanguageModel *)language
{
    [KKeyChain saveKeyChainValue:language.lan_key forKey:kKeychainSelectedLanguageKey];
    [KKeyChain saveKeyChainValue:language.language forKey:kKeychainSelectedLanguageName];
    [[NSNotificationCenter defaultCenter] postNotificationName:keluHeaderViewUpdateNotification object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - API Fetch

#pragma marK Fetch Languages

- (void)fetchLanguages
{
    [KeluActivityIndicator showIndicator:self.view animated:YES];
    [[ApiResponseHandler sharedApiResponseHandlerInstance] fetchLanguagesWithParams:nil
                                                    withSuccessCompletionBlock:^(NSString *responseString)
     {
                                                        
        [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
        languageResponse = [[LanguageResponse alloc] initWithString:responseString error:nil];
        [self reload];
        
    } withFailureCompletionBlock:^(NSError *error) {
        
        [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
        [KeluAlertViewController showAlertControllerWithTitle:@"Error"                                                                                                 message:error.localizedDescription acceptActionTitle:@"OK"                                    acceptActionBlock:nil dismissActionTitle:nil dismissActionBlock:nil presentingViewController:self];
    }];
}

#pragma mark - Private Method

- (void)reload
{
    self.languageTableView.languages = languageResponse.language;
}

@end
