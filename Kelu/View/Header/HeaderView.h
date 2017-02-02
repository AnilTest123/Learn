//
//  HeaderView.h
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeaderViewDelegate <NSObject>

- (void)languageButtonPressed;

@end

@interface HeaderView : UIView

@property (nonatomic, weak) id<HeaderViewDelegate> delegate;

+ (HeaderView *)initializeHeaderViewWithFrame:(CGRect)frame;

#pragma mark - Reload Lanaguage
- (void)reloadHeaderView;

@end
