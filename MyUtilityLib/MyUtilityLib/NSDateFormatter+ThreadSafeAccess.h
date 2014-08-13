//
//  NSDateFormatter+ThreadSafeAccess.h
//  XXXSearch
//
//  Created by Bruce Li on 17/01/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 NSDateFormatter is extremely expensive to create (takes a lot of time), but is also not thread-safe.
 This category provides methods to attenuate the cost by providing a thread-safe way to share formatters.
 */
@interface NSDateFormatter (ThreadSafeAccess)

/**
 Returns a date formatter for the given format that can be used on the current thread.
 Avoids creating a new formatter if one that accepts the given format is available for use on this thread.
 The formatter will use the current locale and timezone, and is best used for converting NSDates into strings for display to the user.
 */
+ (instancetype)hs_localizedDateFormatterForFormat:(NSString*)format;

/**
 Returns a date formatter for the given format that can be used on the current thread.
 Avoids creating a new formatter if one that accepts the given format is available for use on this thread.
 The formatter will use the en_US_POSIX locale and GMT+0 timezone, and is best used for converting NSDates to and from web service date representations.
 */
+ (instancetype)hs_genericDateFormatterForFormat:(NSString*)format;


@end
