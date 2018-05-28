//
//  PdVideoPlayer.h
//  Famlink
//
//  Created by light_bo on 2018/5/19.
//Copyright © 2018年 Paramida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PdVideoPlayer : NSObject

+ (instancetype)sharePlayer;

- (void)startPlayWithVideoURL:(NSString *)videoURL;
- (void)stopVideoPlayer;

//video
@property (strong, nonatomic) AVPlayer *myPlayer;
@property (strong, nonatomic) AVPlayerItem *item;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;

@end
