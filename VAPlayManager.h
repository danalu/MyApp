//
//  VAPlayManager.h
//  AutoLayoutDemo
//
//  Created by Dana on 2017/10/15.
//  Copyright © 2017年 Dana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^ProgressUpdateBlock)(CGFloat progress);

@interface VAPlayManager : NSObject

@property (nonatomic, strong, readonly) AVPlayer *player;
@property (nonatomic, assign) NSTimeInterval duration; //文件总时长
@property (nonatomic, assign) BOOL isPlaying; // 是否正在播放
@property (nonatomic, assign) CGFloat progress; //播放进度 (0 - 1)
@property (nonatomic, strong, readonly) NSURL *url; //播放url
@property (nonatomic, copy) ProgressUpdateBlock progressUpdateBlock; //监听进度变化 (progress从0-1）

/**
 开始播放

 @param url 播放的url
 */
- (void)startPlayWithURL:(NSURL*)url;


/**
 暂停播放 
 */
- (void)stopPlay;

/**
 移动到指定时间开始播放
 
 @param time 开始播放的时间 - 毫秒
 @param completionHandler 加载完成，开始播放的回调
 */
- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^)(void))completionHandler;

@end
