//
//  VAPlayManager.m
//  AutoLayoutDemo
//
//  Created by Dana on 2017/10/15.
//  Copyright © 2017年 Dana. All rights reserved.
//

#import "VAPlayManager.h"

@interface VAPlayManager()

@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) id timeObserver;

@end

@implementation VAPlayManager

#pragma mark - lifecycle
- (void)dealloc {
    [self releasePlayer];
}

- (id)initWithURL:(NSURL*)url {
    self = [self init];
    if (self) {
        _url = url;
    }
    return self;
}

#pragma mark - interface
- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^)(void))completionHandler {
    if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
        CMTime duration = self.player.currentItem.asset.duration;
        CGFloat scale = time / (CMTimeGetSeconds(duration) * 1000); //计算出当前seek时间占总时间的比例
        CMTime seekTo = CMTimeMake((NSInteger)(duration.value * scale), duration.timescale);
        __weak typeof(self)weakSelf = self;
        [self.player pause];
        [self.player seekToTime:seekTo completionHandler:^(BOOL finished) {
            [weakSelf.player play];
            weakSelf.isPlaying = YES;
            
            if (completionHandler) {
                completionHandler();
            }
        }];
    }
}

- (void)startPlayWithURL:(NSURL*)url {
    NSString *urlString = self.url.absoluteString;
    
    _url = url;
    if (![urlString isEqualToString:url.absoluteString]) {
        //不相同则需要播放另一个.
        [self setupPlayer];
    } else {
        //相同.
        if (self.player && self.playerItem.status == AVPlayerItemStatusReadyToPlay && !self.isPlaying) {
            [self.player play];
            _isPlaying = YES;
        }
    }
}

- (void)stopPlay {
    if (self.player && self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
        [self.player pause];
        _isPlaying = NO;
    }
}

#pragma mark - setup
- (void)setupPlayer {
    [self releasePlayer];
    
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:self.url];
    self.playerItem = playerItem;
    AVPlayer * player = [[AVPlayer alloc]initWithPlayerItem:playerItem];
    player.automaticallyWaitsToMinimizeStalling = YES;
    _player = player;
    
    [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    
    __weak typeof(self)weakSelf = self;
    self.timeObserver =
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1)
                                              queue:dispatch_queue_create("player.time.queue", NULL)
                                         usingBlock:^(CMTime time) {
                                             dispatch_async(dispatch_get_main_queue(), ^(void) {
                                                 if (weakSelf.isPlaying) {
                                                     weakSelf.duration = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
                                                     CGFloat currentDuration = CMTimeGetSeconds(time);
                                                     weakSelf.progress = currentDuration / weakSelf.duration;
                                                     
                                                     if (weakSelf.progress >= 1.0) {
                                                         //播放结束.
                                                         weakSelf.isPlaying = NO;
                                                     }
                                                     
                                                     //回调进度.
                                                     if (weakSelf.progressUpdateBlock) {
                                                         weakSelf.progressUpdateBlock(weakSelf.progress);
                                                     }
                                                 }
                                             });
                                         }];
}

#pragma mark - kvo
#pragma mark - kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (object == self.playerItem && [keyPath isEqualToString:@"status"]) {
        if (self.playerItem.status == AVPlayerItemStatusReadyToPlay) {
            [self.player play];
            _isPlaying = YES;
        } else if (self.playerItem.status == AVPlayerItemStatusFailed) {
            _isPlaying = NO;
        }
    }
}

#pragma mark - tool
- (void)releasePlayer {
    [self.playerItem removeObserver:self forKeyPath:@"status"];
    [self.player removeTimeObserver:self.timeObserver];
    self.timeObserver = nil;
    [self.player pause];
    self.playerItem = nil;
    _player = nil;
    _isPlaying = NO;
}

@end
