//
//  ThemeCell.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "ThemeCell.h"

@interface ThemeCell ()
{
    ThemeModel *theme;
}
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *themeName;
@property (weak, nonatomic) IBOutlet UILabel *themeSample;

@end

@implementation ThemeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Cell UI

- (void)updateCellUIWithThemeModel:(ThemeModel *)themeModel
{
    theme = themeModel;
    self.themeName.text = theme.tag;
}

#pragma mark - Getter method
- (ThemeModel *)getThemeModel
{
    return theme;
}

@end
