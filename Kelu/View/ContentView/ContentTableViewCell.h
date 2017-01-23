//
//  ContentTableViewCell.h
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonTest.h"

@protocol ContentTableViewCellDelegate <NSObject>

-(void)tappedOnShareForObject:(JsonTest*)obj;

@end

@interface ContentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *translatedText;
@property (weak, nonatomic) IBOutlet UILabel *themeNames;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeight;
@property(nonatomic,strong)JsonTest *jsonObj;
@property (weak, nonatomic) id<ContentTableViewCellDelegate> delegate;

- (IBAction)playButtonPressed:(id)sender;
- (IBAction)favButtonPressed:(id)sender;
- (IBAction)shareButtonPressed:(id)sender;
@end
