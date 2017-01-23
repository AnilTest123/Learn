//
//  CALayer+UIColor.m
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "CALayer+UIColor.h"

@implementation CALayer (UIColor)

- (void)setBorderUIColor:(UIColor*)color {
    self.borderColor = color.CGColor;
}

- (UIColor*)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
