//
//  MobileService+RequestConstructors.h
//  XXXSearch
//
//  Created by Dana on 02/01/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "HSMobileService.h"

@interface HSMobileService ()

/**
 Places an operation on the queue to be submitted to the middle tier.
 */
- (void)enqueueTask:(HSServiceTask*)task;

@end
