//
//  KeluViewController.h
//  Kelu
//
//  Created by Anil Chopra on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeluViewController : UIViewController

@property (nonatomic) BOOL refreshRequired;
@property (nonatomic, strong) KeluDatabaseManager *dbManager;

#pragma mark - Initialization

- (void)initialize;

@end
