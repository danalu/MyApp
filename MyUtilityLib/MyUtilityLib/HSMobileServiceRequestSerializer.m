//
//  YBMobileServiceRequestSerializer.m
//  XXXSearch
//
//  Created by Dana on 21/02/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "HSMobileServiceRequestSerializer.h"

@implementation HSMobileServiceRequestSerializer

+ (instancetype)serializer
{
    HSMobileServiceRequestSerializer* serializer = [self serializerWithWritingOptions:0];
    [serializer setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    return serializer;
}

#pragma mark - AFURLRequestSerialization

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    return [super requestBySerializingRequest:request withParameters:parameters error:error];
}

@end
