//
//  YBMobileServiceStatus.h
//  XXXSearch
//
//  Created by Dana on 21/02/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Wraps a response from the middle tier YB service, basically the Meta stuff plus what you find
 under "Response".
 */
@interface HSMobileServiceResponse : NSObject

@property (nonatomic) NSInteger statusCode;                    //!< The wrapped Meta status code.
@property (nonatomic,copy) NSString* message;                   //!< The wrapped Meta message.
@property (nonatomic,copy) NSDate* timeStamp;                   //!< Timestamp read from the Meta code.
@property (nonatomic,strong) NSError* parsingError;             //!< This is set if the middle tier response represents an error status or if the middle tier response cannot be parsed.
@property (nonatomic,strong) NSDictionary* responseContent;     //!< The content of the wrapped Response section. Clients should parse this into the domain objects for their request.

@property (nonatomic,readonly) BOOL isSuccessful;               //!< Convenience - returns YES if the middletier response represents a successful action.

/**
 Designated init.
 @param JSON A dictionary (hopefully) containing a standard middletier response. If the content of JSON
 is non-conformant, cannot be parsed or is otherwise invalid, the returned instance will have parsingError set.
 */
- (id)initWithResponseObject:(id)JSON;

- (id)initWithServiceResponseObject:(id)JSON;

@end
