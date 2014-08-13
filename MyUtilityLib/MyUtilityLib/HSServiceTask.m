//
//  YBMobileServiceRequest.m
//  XXXSearch
//
//  Created by Dana on 30/01/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "HSServiceTask+Private.h"
#import "AFHTTPRequestOperation.h"
#import "HSMobileService+Private.h"
#import "HSNetworkServiceBase+Subclasses.h"
//#import "LogManager.h"

static const NSTimeInterval DefaultTimeoutIntervalInSeconds = 15.0;

@implementation HSServiceTask

#pragma mark - Lifecycle -

- (id)init
{
    return [self initWithServicePath:nil requestMethod:MobileServiceGET parsingBlock:nil completionBlock:nil];
}

- (id)initWithServicePath:(NSString*)servicePath
            requestMethod:(RequestMethod)requestMethod
             parsingBlock:(HSMobileServiceTaskParsingBlock)parsingBlock
          completionBlock:(HSMobileServiceTaskCompletionBlock)completionBlock
{
    if((self = [super init]))
    {
        _servicePath = [servicePath copy];
        _timeoutInterval = DefaultTimeoutIntervalInSeconds;
        _requestMethod = requestMethod;
        _parsingBlock = [parsingBlock copy];
        _completionBlock = [completionBlock copy];
    }
    return self;
}

- (void)submit
{
    [[HSMobileService sharedMobileService] enqueueTask:self];
}

- (NSString*)requestMethodAsString
{
    NSArray* methodStrings = @[ @"GET", @"POST"  ];
    return methodStrings[self.requestMethod];
}

#pragma mark - Cancellation -

- (void)cancel
{
    AFHTTPRequestOperation* strongOpRef = self.operation;
    if(strongOpRef)
    {
        [strongOpRef cancel];
    }
}

- (NSString*)debugDescription
{
    return [NSString stringWithFormat:@"%@ servicePath:%@ requestMethod:%@ timeoutInterval:%.1f parsingBlock:%@ completionBlock:%@", [super debugDescription], self.servicePath, [self requestMethodAsString], self.timeoutInterval, self.parsingBlock, self.completionBlock];
}

@end
