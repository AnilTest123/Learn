//
//  HomeTableView.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeCell.h"
#import "CHTumblrMenuView.h"
//#import "UIView+Toast.h"

@interface HomeTableView() <UITableViewDelegate, UITableViewDataSource, HomeCellDelegate>
{
    NSIndexPath *selectedIndexPath;
}

@end

@implementation HomeTableView

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_textResponse count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TextModel *textModel = [_textResponse objectAtIndex:indexPath.section];
    return [self heightOfCellForText:textModel andToShowBottomView:[selectedIndexPath isEqual:indexPath]?YES:NO];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"HomeCell";
    HomeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate = self;
    cell.textModel = [_textResponse objectAtIndex:indexPath.section];
    if([selectedIndexPath isEqual:indexPath])
    {
        cell.bottomView.hidden = NO;
        cell.bottomViewHeight.constant = 40;
    }
    else
    {
        cell.bottomView.hidden = YES;
        cell.bottomViewHeight.constant = 0;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self beginUpdates];
    if(selectedIndexPath)
        [self reloadRowsAtIndexPaths:@[selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
    selectedIndexPath = indexPath;
    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self endUpdates];
    
    if(selectedIndexPath)
        selectedIndexPath = indexPath;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath;
}

#pragma mark Setter
-(void)setTextResponse:(NSArray *)textResponse
{
    _textResponse = textResponse;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

#pragma mark - Delegates
#pragma mark HomeCell Delegate
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

- (void)showAudioFileNotFoundToast
{
    //[self makeToast:@"No audio available for this sentence"
    //       duration:3.0
    //       position:CSToastPositionBottom];
}


#pragma mark - Private Method

-(CGFloat)heightOfCellForText:(TextModel*)textModel andToShowBottomView:(BOOL)bottomViewShow
{
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Futura" size:15]};
    CGRect rectOfText = [textModel.dest_text boundingRectWithSize:CGSizeMake(self.frame.size.width-60, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:attributes
                                                context:nil];
    
    NSDictionary *attributesTranslated = @{NSFontAttributeName: [UIFont fontWithName:@"Futura-Medium" size:21]};
    CGRect rectOfTranslated = [textModel.text boundingRectWithSize:CGSizeMake(self.frame.size.width-60, CGFLOAT_MAX)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributesTranslated
                                                     context:nil];
    
    CGFloat height = rectOfText.size.height + rectOfTranslated.size.height + 50;
    if(bottomViewShow) height += 40;
    return height;
    
}


@end
