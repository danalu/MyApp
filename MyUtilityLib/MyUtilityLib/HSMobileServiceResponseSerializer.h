//
//  YBMobileServiceResponseSerializer.h
//  XXXSearch
//
//  Created by Dana on 21/02/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "AFURLResponseSerialization.h"

/**
 We use this to parse middletier responses, which should be represented by 
 YBMobileServiceResponse objects.
 */
@interface HSMobileServiceResponseSerializer : AFJSONResponseSerializer

@end
