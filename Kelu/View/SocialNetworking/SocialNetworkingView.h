//
//  SocialNetworkingView.h
//  Kelu
//
//  Created by Anil Chopra on 25/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SocialNetworkingViewDelegate <NSObject>

- (void)facebookButtonPressed;
- (void)twitterButtonPressed;
- (void)googlePlusButtonPressed;

@end

@interface SocialNetworkingView : UIView

@property (nonatomic, weak) id<SocialNetworkingViewDelegate> delegate;

#pragma mark - Init
+ (SocialNetworkingView *)initializeSocialNetworkingViewWithFrame:(CGRect)frame;

@end
