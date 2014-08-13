//
//  NSMutableDictionary+HSSafeSetter.m
//  Navigator
//
//  Created by Bruce Li on 24/09/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import "NSMutableDictionary+HSSafeSetter.h"

@implementation NSMutableDictionary (HSSafeSetter)

- (void)hs_setSafeValue:(id)value forKey:(NSString*)key
{
    if(value != nil)
    {
        [self setValue:value forKey:key];
    }
}

- (void)hs_setSafeValue:(id)value withDefault:(id)defaultForUnsafeValues forKey:(NSString*)key
{
    NSParameterAssert(defaultForUnsafeValues);
    [self setValue:value ? value : defaultForUnsafeValues forKey:key];
}

@end
