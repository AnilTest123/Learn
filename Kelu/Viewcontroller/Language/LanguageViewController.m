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
    KeluDatabaseManager *dbManager;
}

@property (weak, nonatomic) IBOutlet LanguageTableView *languageTableView;
@property (weak, nonatomic) IBOutlet UIView *headingView;
@property (nonatomic, strong) NSArray *arrLanguages;

@end

@implementation LanguageViewController

#pragma mark - Life Cycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    //[self fetchLanguages];
    [self fetchLanguagesFromDB];
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
    [self initializeVariables];
    [self customizeHeadingView];
    [self initializeLanguageTableView];
}

- (void)initializeVariables
{
    dbManager = [KeluDatabaseManager sharedDatabaseManagerInstance];
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

- (void)setSelectedLanguage:(LanguageTable *)language
{
    [KKeyChain saveKeyChainValue:language.languageKey forKey:kKeychainSelectedLanguageKey];
    [KKeyChain saveKeyChainValue:language.languageText forKey:kKeychainSelectedLanguageName];
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

- (void)fetchLanguagesFromDB
{
    NSString *query = [KeluDatabaseManager getSelectQueryForTableName:kLanguageTableName];
    
    // Get the results.
    if (self.arrLanguages != nil) {
        self.arrLanguages = nil;
    }
    self.arrLanguages = [[NSArray alloc] initWithArray:[dbManager loadDataFromDB:query]];
    [self reload];
}

#pragma mark - Private Method

- (void)reload
{
    //self.languageTableView.languages = languageResponse.language;
    NSArray *arrayOfLanguages = [self convertArrayOfLanguagesToLanguageTableData];
    self.languageTableView.languages = arrayOfLanguages;
}

#pragma mark - Private Methods
#pragma mark Language Table

- (NSArray *)convertArrayOfLanguagesToLanguageTableData
{
    NSMutableArray *languages = [[NSMutableArray alloc] init];
    for (int count = 0; count < [self.arrLanguages count]; count ++)
    {
        LanguageTable *languageTable = [self createLanguageTableObjectForIndex:count];
        [languages addObject:languageTable];
    }
    return languages;
}

- (LanguageTable *)createLanguageTableObjectForIndex:(NSInteger)index
{
    LanguageTable *languageTable = [[LanguageTable alloc] init];
    NSInteger indexOfLanguageKey = [dbManager.arrColumnNames indexOfObject:kLanguage_LangugeKey];
    NSInteger indexOfLanguageText = [dbManager.arrColumnNames indexOfObject:kLanguage_LangugeText];
    languageTable.languageKey = [[self.arrLanguages objectAtIndex:index] objectAtIndex:indexOfLanguageKey];
    languageTable.languageText = [[self.arrLanguages objectAtIndex:index] objectAtIndex:indexOfLanguageText];
    return languageTable;
    
}


@end
