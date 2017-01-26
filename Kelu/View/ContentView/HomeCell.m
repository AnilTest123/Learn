//
//  HomeCell.m
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell()

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *translatedText;
@property (weak, nonatomic) IBOutlet UILabel *themeNames;

- (IBAction)playButtonPressed:(id)sender;
- (IBAction)favButtonPressed:(id)sender;
- (IBAction)shareButtonPressed:(id)sender;

@end

@implementation HomeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
//    [self addShadow];
//    [self addCornerRadius];
}

- (void)addShadow
{
    
}

- (void)addCornerRadius
{
////    self.contentView.layer.cornerRadius = 5.0f;
////    self.contentView.layer.borderColor = [UIColor orangeColor].CGColor;
////    self.contentView.layer.borderWidth = 1;
////    self.contentView.layer.shadowColor = [UIColor redColor].CGColor;
////    self.contentView.layer.shadowOffset = CGSizeMake(1, 1);
////    self.contentView.layer.shadowRadius = 10.0f;
////    self.contentView.layer.shadowOpacity = 1.0f;
////    self.contentView.layer.masksToBounds = NO;
////    self.contentView.clipsToBounds = NO;
////    self.clipsToBounds = NO;
//    self.contentView.layer.shadowColor = [UIColor redColor].CGColor;
//    self.contentView.layer.shadowOffset = CGSizeMake(1, 1);
//    self.contentView.layer.shadowRadius = 5.0f;
//    self.contentView.layer.shadowOpacity = 0.5f;
//    CGRect shadowFrame = self.layer.bounds;
//    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
//    self.contentView.layer.shadowPath = shadowPath;

}

- (void)drawRect:(CGRect)rect
{
    [self addCornerRadius];
}

-(void)setTextModel:(TextModel *)textModel
{
    _textModel = textModel;
    [self setValues];
}

#pragma mark - Text Initialization
-(void)setValues
{
    self.text.text = _textModel.text;
    self.translatedText.text = _textModel.dest_text;
    self.themeNames.text = _textModel.text_code;
    [self setNeedsDisplay];
}

#pragma mark - Actions

- (IBAction)playButtonPressed:(id)sender {
}

- (IBAction)favButtonPressed:(id)sender {
}

- (IBAction)shareButtonPressed:(id)sender {
    if([_delegate respondsToSelector:@selector(tappedOnShareForObject:)])
    {
        [_delegate tappedOnShareForObject:_textModel];
    }
}

@end
