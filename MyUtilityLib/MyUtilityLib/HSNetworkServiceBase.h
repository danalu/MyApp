//
//  BaseService.h
//  XXXSearch
//
//  Created by Dana on 23/08/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Defines a reachability callback that can be exposed by subclasses.
 @param isNetworkAvailable YES if this service is reachable over the available networks.
 */
typedef void(^ReachabilityServiceCallback)(BOOL isNetworkAvailable);

/**
 This is the base class for representing network services.
 To represent a new network service you should derive from this class
 and include the HSNetworkServiceBase+Subclasses header.
 */
@interface HSNetworkServiceBase : NSObject

/**
 YES if the internet can be reached for this service at the present time.
 */
@property (nonatomic,readonly) BOOL isNetworkAvailable;

/**
 The base class designated initializer. 
 Derived classes should call this with the base URL for the 
 service calls they make, e.g. http://things.provider.com/api/.
 */
- (id)initWithBaseURL:(NSURL*)baseURL;


@end
