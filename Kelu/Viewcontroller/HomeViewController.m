//
//  ContentViewController.m
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "HomeViewController.h"
#import "TextsResponse.h"
#import "HomeTableView.h"

@interface HomeViewController ()
{
    NSIndexPath *selectedIndexPath;
    TextsResponse *textsResponse;
}

@property (weak, nonatomic) IBOutlet HomeTableView *homeTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *arrPeopleInfo;

@end

@implementation HomeViewController

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initialize];
    if (self.refreshRequired)
    {
        self.refreshRequired = NO;
        [self fetchDataForHome];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark - Initialization

- (void)initialize
{
    [super initialize];
    [self addThemeChangeNotification];
}

- (void)addThemeChangeNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadHomeView)
                                                 name:keluThemeChangeNotification
                                               object:nil];
}

- (void)reloadHomeView
{
    self.refreshRequired = YES;
}

#pragma mark - Fetch

-(void)fetchDataForHome
{
    [KeluActivityIndicator showIndicator:self.view animated:YES];
    [[ApiResponseHandler sharedApiResponseHandlerInstance] fetchTextWithParams:[self getTextParameters]
        withSuccessCompletionBlock:^(NSString *responseString) {
            
            [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
            textsResponse = [[TextsResponse alloc] initWithString:responseString error:nil];
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
    [parameters setObject:[KKeyChain loadKeyChainValueForKey:kKeychainSelectedThemeTag] forKey:@"tag_code"];
    [parameters setObject:[KKeyChain loadKeyChainValueForKey:kKeychainSelectedLanguageKey] forKey:@"dest_lan_key"];
    return parameters;
}

#pragma mark - Private Method

- (void)reload
{
    self.homeTableView.textResponse = textsResponse.TextsResponse;
}

@end
