//
//  ViewCustomEffect.h
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewCustomEffect : NSObject

+ (void)setShadowEffectOnButton:(UIButton *)button;
+ (void)setCornerRadiusOnButton:(UIButton *)button;
+ (void)setShadowEffectOnView:(UIView *)view;
+ (void)setBorderForView:(UIView *)view borderWidth:(CGFloat)width color:(UIColor *)color;

@end
