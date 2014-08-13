//
//  YBMobileServiceResponseSerializer.m
//  XXXSearch
//
//  Created by Dana on 21/02/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "HSMobileServiceResponseSerializer.h"
#import "HSMobileServiceResponse.h"

@implementation HSMobileServiceResponseSerializer

+ (instancetype)serializer
{
    return [self serializerWithReadingOptions:0];
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    /*
     If we set and return this method's error parameter, we get switched to the failure
     completion block in YBMobileService which has no access to the YBMobileServiceResponse object we create here.
     We need the YBMobileServiceResponse object as it contains information on the failure that's 
     needed for logging.
     This means we have to log the failure from here where we still have access, but then we need some
     logic to avoid double-logging failures (because the failure completion block needs to log network errors).
     For now, we avoid this problem by returning a clean response object in this serializer and then
     leaving it up to YBMobileService to check and handle the error logging in both success and failure blocks.
     */
    id JSON = [super responseObjectForResponse:response data:data error:error];
 //   return [[HSMobileServiceResponse alloc] initWithResponseObject:JSON];
    return JSON;
}

@end
