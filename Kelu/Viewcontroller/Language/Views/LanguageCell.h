//
//  LanguageCell.h
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LanguageModel.h"

@interface LanguageCell : UITableViewCell

- (void)updateCellUIWithLangugeModel:(LanguageModel *)languageModel;
- (LanguageModel *)getLanguageModel;

- (void)updateCellUIWithLangugeTableData:(LanguageTable *)languageTableData;
- (LanguageTable *)getLanguageTableData;

@end
