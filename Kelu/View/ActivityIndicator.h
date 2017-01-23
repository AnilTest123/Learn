//
//  ActivityIndicator.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGActivityIndicatorView.h"

@interface ActivityIndicator : DGActivityIndicatorView
+ (void)showIndicator:(UIView *)view animated:(BOOL)animated;
+ (BOOL)hideIndicatorForView:(UIView *)view animated:(BOOL)animated;
@end
