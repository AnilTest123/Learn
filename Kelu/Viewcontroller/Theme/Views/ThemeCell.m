//
//  ThemeCell.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "ThemeCell.h"
#import "TextThemeTable.h"
#import "TextModel.h"

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
    NSArray *textModels = [TextThemeTable getTextModelForThemeTag:theme.tag_code withSelectedLanguage:[KKeyChain loadKeyChainValueForKey:kKeychainSelectedLanguageKey] dbManager:[KeluDatabaseManager sharedDatabaseManagerInstance]];
    [self updateThemeSampleWithTextModels:textModels];
}

- (void)updateThemeSampleWithTextModels:(NSArray *)textModels
{
    NSString *themeSampleData = @"";
    if ([textModels count])
    {
        for (int count = 0; count < [textModels count]; count++)
        {
            TextModel *textModel = (TextModel *)[textModels objectAtIndex:count];
            if ([themeSampleData length])
            {
                themeSampleData = [themeSampleData stringByAppendingString:[NSString stringWithFormat:@", %@", textModel.text]];
            }
            else
            {
                themeSampleData = textModel.text;
            }
            if (count == 3)
            {
                break;
            }
        }
    }
    self.themeSample.text = themeSampleData;
}

#pragma mark - Getter method
- (ThemeModel *)getThemeModel
{
    return theme;
}

@end
