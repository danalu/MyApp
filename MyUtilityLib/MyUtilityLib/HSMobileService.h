//
//  ListingsService.h
//  XXXSearch
//
//  Created by Dana on 06/11/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import "HSNetworkServiceBase.h"
#import "HSServiceTask.h"

/**
 Posted when reachability of the mobile service API changes.
 The notification object is a NSNumber wrapping a BOOL to indicate reachable (YES) or not reachable (NO).
 */
extern NSString* const HSMobileServiceReachabilityDidChangeNotification;

/**
 The Yellowbook middle tier service.
 You should usually manage requests to this service through instances of @ref YBServiceTask.
 It's rare that you'd ever need to interact with this directly.
 */
@interface HSMobileService : HSNetworkServiceBase

+ (instancetype)sharedMobileService;

@end
