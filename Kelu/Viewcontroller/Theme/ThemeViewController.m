//
//  ThemeViewController.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeTableView.h"
#import "ThemeResponse.h"

@interface ThemeViewController () <ThemeTableViewDelegate>
{
    ThemeResponse *themeResponse;
}

@property (weak, nonatomic) IBOutlet ThemeTableView *themeTableView;

@end

@implementation ThemeViewController

#pragma mark - Life Cycle Method

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.refreshRequired)
    {
        self.refreshRequired = NO;
        [self fetchDataForTheme];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
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
    [super initialize];
    [self initializeLanguageTableView];
}

- (void)initializeLanguageTableView
{
    self.themeTableView.themeDelegate = self;
}

#pragma mark - Delegates

#pragma mark - Language Table View Deleages

- (void)setSelectedTheme:(ThemeModel *)theme
{
    [KKeyChain saveKeyChainValue:theme.tag forKey:kKeychainSelectedThemeTag];
}


#pragma mark - Fetch

-(void)fetchDataForTheme
{
    [KeluActivityIndicator showIndicator:self.view animated:YES];
    [[ApiResponseHandler sharedApiResponseHandlerInstance] fetchThemesWithParams:[self getTextParameters]
                                                    withSuccessCompletionBlock:^(NSString *responseString) {
                                                        
                                                        [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
                                                        themeResponse = [[ThemeResponse alloc] initWithString:responseString error:nil];
                                                        [self reload];
                                                        
                                                    } withFailureCompletionBlock:^(NSError *error) {
                                                        
                                                        [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
                                                        [KeluAlertViewController showAlertControllerWithTitle:@"Error"                                                                                                 message:error.localizedDescription acceptActionTitle:@"OK"                                    acceptActionBlock:nil dismissActionTitle:nil dismissActionBlock:nil presentingViewController:self];
                                                    }];
}

#pragma mark - Parameters
-(NSMutableDictionary*)getTextParameters
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:[KKeyChain loadKeyChainValueForKey:kKeychainSelectedLanguageKey] forKey:@"lan_key"];
    return parameters;
}

#pragma mark - Private Method

- (void)reload
{
    self.themeTableView.themes = themeResponse.objects;
}



@end
