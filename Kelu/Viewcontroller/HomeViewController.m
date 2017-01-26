//
//  ContentViewController.m
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "HomeViewController.h"
#import "TextsResponse.h"
#import "CHTumblrMenuView.h"
#import "ContentTableViewCell.h"

@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource,ContentTableViewCellDelegate>
{
    NSIndexPath *selectedIndexPath;
    TextsResponse *textsResponse;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

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
    if (refreshRequired)
    {
        refreshRequired = NO;
        [self fetchDataForHome];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
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
    [parameters setObject:@"TAG00001" forKey:@"tag_code"];
    [parameters setObject:[KKeyChain loadKeyChainValueForKey:kKeychainSelectedLanguageKey] forKey:@"dest_lan_key"];
    return parameters;
}

#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [textsResponse.TextsResponse count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"ContentTableViewCell";
    ContentTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate = self;
    cell.textModel = [textsResponse.TextsResponse objectAtIndex:indexPath.section];
    cell.bottomView.hidden = YES;
    cell.bottomViewHeight.constant = 0;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

#pragma mark Reload
-(void)reload
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
#pragma mark - Delegates
-(void)tappedOnShareForObject:(TextModel *)textModel
{
    CHTumblrMenuView *menuView = [[CHTumblrMenuView alloc] init];
    //menuView.backgroundImgView.backgroundColor = [UIColor clearColor];
    menuView.backgroundImgView.alpha = 0.3;
    [menuView addMenuItemWithTitle:@"Quote" andIcon:[UIImage imageNamed:@"Image1"] andSelectedBlock:^{
        NSLog(@"Quote selected");
    }];
    [menuView addMenuItemWithTitle:@"Image" andIcon:[UIImage imageNamed:@"Image2"] andSelectedBlock:^{
        NSLog(@"Image selected");
    }];
    [menuView addMenuItemWithTitle:@"Hi" andIcon:[UIImage imageNamed:@"Image3"] andSelectedBlock:^{
        NSLog(@"Hi selected");
        
    }];
    [menuView show];
}

@end
