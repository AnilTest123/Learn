//
//  ThemeTableView.h
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"

@protocol ThemeTableViewDelegate <NSObject>

- (void)setSelectedTheme:(ThemeModel *)theme;

@end

@interface ThemeTableView : UITableView

@property (nonatomic, copy) NSArray *themes;
@property (nonatomic, weak) id<ThemeTableViewDelegate> themeDelegate;

@end
