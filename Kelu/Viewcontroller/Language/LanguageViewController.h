//
//  LanguageViewController.h
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LanguageViewControllerDelegate <NSObject>

- (void)languageSuccessfullySelected;

@end

@interface LanguageViewController : UIViewController

@property (nonatomic, weak) id<LanguageViewControllerDelegate> delegate;

@end
