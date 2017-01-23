//
//  ContentTableViewCell.m
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell


-(void)setJsonObj:(JsonTest *)jsonObj
{
    _jsonObj = jsonObj;
    [self setValues];
}

#pragma mark - Text Initialization
-(void)setValues
{
    self.text.text = _jsonObj.title;
    self.translatedText.text = _jsonObj.body;
    self.themeNames.text = _jsonObj.theme;
    [self setNeedsDisplay];
}

#pragma mark - Actions

- (IBAction)playButtonPressed:(id)sender {
}

- (IBAction)favButtonPressed:(id)sender {
}

- (IBAction)shareButtonPressed:(id)sender {
    if([_delegate respondsToSelector:@selector(tappedOnShareForObject:)])
    {
        [_delegate tappedOnShareForObject:_jsonObj];
    }
}

@end
