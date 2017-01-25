//
//  JiffleActivityIndicator.h
//  JSpinner
//
//  Created by Anil Chopra on 08/05/15.
//  Copyright (c) 2015 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeluSpinner.h"

@interface KeluActivityIndicator : UIView
{
    KeluSpinner *jSpinner;
}
@property(nonatomic,copy)NSString *labelText;
@property(nonatomic,copy)UIColor *color;
@property(nonatomic)CGRect spinnerFrame;

+ (id)showIndicator:(UIView *)view animated:(BOOL)animated;
+ (BOOL)hideIndicatorForView:(UIView *)view animated:(BOOL)animated;
+ (NSUInteger)hideAllIndicatorsForView:(UIView *)view animated:(BOOL)animated;
- (void)hide:(BOOL)animated;

@end
