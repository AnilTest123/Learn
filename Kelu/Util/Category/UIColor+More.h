//
//  UIColor+More.h
//  Jiffle
//
//  Created by Anil Chopra on 17/07/15.
//  Copyright (c) 2015 Jiffle. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JIFFLE_BLUE @"#15A7E9"

@interface UIColor (More)
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end
