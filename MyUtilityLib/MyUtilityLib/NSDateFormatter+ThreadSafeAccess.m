//
//  NSDateFormatter+ThreadSafeAccess.m
//  XXXSearch
//
//  Created by Bruce Li on 17/01/2014.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "NSDateFormatter+ThreadSafeAccess.h"

@implementation NSDateFormatter (ThreadSafeAccess)

+ (instancetype)hs_localizedDateFormatterForFormat:(NSString*)format
{
    return [self hs_formatterInThread:[NSThread currentThread] dateFormat:format localized:NO];
}

+ (instancetype)hs_genericDateFormatterForFormat:(NSString*)format
{
    return [self hs_formatterInThread:[NSThread currentThread] dateFormat:format localized:YES];
}

+ (instancetype)hs_formatterInThread:(NSThread*)thread dateFormat:(NSString*)dateFormat localized:(BOOL)localized
{
    NSParameterAssert(dateFormat);
    if(!dateFormat)
    {
        return nil;
    }
    
    NSString* key = [dateFormat stringByAppendingFormat:@"%d", localized];
    NSMutableDictionary* threadDictionary = [thread threadDictionary];
    NSDateFormatter* dateFormatter = [threadDictionary objectForKey:key];
    if(!dateFormatter)
    {
        dateFormatter = [self hs_dateFormatterWithFormat:dateFormat localized:localized];
        if(dateFormatter)
        {
            [threadDictionary setObject:dateFormatter forKey:key];
        }
    }
    return dateFormatter;
}

+ (instancetype)hs_dateFormatterWithFormat:(NSString*)format localized:(BOOL)localized
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    if(!localized)
    {
        dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    dateFormatter.dateFormat = format;
    return dateFormatter;
}

@end
