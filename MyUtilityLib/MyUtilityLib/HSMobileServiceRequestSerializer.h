//
//  YBMobileServiceRequestSerializer.h
//  XXXSearch
//
//  Created by Dana on 21/02/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "AFURLRequestSerialization.h"

/**
 We use this to add some standard headers to our middle tier requests.
 Currently only enables response compression.
 */
@interface HSMobileServiceRequestSerializer : AFJSONRequestSerializer

@end
