//
//  LanguageTableView.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "LanguageTableView.h"
#import "LanguageCell.h"

@interface LanguageTableView ()<UITableViewDelegate, UITableViewDataSource>
{
    
}

@end

@implementation LanguageTableView

#pragma mark - Life Cycle Method

- (void)awakeFromNib
{
    [super awakeFromNib];
    [ViewCustomEffect setBorderForView:self borderWidth:0.5f color:[UIColor lightGrayColor]];
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
    return [_languages count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LanguageCell *cell = (LanguageCell *)[tableView dequeueReusableCellWithIdentifier:@"LanguageCell"];
    [cell updateCellUIWithLangugeModel:(LanguageModel *)[_languages objectAtIndex:indexPath.section]];
    return cell;
}

#pragma mark Delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 2.5f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellDividerView"];
    return cell.contentView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LanguageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    LanguageModel *languageModel = [cell getLanguageModel];
    if ([_languageDelegate respondsToSelector:@selector(setSelectedLanguage:)])
    {
        [_languageDelegate setSelectedLanguage:languageModel];
    }
}

#pragma mark - Setter method

- (void)setLanguages:(NSArray *)languages
{
    _languages = languages;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

#pragma mark - Private Method

@end
