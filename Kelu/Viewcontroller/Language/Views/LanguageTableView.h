//
//  LanguageTableView.h
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LanguageModel.h"

@protocol LanguageTableViewDelegate <NSObject>

- (void)setSelectedLanguage:(LanguageModel *)language;

@end

@interface LanguageTableView : UITableView

@property (nonatomic, copy) NSArray *languages;
@property (nonatomic, weak) id<LanguageTableViewDelegate> languageDelegate;

@end
