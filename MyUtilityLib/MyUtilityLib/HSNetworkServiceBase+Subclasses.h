//
//  HSNetworkServiceBase+Subclasses.h
//  XXXSearch
//
//  Created by Dana on 23/08/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import "HSNetworkServiceBase.h"
#import "AFNetworking.h"
//#import "EXTScope.h"            // provides @weakify, @strongify macros

@interface HSNetworkServiceBase ()

/**
 Set the reachability callback for the underlying base class.
 */
@property (nonatomic,copy) ReachabilityServiceCallback reachabilityCallback;

/**
 The network client for subclass use. It's set up by the call to
 the @ref HSNetworkServiceBase designated initializer.
 */
@property (nonatomic,strong,readonly) AFHTTPRequestOperationManager* networkClient;

/**
 A private serial queue for use by all requests to this service.
 Lazily created on access, and destroyed on dealloc of the base class.
 */
@property (nonatomic,readonly) dispatch_queue_t privateParsingQueue;

@end
