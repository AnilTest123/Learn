//
//  JiffleSpinner.h
//  JSpinner
//
//  Created by Anil Chopra on 07/05/15.
//  Copyright (c) 2015 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KeluSpinner : UIView

@property (nonatomic, retain) UIColor *barColor;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
