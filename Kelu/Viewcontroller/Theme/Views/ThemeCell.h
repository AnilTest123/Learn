//
//  ThemeCell.h
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeModel.h"

@interface ThemeCell : UITableViewCell

- (void)updateCellUIWithThemeModel:(ThemeModel *)themeModel;
- (ThemeModel *)getThemeModel;

@end
