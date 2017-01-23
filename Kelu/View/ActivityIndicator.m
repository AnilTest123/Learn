//
//  ActivityIndicator.m
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "ActivityIndicator.h"

@implementation ActivityIndicator
+ (void)showIndicator:(UIView *)view animated:(BOOL)animated
{
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeDoubleBounce tintColor:[UIColor blueColor] size:20.0f];
    activityIndicatorView.frame = CGRectMake(view.frame.size.width/2-25, view.frame.size.height/2-25, 50.0f, 50.0f);
    [view addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
}
+ (BOOL)hideIndicatorForView:(UIView *)view animated:(BOOL)animated
{
    ActivityIndicator *indicator = [self IndicatorForView:view];
    
    if (indicator != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            [indicator stopAnimating];
        });
        return YES;
    }
    return NO;
}

+ (id)IndicatorForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[DGActivityIndicatorView class]]) {
            return subview;
        }
    }
    return nil;
}

@end
