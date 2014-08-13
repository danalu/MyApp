//
//  YBMobileServiceRequest+Private.h
//  XXXSearch
//
//  Created by Dana on 30/01/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "HSServiceTask.h"
#import "HSMobileServiceResponse.h"
#import "NSMutableDictionary+HSSafeSetter.h"
#import "HSNetworkServiceBase+Subclasses.h"

/**
 This block is executed to process the JSON content of YBMobileServiceResponse into domain objects.
 For example, it might generate Listing instances from MerchantSearchWithImage responses.
 Note that this block is not executed in the case where the middletier reports a status error or the 
 Meta response cannot be parsed.
 Note that this block is executed on a secondary thread. You shouldn't make UI calls from here.
 @param response The wrapped response from the middle tier.
 @param parsingError If the response content is not parsable, you should set this to NetworkServiceErrorParsingFailure.
 @return An object that will be pased to the completion block as "parsedResponse" in the success case.
 */
typedef id(^HSMobileServiceTaskParsingBlock)(HSMobileServiceResponse* response, NSError** parsingError);

/**
 This block completes a request in failure or success cases. 
 It is always executed on the main thread.
 @param parsedResponse The return value from the parsingBlock for this task.
 @param error An error if one occurred.
 */
typedef void(^HSMobileServiceTaskCompletionBlock)(id parsedResponse, NSError* error);

typedef id(^HSServiceResponseContentBlock)(id content, NSError** error);

typedef enum
{
    MobileServiceGET,
    MobileServicePOST
} RequestMethod;

typedef enum
{
    TaskPriorityNormal,
    TaskPriorityLow
} TaskPriority;

@class YBMobileServiceBodyPart;
@class AFHTTPRequestOperation;
@protocol AFMultipartFormData;

/**
 Represents a request through the middle tier API, e.g. fetch deals nearby etc.
 
 */
@interface HSServiceTask ()

@property (nonatomic,copy) NSString* servicePath;                               //!< Service path represents the path to the request for this task, e.g. /ajax/content/MerchantSearchWithImage etc.
@property (nonatomic) RequestMethod requestMethod;                            //!< Defaults to @ref YBMobileServiceGET.
@property (nonatomic,strong) NSDictionary* parameters;                          //!< nil by default. These parameters are ADDED to the standard parameter set that all YBMobileService tasks include (currently, iformat=json).
@property (nonatomic,copy) void(^formBodyProvider)(id <AFMultipartFormData>);   //!< nil by default. Allows you to provide a body for form data. Note that parameters in POST requests are automatically included in forms.

@property (nonatomic) NSTimeInterval timeoutInterval;                           //!< Defaults to 15 seconds.
@property (nonatomic) BOOL hideFromErrorLogging;                                //!< If YES, failures from this task will not be logged to the YB error logging service. Defaults to NO, failures of this task are logged.
@property (nonatomic) TaskPriority priority;                                  //!< Priority of this task in the queue of requests.

//@property (nonatomic,copy) HSMobileServiceTaskParsingBlock parsingBlock;        //!< Executed to parse the response from the middletier into domain objects. This block is executed on a secondary thread.
@property (nonatomic, copy) HSServiceResponseContentBlock parsingBlock;

@property (nonatomic,copy) HSMobileServiceTaskCompletionBlock completionBlock;  //!< Executed to complete the response. This block is executed on the main thread.

@property (nonatomic,weak) AFHTTPRequestOperation* operation;                   //!< Client code should not touch this. It is managed by the task.

@property (nonatomic,readonly) NSString* requestMethodAsString;                 //!< Convenience method that converts the @ref requestMethod into a string representation, e.g. GET or POST.

/**
 Designated init.
 */
- (id)initWithServicePath:(NSString*)servicePath
            requestMethod:(RequestMethod)requestMethod
             parsingBlock:(HSMobileServiceTaskParsingBlock)parsingBlock
          completionBlock:(HSMobileServiceTaskCompletionBlock)completionBlock;

/**
 Submit the task to a queue for execution.
 Low priority tasks may take longer to start if there are higher priority jobs around.
 */
- (void)submit;


@end
