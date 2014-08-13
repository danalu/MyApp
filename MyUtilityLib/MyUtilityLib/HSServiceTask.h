//
//  YBMobileServiceRequest.h
//  XXXSearch
//
//  Created by Dana on 30/01/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Allows you to manage a request to the Yellowbook mobile middletier.
 */
@interface HSServiceTask : NSObject

/**
 Cancels the operation associated with this task, unless it's finished already.
 */
- (void)cancel;

@end
