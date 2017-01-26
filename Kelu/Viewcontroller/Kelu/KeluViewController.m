//
//  KeluViewController.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "KeluViewController.h"
#import "HeaderView.h"

@interface KeluViewController () <HeaderViewDelegate>

@property (nonatomic, weak) IBOutlet UIView *headerView;

@end

@implementation KeluViewController

#pragma mark - Life Cycle Method

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
    [self initializeHeaderView];
}

- (void)initializeHeaderView
{
    HeaderView *hView = [HeaderView initializeHeaderViewWithFrame:self.headerView.bounds];
    hView.delegate = self;
    [self.headerView addSubview:hView];
}

#pragma mark - Delegate

#pragma mark HeaderView Delegate
- (void)languageButtonPressed
{
    
}

@end
