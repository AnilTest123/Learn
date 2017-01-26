//
//  ThemeResponse.m
//  Kelu
//
//  Created by Nagarajan SD on 26/01/17.
//  Copyright © 2017 Anil Chopra. All rights reserved.
//

#import "ThemeResponse.h"

@implementation ThemeResponse

- (ThemeModel *)getThemeModelForThemeTagCode:(NSString *)themeTagCode
{
    NSPredicate *themeTagCodePredicat = [self getPredicateForTopicForThemeTag:themeTagCode];
    
    NSArray *filteredData = [self.objects filteredArrayUsingPredicate:themeTagCodePredicat];
    
    return [NSMutableArray arrayWithArray:filteredData];
}

-(NSPredicate*)getPredicateForTopicForThemeTag:(NSString *)themeTag
{
    return [NSPredicate predicateWithFormat:@"(%K LIKE[cd] %@)",@"tag_code",themeTag];
}


@end
