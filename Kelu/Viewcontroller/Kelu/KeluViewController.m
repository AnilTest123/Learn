//
//  KeluViewController.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "KeluViewController.h"
#import "HeaderView.h"
#import "LanguageViewController.h"

@interface KeluViewController () <HeaderViewDelegate, LanguageViewControllerDelegate>
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initialize];
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
    [self initializeVariable];
    [self initializeHeaderView];
}

- (void)initializeVariable
{
    refreshRequired = YES;
}

- (void)initializeHeaderView
{
    hView = [HeaderView initializeHeaderViewWithFrame:self.headerView.bounds];
    hView.delegate = self;
    [self.headerView addSubview:hView];
}

#pragma mark - Delegate

#pragma mark HeaderView Delegate
- (void)languageButtonPressed
{
    [self navigateToLanguageViewControllerWithAnimated:YES];
}

#pragma mark LanguageView Controller Deleage

- (void)languageSuccessfullySelected
{
    [hView reloadHeaderView];
    refreshRequired = YES;
}

#pragma mark - Navigation / Push

#pragma mark Language View Controller

- (void)navigateToLanguageViewControllerWithAnimated:(BOOL)animated
{
    LanguageViewController* languageViewController =
    [self.storyboard instantiateViewControllerWithIdentifier:@"LanguageViewController"];
    languageViewController.delegate = self;
    languageViewController.hidesBottomBarWhenPushed = YES;
    if([self.navigationController respondsToSelector:@selector(showViewController:sender:)])
        [self.navigationController showViewController:languageViewController sender:self];
    else
        [self.navigationController pushViewController:languageViewController animated:animated];
}

@end
