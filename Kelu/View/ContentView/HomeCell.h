//
//  HomeCell.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"

@protocol HomeCellDelegate <NSObject>

-(void)tappedOnShareForObject:(TextModel*)obj;
-(void)showAudioFileNotFoundToast;

@end

@interface HomeCell : UITableViewCell

@property (nonatomic, strong)TextModel *textModel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property (nonatomic, weak) id<HomeCellDelegate> delegate;

@end
