//
//  JiffleSpinner.m
//  JSpinner
//
//  Created by Anil Chopra on 07/05/15.
//  Copyright (c) 2015 Anil Chopra. All rights reserved.
//

#import "KeluSpinner.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat ActivityIndicatorDefaultSpeed = 1.0f;
static NSString * const ActivityIndicatorAnimationKey = @"ActivityIndicatorAnimationKey";

@interface KeluSpinner()
{
    
    NSInteger numberOfBars;
    CGFloat barWidth;
    CGFloat barHeight;
    CGFloat aperture;
}
@property (nonatomic) CGFloat indicatorSize;
@property (nonatomic, strong) CALayer *marker;
@property (nonatomic, strong) CAReplicatorLayer *spinnerReplicator;
@property (nonatomic, strong) CABasicAnimation *fadeAnimation;

@end


@implementation KeluSpinner

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self setBackgroundColor:[UIColor clearColor]];
    
    _barColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    numberOfBars = 8.0f;
    [self createLayers];
    [self updateLayers];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.indicatorSize = CGRectGetWidth(self.bounds);
    [self updateLayers];
}

- (void)updateLayers
{
    // Update marker
    barWidth = barHeight = self.indicatorSize/numberOfBars;
    aperture = M_PI*barHeight;
    
    [self.marker setBounds:CGRectMake(0.0f, 0.0f, barWidth, barHeight)]; // size of the rectangle marker
    [self.marker setCornerRadius:barWidth * 0.5];
    [self.marker setBackgroundColor:[_barColor CGColor]];
    [self.marker setPosition:CGPointMake(self.indicatorSize * 0.5f, self.indicatorSize * 0.5f + aperture)];
    
    // Update replicaitons
    [self.spinnerReplicator setBounds:CGRectMake(0.0f, 0.0f, self.indicatorSize, self.indicatorSize)];
    [self.spinnerReplicator setCornerRadius:10.0f];
    [self.spinnerReplicator setPosition:CGPointMake(CGRectGetMidX(self.bounds),
                                                    CGRectGetMidY(self.bounds))];
    
    CGFloat angle = (2.0f * M_PI) / (numberOfBars);
    CATransform3D instanceRotation = CATransform3DMakeRotation(angle, 0.0f, 0.0f, 1.0f);
    [self.spinnerReplicator setInstanceCount:numberOfBars];
    [self.spinnerReplicator setInstanceTransform:instanceRotation];
}

- (void)createLayers {
    [self.spinnerReplicator addSublayer:self.marker];
    [self.layer addSublayer:self.spinnerReplicator];
    
    [self.marker setOpacity:0.0f]; // will be visible thanks to the animation
}

#pragma mark Public methods

- (void)startAnimating
{
    [self.fadeAnimation setDuration:ActivityIndicatorDefaultSpeed];
    CGFloat markerAnimationDuration = ActivityIndicatorDefaultSpeed /numberOfBars;
    [self.spinnerReplicator setInstanceDelay:markerAnimationDuration];
    [self.marker addAnimation:self.fadeAnimation forKey:ActivityIndicatorAnimationKey];
}

- (void)stopAnimating
{
    [self.marker removeAnimationForKey:ActivityIndicatorAnimationKey];
}

- (BOOL)isAnimating
{
    return [self.marker animationForKey:ActivityIndicatorAnimationKey] != nil;
}

#pragma mark - Getters

- (CALayer *)marker {
    if (!_marker) {
        _marker = [CALayer layer];
    }
    return _marker;
}

- (CAReplicatorLayer *)spinnerReplicator {
    if (!_spinnerReplicator) {
        _spinnerReplicator = [CAReplicatorLayer layer];
    }
    return _spinnerReplicator;
}

- (CABasicAnimation *)fadeAnimation {
    if (!_fadeAnimation) {
        _fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    }
    
    [_fadeAnimation setFromValue:[NSNumber numberWithFloat:1.0f]];
    [_fadeAnimation setToValue:[NSNumber numberWithFloat:0.0f]];
    [_fadeAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [_fadeAnimation setRepeatCount:HUGE_VALF];
    
    return _fadeAnimation;
}

#pragma mark - Setters

- (void)setBarColor:(UIColor *)barColor {
    _barColor = barColor;
    [self updateLayers];
}

-(void)dealloc
{
    #if !__has_feature(objc_arc)
    [super dealloc];
    #endif
}

@end
