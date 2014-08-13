//
//  BaseService.m
//  XXXSearch
//
//  Created by Dana on 23/08/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import "HSNetworkServiceBase.h"
#import "HSNetworkServiceBase+Subclasses.h"


@implementation HSNetworkServiceBase

@synthesize privateParsingQueue = _privateParsingQueue;

- (id)initWithBaseURL:(NSURL *)baseURL
{
    NSParameterAssert(baseURL);
    if(!(self = [super init]))
    {
        return nil;
    }
    
    _networkClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange) name:AFNetworkingReachabilityDidChangeNotification object:_networkClient.reachabilityManager];
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setReachabilityCallback:(ReachabilityServiceCallback)reachabilityCallback
{
    _reachabilityCallback = [reachabilityCallback copy];
    if(_reachabilityCallback)
    {
        [self.networkClient.reachabilityManager startMonitoring];
    }
}

- (BOOL)isNetworkAvailable
{
    const AFNetworkReachabilityStatus status = self.networkClient.reachabilityManager.networkReachabilityStatus;
    return status != AFNetworkReachabilityStatusNotReachable && status != AFNetworkReachabilityStatusUnknown;
}

- (dispatch_queue_t)privateParsingQueue
{
    if(!_privateParsingQueue)
    {
        const char* queueName = NULL;
        NSString* queueNameAsString = NSStringFromClass([self class]);
        if(queueNameAsString.length)
        {
            queueName = [queueNameAsString cStringUsingEncoding:NSASCIIStringEncoding];
        }
        
        _privateParsingQueue = dispatch_queue_create(queueName, DISPATCH_QUEUE_SERIAL);
    }
    return _privateParsingQueue;
}

- (void)reachabilityDidChange
{
    if(self.reachabilityCallback)
    {
        self.reachabilityCallback([self isNetworkAvailable]);
    }
}

@end
