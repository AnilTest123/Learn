//
//  SocialNetworkingView.m
//  Kelu
//
//  Created by Nagarajan SD on 25/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "SocialNetworkingView.h"

@interface SocialNetworkingView()
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *googlePlusButton;


@end

@implementation SocialNetworkingView

#pragma mark - Init
+ (SocialNetworkingView *)initializeSocialNetworkingViewWithFrame:(CGRect)frame
{
    SocialNetworkingView *socialNetworkingView = [[[NSBundle mainBundle] loadNibNamed:@"SocialNetworkingView"
                                                                                       owner:self
                                                                                     options:nil] firstObject];
    socialNetworkingView.frame = frame;
    [socialNetworkingView layoutIfNeeded];
    return socialNetworkingView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Button Actions
- (IBAction)facebookButtonPressed:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(facebookButtonPressed)])
    {
        [_delegate facebookButtonPressed];
    }
}

- (IBAction)twitterButtonPressed:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(twitterButtonPressed)])
    {
        [_delegate twitterButtonPressed];
    }
}

- (IBAction)googlePlusButtonPressed:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(googlePlusButtonPressed)])
    {
        [_delegate googlePlusButtonPressed];
    }
}

@end
