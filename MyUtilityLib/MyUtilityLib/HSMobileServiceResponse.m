//
//  YBMobileServiceStatus.m
//  XXXSearch
//
//  Created by Dana on 21/02/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "HSMobileServiceResponse.h"
#import "HSNetworkServiceBase.h"
#import "NSDictionary+HSCheckedExtraction.h"
#import "NSDictionary+HSTransformations.h"
#import "NSDateFormatter+ThreadSafeAccess.h"

@implementation HSMobileServiceResponse

- (id)init
{
    return [self initWithResponseObject:nil];
}

- (id)initWithResponseObject:(id)JSON
{
    if(!(self = [super init]))
    {
        return nil;
    }
    
    _statusCode = NSNotFound;   // By default, we report failure to extract a status code.
    
    if(![JSON isKindOfClass:[NSDictionary class]])
    {
        // Can't understand the response at all.
        _parsingError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil];
        return self;
    }
    
    NSDictionary* resultDictionary = [(NSDictionary*)JSON nonEmptyDictionaryForKey:@"Result"];
    
    NSDictionary* metaDictionary = [resultDictionary nonEmptyDictionaryForKey:@"Meta"];
    if(!metaDictionary)
    {
        // Can't understand the response at all.
        _parsingError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil];

        return self;
    }

    NSNumber* wrappedStatusCode = HSTransformNumberOrIntegerStringToNumber([metaDictionary objectForKey:@"Code"]);  //!< @todo Some API calls return strings for the status code :(
    if(wrappedStatusCode)
    {
        _statusCode = [wrappedStatusCode integerValue];
    }
    _message = [metaDictionary stringForKey:@"Message"];
    NSString* timeStampString = [metaDictionary nonEmptyStringForKey:@"TimeStamp"];
    if(timeStampString)
    {
        NSDateFormatter* dateFormatter = [NSDateFormatter hs_genericDateFormatterForFormat:@"EEE MMM dd HH:mm:ss zzz yyyy"];
        _timeStamp = [dateFormatter dateFromString:timeStampString];
    }
    
    if(_statusCode == NSNotFound || _statusCode < 100)
    {
        // If we got no status code, this is a parsing error.
        _parsingError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil];
    }
    else if(_statusCode >= 400 && _statusCode < 500)
    {
        // 4xx errors are client errors
        _parsingError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorResourceUnavailable userInfo:nil];
    }
    else if(_statusCode >= 500)
    {
        // 5xx are server errors
        _parsingError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorBadServerResponse userInfo:nil];
    }
    
    _responseContent = [resultDictionary nonEmptyDictionaryForKey:@"Response"];

    return self;
}

- (id)initWithServiceResponseObject:(id)JSON {
    if(!(self = [super init]))
    {
        return nil;
    }
    
    _statusCode = NSNotFound;   // By default, we report failure to extract a status code.
    
    if(![JSON isKindOfClass:[NSDictionary class]])
    {
        // Can't understand the response at all.
        _parsingError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil];
        return self;
    }

    NSString* status = [(NSDictionary*)JSON nonEmptyStringForKey:@"status"];
    
    if (![status isEqualToString:@"ok"]) {
        // Can't understand the response at all.
        _parsingError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil];
        return self;
    }
    
    _message = [(NSDictionary*)JSON nonEmptyStringForKey:@"message"];
    
    _responseContent = [(NSDictionary*)JSON  nonEmptyDictionaryForKey:@"results"];
    
    if (!_responseContent) {
        _parsingError = [NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotParseResponse userInfo:nil];
        return self;
    }
    
    return self;
}

- (BOOL)isSuccessful
{
    return !self.parsingError;
}

- (NSString*)debugDescription
{
    return [NSString stringWithFormat:@"%@ isSuccessful:%d statusCode:%d message:%@ timeStamp:%@ parsingError:%@ responseContent:%p", [super debugDescription], [self isSuccessful], self.statusCode, self.message, self.timeStamp, self.parsingError, self.responseContent];
}

@end
