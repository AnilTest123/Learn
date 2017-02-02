//
//  LanguageCell.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "LanguageCell.h"

@interface LanguageCell ()
{
    LanguageModel *language;
}

@property (weak, nonatomic) IBOutlet UILabel *languageName;

@end

@implementation LanguageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Cell UI

- (void)updateCellUIWithLangugeModel:(LanguageModel *)languageModel
{
    language = languageModel;
    self.languageName.text = languageModel.language;
}

#pragma mark - Getter method
- (LanguageModel *)getLanguageModel
{
    return language;
}

@end
