//
//  ContentViewController.m
//  Kelu
//
//  Created by Anil Chopra on 02/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "ContentViewController.h"
#import "ApiResponseHandler.h"
#import "ActivityIndicator.h"
#import "JsonTest.h"
#import "CHTumblrMenuView.h"

@interface ContentViewController ()
{
    NSMutableArray *jsonTestArray;
    NSIndexPath *selectedIndexPath;
}
@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *menuImage = [UIImage imageNamed:@"MenuIcon"];
    menuImage = [menuImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithImage:menuImage style:UIBarButtonItemStylePlain target:self action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    NSMutableArray *myArray = [[NSMutableArray alloc] init];
    NSNumber  *myNumber = [NSNumber numberWithFloat:10];
    [myArray addObject:myNumber];
    [self fetchTestData];
    [self testPerformance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performUpdate];
}

#pragma mark - Update
-(void)performUpdate
{
    [NSThread sleepForTimeInterval:4];
    int i = arc4random() % 100;
    self.title = [[NSString alloc]initWithFormat:@"Title: %d", i];
}

#pragma mark - Show Menu
- (void)showMenu:(id)sender {
    
    [self.view endEditing:YES];
    [self.frostedViewController.view endEditing:YES];
    
    //Present the view controller
    [self.frostedViewController presentMenuViewController];
}

#pragma mark - Fetch
-(void)fetchTestData
{
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *myFile = [mainBundle pathForResource: @"JsonContent" ofType: @"json"];
    NSString* fileContents =[NSString stringWithContentsOfFile:myFile encoding:NSUTF8StringEncoding error:NULL];
    NSError *error;
    NSArray *jsonObject = (NSArray *)[NSJSONSerialization
                                      JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding]
                                      options:0 error:&error];
    
    jsonTestArray = [JsonTest arrayOfModelsFromDictionaries:jsonObject error:nil];
    [self.tableView reloadData];
}

#pragma mark - Performance
-(void)testPerformance
{
    NSInteger total = 0;
    for (int i=0; i<100000; i++)
    {
        NSNumber *num = [NSNumber numberWithInt:i];
        total = num.integerValue + total;
    }
}
#pragma mark - Table View

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [jsonTestArray count];
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
    cell.jsonObj = [jsonTestArray objectAtIndex:indexPath.section];
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

#pragma mark - Delegates
-(void)tappedOnShareForObject:(JsonTest *)obj
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
