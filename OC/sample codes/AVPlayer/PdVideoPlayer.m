//
//  PdVideoPlayer.m
//  Famlink
//
//  Created by light_bo on 2018/5/19.
//Copyright © 2018年 Paramida. All rights reserved.
//

#import "PdVideoPlayer.h"

@implementation PdVideoPlayer

+ (instancetype)sharePlayer {
    static PdVideoPlayer *videoPlayer = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        videoPlayer = [[PdVideoPlayer alloc] init];
    });
    
    return videoPlayer;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _myPlayer = [AVPlayer playerWithPlayerItem:_item];
        _myPlayer.muted = YES;
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_myPlayer];
        _playerLayer.frame = CGRectZero;
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:_myPlayer.currentItem];
    }
    
    return self;
}

- (void)startPlayWithVideoURL:(NSString *)videoURL {
    if (!_playerLayer.superlayer) {
        return;
    }
    
    _playerLayer.hidden = NO;
    
    _item = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:videoURL]];
    [_myPlayer replaceCurrentItemWithPlayerItem:_item];
    [_myPlayer play];
}

- (void)stopVideoPlayer {
    [_myPlayer pause];
    [_myPlayer replaceCurrentItemWithPlayerItem:nil];
    
    if (_playerLayer.superlayer) {
        [_playerLayer removeFromSuperlayer];
    }
}

#pragma mark - player state notification
- (void)playbackFinished:(NSNotification *)notification {
    [_myPlayer seekToTime:CMTimeMake(0, 1)];
    [_myPlayer play];
}

@end
