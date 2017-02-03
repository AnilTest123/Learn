//
//  HomeCell.m
//  Kelu
//
//  Created by Anil Chopra on 03/07/16.
//  Copyright © 2016 Anil Chopra. All rights reserved.
//

#import "HomeCell.h"

@interface HomeCell() <AVAudioPlayerDelegate>
{
    AVAudioPlayer *audioPlayer;
}

@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *translatedText;
@property (weak, nonatomic) IBOutlet UILabel *themeNames;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;

- (IBAction)playButtonPressed:(UIButton *)sender;
- (IBAction)favButtonPressed:(UIButton *)sender;
- (IBAction)shareButtonPressed:(UIButton *)sender;
- (IBAction)pauseButtonPressed:(UIButton *)sender;

@end

@implementation HomeCell

- (void)awakeFromNib
{
    [super awakeFromNib];
//    [self addShadow];
//    [self addCornerRadius];
}

- (void)addShadow
{
    
}

- (void)addCornerRadius
{
////    self.contentView.layer.cornerRadius = 5.0f;
////    self.contentView.layer.borderColor = [UIColor orangeColor].CGColor;
////    self.contentView.layer.borderWidth = 1;
////    self.contentView.layer.shadowColor = [UIColor redColor].CGColor;
////    self.contentView.layer.shadowOffset = CGSizeMake(1, 1);
////    self.contentView.layer.shadowRadius = 10.0f;
////    self.contentView.layer.shadowOpacity = 1.0f;
////    self.contentView.layer.masksToBounds = NO;
////    self.contentView.clipsToBounds = NO;
////    self.clipsToBounds = NO;
//    self.contentView.layer.shadowColor = [UIColor redColor].CGColor;
//    self.contentView.layer.shadowOffset = CGSizeMake(1, 1);
//    self.contentView.layer.shadowRadius = 5.0f;
//    self.contentView.layer.shadowOpacity = 0.5f;
//    CGRect shadowFrame = self.layer.bounds;
//    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:shadowFrame].CGPath;
//    self.contentView.layer.shadowPath = shadowPath;

}

- (void)drawRect:(CGRect)rect
{
    [self addCornerRadius];
}

-(void)setTextModel:(TextModel *)textModel
{
    _textModel = textModel;
    [self setValues];
}

#pragma mark - Text Initialization
-(void)setValues
{
    self.text.text = _textModel.text;
    self.translatedText.text = _textModel.dest_text;
    self.themeNames.text = _textModel.text_code;
    [self setNeedsDisplay];
}

#pragma mark - Actions

- (IBAction)playButtonPressed:(UIButton *)sender
{
    [self showPauseButton];
    if (!audioPlayer)
    {
        [self playAudioData];
    }
    else
    {
        [audioPlayer play];
    }
}

- (IBAction)favButtonPressed:(UIButton *)sender
{
    
}

- (IBAction)shareButtonPressed:(UIButton *)sender
{
    if([_delegate respondsToSelector:@selector(tappedOnShareForObject:)])
    {
        [_delegate tappedOnShareForObject:_textModel];
    }
}

- (IBAction)pauseButtonPressed:(UIButton *)sender
{
    [self showPlayButton];
    if ([audioPlayer isPlaying])
    {
        [audioPlayer pause];
    }
}

#pragma mark - Paly button visibility
- (void)showPlayButton
{
    self.playButton.hidden = NO;
    self.pauseButton.hidden = YES;
}

- (void)showPauseButton
{
    self.playButton.hidden = YES;
    self.pauseButton.hidden = NO;
}

#pragma mark - Private Method

- (void)playAudioData
{
    NSString *urlString = [NSString  stringWithFormat:@"https://s3-us-west-2.amazonaws.com/elasticbeanstalk-us-west-2-574771754661/YAPPY_SOUND/%@/%@_%@.mp3", _textModel.dest_lan_key, _textModel.text_code, _textModel.dest_lan_key];
    NSURL *audioFileURL = [NSURL URLWithString:urlString];
    
    NSString *fileName = [audioFileURL lastPathComponent];
    NSString *fileSavePath = [KKeyChain loadKeyChainValueForKey:kKeyChainDocumentDirectoryPath];
    fileSavePath = [fileSavePath stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileSavePath])
    {
        [[ApiResponseHandler sharedApiResponseHandlerInstance] fetchSoudFileAndStoreForTextWithUrl:audioFileURL fileSavePath:fileSavePath withSuccessCompletionBlock:^(NSString * fileSavedPath) {
            [self playAudioFileWithFileUrl:fileSavedPath];
            
        } withFailureCompletionBlock:^(NSError *error) {
            [self audioFileNotFoundError:error];
            
        }];
    }
    else
    {
        [self playAudioFileWithFileUrl:fileSavePath];
    }
}

- (void)playAudioFileWithFileUrl:(NSString *)fileUrl
{
    NSData *audioData = [NSData dataWithContentsOfFile:fileUrl];
    if (!audioData)
    {
        [self audioFileNotFoundError:nil];
    }
    NSError *error;
    
    audioPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
    audioPlayer.numberOfLoops = 0;
    audioPlayer.volume = 1.0f;
    audioPlayer.delegate = self;
    [audioPlayer prepareToPlay];
    
    if (audioPlayer == nil)
        NSLog(@"%@", [error description]);
    else
        [audioPlayer play];

}

- (void)audioFileNotFoundError:(NSError *)error
{
    [KeluAlertViewController showAlertControllerWithTitle:@"Audio File Error"
                                                  message:error.localizedDescription
                                        acceptActionTitle:@"OK"
                                        acceptActionBlock:nil
                                       dismissActionTitle:nil
                                       dismissActionBlock:nil
                                 presentingViewController:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([_delegate respondsToSelector:@selector(showAudioFileNotFoundToast)])
        {
            [_delegate showAudioFileNotFoundToast];
        }
    });
    return;
}

#pragma mark - Delegates

#pragma mark AVAudioPalyer Delegates

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    audioPlayer = nil;
    [self showPlayButton];
}

@end
