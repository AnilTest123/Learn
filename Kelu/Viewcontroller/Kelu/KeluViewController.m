//
//  KeluViewController.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "KeluViewController.h"
#import "HeaderView.h"
#import "LanguageViewController.h"

@interface KeluViewController () <HeaderViewDelegate>
{
    HeaderView *hView;
}

@property (nonatomic, weak) IBOutlet UIView *headerView;

@end

@implementation KeluViewController

#pragma mark - Life Cycle Method

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
    [self initializePrivate];
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
    
}

#pragma mark - Private Initialization

- (void)initializePrivate
{
    [self initializeVariable];
    [self initializeHeaderView];
    [self addHeaderViewReloadNotification];
}

- (void)initializeVariable
{
    _refreshRequired = YES;
    _dbManager = [KeluDatabaseManager sharedDatabaseManagerInstance];
    
}

- (void)initializeHeaderView
{
    hView = [HeaderView initializeHeaderViewWithFrame:self.headerView.bounds];
    hView.delegate = self;
    [self.headerView addSubview:hView];
}

- (void)addHeaderViewReloadNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadHeaderView)
                                                 name:keluHeaderViewUpdateNotification
                                               object:nil];
}

- (void)reloadHeaderView
{
    _refreshRequired = YES;
    [hView reloadHeaderView];
}


#pragma mark - Delegate

#pragma mark HeaderView Delegate
- (void)languageButtonPressed
{
    [self navigateToLanguageViewControllerWithAnimated:YES];
}

#pragma mark - Navigation / Push

#pragma mark Language View Controller

- (void)navigateToLanguageViewControllerWithAnimated:(BOOL)animated
{
    LanguageViewController* languageViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"LanguageViewController"];
    languageViewController.hidesBottomBarWhenPushed = YES;
    if([self.navigationController respondsToSelector:@selector(showViewController:sender:)])
        [self.navigationController showViewController:languageViewController sender:self];
    else
        [self.navigationController pushViewController:languageViewController animated:animated];
}

@end
