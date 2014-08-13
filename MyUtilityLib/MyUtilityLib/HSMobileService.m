//
//  YBListingsService.m
//  XXXSearch
//
//  Created by Dana on 06/11/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import "HSMobileService.h"
#import "HSServiceTask+Private.h"
#import "HSNetworkServiceBase+Subclasses.h"
#import "NSDictionary+HSCheckedExtraction.h"
#import "HSMobileServiceResponseSerializer.h"
#import "HSMobileServiceRequestSerializer.h"

NSString* const HSMobileServiceReachabilityDidChangeNotification = @"HSMobileServiceReachabilityDidChangeNotification";

@implementation HSMobileService

#pragma mark - Lifecycle -

+ (instancetype)sharedMobileService
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (id)init
{

    NSString  *serviceURL = @"http://rtc-840528501.ap-southeast-1.elb.amazonaws.com/feed/";
    NSParameterAssert(serviceURL.length);
    if((self = [super initWithBaseURL:[NSURL URLWithString:serviceURL]]))
    {
        [self setReachabilityCallback:^(BOOL isServiceAvailable){
            [[NSNotificationCenter defaultCenter] postNotificationName:HSMobileServiceReachabilityDidChangeNotification object:@(isServiceAvailable)];
        }];
        
        self.networkClient.requestSerializer = [HSMobileServiceRequestSerializer serializer];
        self.networkClient.responseSerializer = [HSMobileServiceResponseSerializer serializer];
    }
    return self;
}

#pragma mark - Credentials -

- (NSURLCredential*)serviceCredentials
{
#pragma #todo
//    NSString* username = [AppSettingManager sharedInstance].webAPIUserName;
//    NSString* password = [AppSettingManager sharedInstance].webAPIPassword;
//    return [NSURLCredential credentialWithUser:username password:password persistence:NSURLCredentialPersistenceForSession];
    return nil;
}

#pragma mark - Constructor helpers -

- (NSDictionary*)parametersByAddingStandardParameters:(NSDictionary*)parameters
{
    NSMutableDictionary* allParameters = [[NSMutableDictionary alloc] init];
    [allParameters addEntriesFromDictionary:parameters];
    return allParameters;
}

- (NSMutableURLRequest*)urlRequestForTask:(HSServiceTask*)task
{
    NSString* requestMethod = [task requestMethodAsString];
    NSURL* url = [NSURL URLWithString:task.servicePath relativeToURL:self.networkClient.baseURL];
    NSDictionary* parameters = [self parametersByAddingStandardParameters:task.parameters];
    NSMutableURLRequest* request = nil;
    if(task.requestMethod == MobileServicePOST)
    {
//        // The middle tier won't accept application/json POST bodies, we have to use form encoding.
//        request = [self.networkClient.requestSerializer multipartFormRequestWithMethod:requestMethod URLString:[url absoluteString] parameters:parameters constructingBodyWithBlock:task.formBodyProvider error:nil];
        
        request = [self.networkClient.requestSerializer requestWithMethod:requestMethod URLString:[url absoluteString] parameters:parameters error:nil];
    }
    else
    {
        request = [self.networkClient.requestSerializer requestWithMethod:requestMethod URLString:[url absoluteString] parameters:parameters error:nil];
    }
    request.timeoutInterval = task.timeoutInterval;
    return request;
}

- (void)enqueueTask:(HSServiceTask *)task
{
    NSMutableURLRequest* request = [self urlRequestForTask:task];
    const BOOL hideFromErrorLogging = task.hideFromErrorLogging;

    HSServiceResponseContentBlock parsingBlockRef = task.parsingBlock;
    HSMobileServiceTaskCompletionBlock completionBlockRef = task.completionBlock;
    AFHTTPRequestOperation* requestOp = [self.networkClient HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id parsedResponse = nil;
        NSError* parsingError = nil;
        parsedResponse = parsingBlockRef(responseObject, &parsingError);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlockRef(parsedResponse, parsingError);
        });
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if(!hideFromErrorLogging)
        {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [[LogManager sharedInstance] log:[Log logForURL:operation.request.URL networkError:error response:operation.response]];
//            });
            NSLog(@"Conmmunication Error");
        }
        
        if(completionBlockRef)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlockRef(nil, error);
            });
        }
    }];
    
    requestOp.completionQueue = self.privateParsingQueue;
    requestOp.queuePriority = task.priority == TaskPriorityLow ? NSOperationQueuePriorityVeryLow : NSOperationQueuePriorityNormal;
    requestOp.credential = [self serviceCredentials];
    task.operation = requestOp;
    [self.networkClient.operationQueue addOperation:requestOp];
    
    NSLog(@"Submitting middle-tier request: %@", requestOp.request);
}

@end

