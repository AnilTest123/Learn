//
//  ThemeResponse.h
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ThemeModel.h"

@interface ThemeResponse : JSONModel

@property (nonatomic, strong) NSMutableArray<ThemeModel> *objects;

@end
