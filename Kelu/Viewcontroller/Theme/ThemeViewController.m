//
//  ThemeViewController.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "ThemeViewController.h"
#import "ThemeTableView.h"
#import "ThemeResponse.h"

@interface ThemeViewController () <ThemeTableViewDelegate>
{
    NSArray *themes;
    NSArray *arrayOfThemes;
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
        [self fetchThemesFromDB];
        //[self fetchDataForTheme];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


- (void)viewDidLoad
{
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
    [self initializeThemeTableView];
}

- (void)initializeThemeTableView
{
    self.themeTableView.themeDelegate = self;
}

#pragma mark - Delegates

#pragma mark - Language Table View Deleages

- (void)setSelectedTheme:(ThemeModel *)theme
{
    [KKeyChain saveKeyChainValue:theme.tag_code forKey:kKeychainSelectedThemeTag];
    [[NSNotificationCenter defaultCenter] postNotificationName:keluHeaderViewUpdateNotification object:nil];
    [self.tabBarController setSelectedIndex:2];
}

#pragma mark - Fetch

-(void)fetchDataForTheme
{
    [KeluActivityIndicator showIndicator:self.view animated:YES];
    [[ApiResponseHandler sharedApiResponseHandlerInstance] fetchThemesWithParams:[self getTextParameters]
        withSuccessCompletionBlock:^(NSString *responseString) {
            
            [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
            ThemeResponse *themeResponse = [[ThemeResponse alloc] initWithString:responseString error:nil];
            themes = themeResponse.objects;
            [self reload];
            
        } withFailureCompletionBlock:^(NSError *error) {
            
            [KeluActivityIndicator hideIndicatorForView:self.view animated:YES];
            [KeluAlertViewController showAlertControllerWithTitle:@"Error"                                                                                                 message:error.localizedDescription acceptActionTitle:@"OK"                                    acceptActionBlock:nil dismissActionTitle:nil dismissActionBlock:nil presentingViewController:self];
        }];
}

- (void)fetchThemesFromDB
{
    NSString *selectedLanguage = [KKeyChain loadKeyChainValueForKey:kKeychainSelectedLanguageKey];
    NSString *whereEqualValue = [NSString stringWithFormat:@"\"EN2%@\"", selectedLanguage];
    NSString *query = [KeluDatabaseManager getSelectQueryForTableName:kThemeTableName withWhereValue:whereEqualValue forField:kTheme_TransKey];
    
    // Get the results.
    if (arrayOfThemes != nil) {
        arrayOfThemes = nil;
    }
    arrayOfThemes = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    themes = [self convertArrayOfThemesToThemesModelData];
    [self reload];
}

#pragma mark - Parameters
-(NSMutableDictionary*)getTextParameters
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:0];
    [parameters setObject:[KKeyChain loadKeyChainValueForKey:kKeychainSelectedLanguageKey] forKey:@"lan_key"];
    return parameters;
}

#pragma mark - Private Methods
#pragma mark Reload

- (void)reload
{
    self.themeTableView.themes = themes;
}

#pragma mark Language Table

- (NSArray *)convertArrayOfThemesToThemesModelData
{
    NSMutableArray *convertedThemes = [[NSMutableArray alloc] init];
    for (int count = 0; count < [arrayOfThemes count]; count ++)
    {
        ThemeTable *themeTable = [self createThemeTableObjectForIndex:count];
        ThemeModel *model = [ThemeModel convertToThemeJsonModelFromDBThemeTable:themeTable];
        [convertedThemes addObject:model];
    }
    return convertedThemes;
}

- (ThemeTable *)createThemeTableObjectForIndex:(NSInteger)index
{
    
    NSInteger indexOfTagWeight = [self.dbManager.arrColumnNames indexOfObject:kTheme_ThemeWeight];
    NSInteger indexOfTagCode = [self.dbManager.arrColumnNames indexOfObject:kTheme_TagCode];
    NSInteger indexOfTagText = [self.dbManager.arrColumnNames indexOfObject:kTheme_TagText];
    NSInteger indexOfTransKey = [self.dbManager.arrColumnNames indexOfObject:kTheme_TransKey];
    
    ThemeTable *themeTable = [[ThemeTable alloc] init];
    themeTable.themeWeight = [[arrayOfThemes objectAtIndex:index] objectAtIndex:indexOfTagWeight];
    themeTable.themeTagText = [[arrayOfThemes objectAtIndex:index] objectAtIndex:indexOfTagText];
    themeTable.themeTagCode = [[arrayOfThemes objectAtIndex:index] objectAtIndex:indexOfTagCode];
    themeTable.themeTransKey = [[arrayOfThemes objectAtIndex:index] objectAtIndex:indexOfTransKey];
    return themeTable;
}



@end
