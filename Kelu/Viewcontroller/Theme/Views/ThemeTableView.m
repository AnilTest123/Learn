//
//  ThemeTableView.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "ThemeTableView.h"
#import "ThemeCell.h"

@interface ThemeTableView () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ThemeTableView

#pragma mark - Life Cycle Method

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.dataSource = self;
    self.delegate = self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Table View

#pragma mark Data Source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_themes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeCell *cell = (ThemeCell *)[tableView dequeueReusableCellWithIdentifier:@"ThemeCell"];
    [cell updateCellUIWithThemeModel:(ThemeModel *)[_themes objectAtIndex:indexPath.section]];
    return cell;
}

#pragma mark Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2.5f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ThemeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ThemeModel *themeModel = [cell getThemeModel];
    if ([_themeDelegate respondsToSelector:@selector(setSelectedTheme:)])
    {
        [_themeDelegate setSelectedTheme:themeModel];
    }
    
}

#pragma mark - Setter method

- (void)setThemes:(NSArray *)themes
{
    _themes = themes;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}


@end
