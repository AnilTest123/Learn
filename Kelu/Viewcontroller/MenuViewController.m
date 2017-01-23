//
//  MenuViewController.m
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTitleTableViewCell.h"
#import "NavigationController.h"
#import "RootViewController.h"
#import "ContentViewController.h"

@interface MenuViewController ()
{
    NSMutableArray *menuArray;
}
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *menuImage = [UIImage imageNamed:@"MenuIcon"];
    menuImage = [menuImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithImage:menuImage style:UIBarButtonItemStylePlain target:self action:@selector(hideMenuViewController)];
    self.titleImageItem.rightBarButtonItem = item;
    self.titleImageItem.title = @"Kelu";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    menuArray = [NSMutableArray arrayWithObjects:@"Basics",@"Themes",@"Language",nil];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HideMenu

-(void)hideMenuViewController
{
    NavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

-(void)hideMenuViewControllerWithShowingViewControllers:(NSArray*)navigationViewController
{
    NavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    navigationController.viewControllers = navigationViewController;
    self.frostedViewController.contentViewController = navigationController;
    [self.frostedViewController hideMenuViewController];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [menuArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MenuTitleTableViewCell";
    MenuTitleTableViewCell *cell = (MenuTitleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.contentTitle.text = [menuArray objectAtIndex:indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
    ContentViewController* contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContentViewController"];
    navigationController.viewControllers = @[contentViewController];

    [self hideMenuViewControllerWithShowingViewControllers:navigationController.viewControllers];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
