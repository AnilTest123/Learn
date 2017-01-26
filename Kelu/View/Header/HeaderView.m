//
//  HeaderView.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "HeaderView.h"

@interface HeaderView ()

@property (nonatomic, weak) IBOutlet UIButton *languageButton;

@end

@implementation HeaderView

#pragma mark - Life Cycle Method

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Initialization

- (void)initialize
{
    [self customizeLanguageButton];
}

- (void)customizeLanguageButton
{
    [ViewCustomEffect setShadowEffectOnButton:self.languageButton];
    [self setLangugageButtonTitle];
}

- (void)setLangugageButtonTitle
{
    NSString *languageName = [KKeyChain loadKeyChainValueForKey:kKeychainSelectedLanguageName];
    if (![languageName length])
    {
        languageName = @"Hindi";
    }
    [self.languageButton setTitle:languageName forState:UIControlStateNormal];

}

#pragma mark - Init

+ (HeaderView *)initializeHeaderViewWithFrame:(CGRect)frame
{
    HeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HeaderView"
                                                            owner:self
                                                          options:nil] firstObject];
    headerView.frame = frame;
    [headerView layoutIfNeeded];
    return headerView;
}

#pragma mark - Reload Lanaguage
- (void)reloadHeaderView
{
    [self setLangugageButtonTitle];
}

#pragma mark - Button Action

- (IBAction)languageButtonPressed:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(languageButtonPressed)])
    {
        [_delegate languageButtonPressed];
    }
}

@end
