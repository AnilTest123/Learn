//
//  ViewCustomEffect.m
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "ViewCustomEffect.h"

#define CONTINUE_BUTTON_CORNER_RADIUS 5.0f
#define CONTINUE_BUTTON_SHADOW_OFFSET 5.0f
#define CONTINUE_BUTTON_SHADOW_RADIUS 5.0f
#define CONTINUE_BUTTON_SHADOW_OPACITY 0.7f

@implementation ViewCustomEffect

+ (void)setShadowEffectOnButton:(UIButton *)button
{
    [self setShadowEffectOnView:button];
}

+ (void)setCornerRadiusOnButton:(UIButton *)button
{
    
}

+ (void)setBorderForView:(UIView *)view borderWidth:(CGFloat)width color:(UIColor *)color
{
    view.layer.borderWidth = width;
    view.layer.borderColor = color.CGColor;
}


+ (void)setShadowEffectOnView:(UIView *)view
{
    view.layer.cornerRadius = CONTINUE_BUTTON_CORNER_RADIUS;
    view.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(CONTINUE_BUTTON_SHADOW_OFFSET, CONTINUE_BUTTON_SHADOW_OFFSET);
    view.layer.shadowRadius = CONTINUE_BUTTON_SHADOW_RADIUS;
    view.layer.shadowOpacity = CONTINUE_BUTTON_SHADOW_OPACITY;
}

+ (void)setCornerRadiusOnView:(UIView *)view
{
    
}
@end
