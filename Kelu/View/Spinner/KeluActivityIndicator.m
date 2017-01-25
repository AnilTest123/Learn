//
//  JiffleActivityIndicator.m
//  JSpinner
//
//  Created by Anil Chopra on 08/05/15.
//  Copyright (c) 2015 Anil Chopra. All rights reserved.
//

#import "KeluActivityIndicator.h"
#import "UIColor+More.h"

#define SPINNER_STANDARD_WIDTH 55
#define SPINNER_STANDARD_HEIGHT 55

@implementation KeluActivityIndicator

#pragma mark - Class methods
+ (id)showIndicator:(UIView *)view animated:(BOOL)animated
{
    KeluActivityIndicator *indicator = [[self alloc] initWithView:view];
    dispatch_async(dispatch_get_main_queue(), ^{
        // code here
        indicator.backgroundColor = [UIColor clearColor];
        indicator.color = [UIColor colorFromHexString:JIFFLE_BLUE];
        [view addSubview:indicator];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        //[indicator performSelector:@selector(hideIndicatorAfterSomeSeconds:) withObject:indicator afterDelay:35];
        
    });
    return indicator;
        
}

+ (BOOL)hideIndicatorForView:(UIView *)view animated:(BOOL)animated
{
    KeluActivityIndicator *indicator = [self IndicatorForView:view];
    [KeluActivityIndicator endIgnoringInteractions];
    if (indicator != nil) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [indicator hide:animated];
        });
        return YES;
    }
    return NO;
}

+ (NSUInteger)hideAllIndicatorsForView:(UIView *)view animated:(BOOL)animated
{
   [KeluActivityIndicator endIgnoringInteractions];
    
    NSArray *indicators = [KeluActivityIndicator allIndicatorsForView:view];
    for (KeluActivityIndicator *indicator in indicators) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [indicator hide:animated];
        });
    }
    return [indicators count];
}

-(void)hideIndicatorAfterSomeSeconds:(KeluActivityIndicator*)indicator
{
    [KeluActivityIndicator endIgnoringInteractions];
      dispatch_async(dispatch_get_main_queue(), ^{
        [indicator hide:YES];
    });
}

+ (id)IndicatorForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return subview;
        }
    }
    return nil;
}

+ (NSArray *)allIndicatorsForView:(UIView *)view {
    NSMutableArray *indicators = [NSMutableArray array];
    NSArray *subviews = view.subviews;
    for (UIView *aView in subviews) {
        if ([aView isKindOfClass:self]) {
            [indicators addObject:aView];
        }
    }
    return [NSArray arrayWithArray:indicators];
}

- (void)hide:(BOOL)animated {
    
    [jSpinner stopAnimating];
    [self done];
}
- (void)done {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.alpha = 0.0f;
    [self unregisterFromNotifications];
    [self removeFromSuperview];
}

#pragma mark - Views
- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    return [self initWithFrame:view.bounds];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        _spinnerFrame = CGRectMake(0, 0, SPINNER_STANDARD_WIDTH, SPINNER_STANDARD_HEIGHT);
        _color = [UIColor blueColor];
        [self updateIndicators];
        [self registerForNotifications];
    }
    return self;
}

#pragma mark -Indicator
-(void)updateIndicators
{
    if(jSpinner)
    {
        [jSpinner removeFromSuperview];
    }
    CGRect frameIndicator;
    //Check if its Pos are 0,0 then make it center
    if((!_spinnerFrame.origin.x) && (!_spinnerFrame.origin.y))
    {
        frameIndicator = CGRectMake(CGRectGetMidX(self.frame) - _spinnerFrame.size.width/2, CGRectGetMidY(self.frame)-_spinnerFrame.size.height/2, _spinnerFrame.size.width, _spinnerFrame.size.height);
    }
    else
    {
        frameIndicator = _spinnerFrame;
    }
    jSpinner = [[KeluSpinner alloc]initWithFrame:frameIndicator];
    jSpinner.barColor = _color;
    
    [jSpinner startAnimating];
    [self addSubview:jSpinner];
    
}

#pragma mark - Notifications
- (void)registerForNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(statusBarOrientationDidChange:)
               name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)unregisterFromNotifications {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationDidChange:(NSNotification *)notification {
    UIView *superview = self.superview;
    if (!superview) {
        return;
    } else {
        
        [self updateForCurrentOrientationAnimated:YES];
    }
}

- (void)updateForCurrentOrientationAnimated:(BOOL)animated {
    // Entirely cover the parent view
    UIView *parent = self.superview;
    if (parent) {
        self.frame = parent.bounds;
    }
    [self updateIndicators];
}

-(void)setLabelText:(NSString *)labelText
{
    _labelText = labelText;
    [self updateIndicators];
}

-(void)setColor:(UIColor *)color
{
    if(color)
    {
        _color = color;
    }
    [self updateIndicators];
}

-(void)setSpinnerFrame:(CGRect)spinnerFrame
{
    _spinnerFrame = spinnerFrame;
    [self updateIndicators];
}

#pragma mark - Utils
+(void)endIgnoringInteractions
{
    if ([[UIApplication sharedApplication] isIgnoringInteractionEvents])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }
}

@end
