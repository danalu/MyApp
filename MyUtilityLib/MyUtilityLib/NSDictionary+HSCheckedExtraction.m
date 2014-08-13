//
//  NSDictionary+HSCheckedExtraction.m
//  XXXSearch
//
//  Created by Bruce Li on 27/06/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import "NSDictionary+HSCheckedExtraction.h"

@implementation NSDictionary (HSCheckedExtraction)

- (NSNumber*)numberForKey:(id)aKey {
	return [self objectForKey:aKey ofClass:[NSNumber class] allowingNull:NO];
}

- (NSString*)stringForKey:(id)aKey
{
	return [self objectForKey:aKey ofClass:[NSString class] allowingNull:NO];
}

- (NSString*)nonEmptyStringForKey:(id)aKey
{
    NSString* str = [self stringForKey:aKey];
    return str.length > 0 ? str : nil;
}

- (NSArray*)arrayForKey:(id)aKey
{
    return [self objectForKey:aKey ofClass:[NSArray class] allowingNull:NO];
}

- (NSArray*)nonEmptyArrayForKey:(id)aKey
{
    NSArray* array = [self objectForKey:aKey ofClass:[NSArray class] allowingNull:NO];
    return array.count > 0 ? array : nil;
}

- (NSDictionary*)dictionaryForKey:(id)aKey
{
    return [self objectForKey:aKey ofClass:[NSDictionary class] allowingNull:NO];
}

- (NSDictionary*)nonEmptyDictionaryForKey:(id)aKey
{
    NSDictionary* dict = [self dictionaryForKey:aKey];
    return dict.count > 0 ? dict : nil;
}

- (id)objectForKey:(id)aKey ofClass:(Class)expectedClass allowingNull:(BOOL)allowNull
{
	id object = [self objectForKey:aKey];
	if(!object)
    {
		return nil;
	}
	
	if([(NSNull*)object isEqual:[NSNull null]])
    {
		return (allowNull) ? object : nil;
	}
	
	if(![object isKindOfClass:expectedClass])
    {
		return nil;
	}
	return object;
}

- (NSString*)nonEmptyStringForKeyPath:(NSString *)aKey {
    return [self valueForKeyPath:aKey ofClass:[NSString class]];
}

- (NSArray*)nonEmptyArrayForKeyPath:(NSString *)aKey {
    return [self valueForKeyPath:aKey ofClass:[NSArray class]];
}

- (NSDictionary*)nonEmptyDictionaryForKeyPath:(NSString *)aKey {
    return [self valueForKeyPath:aKey ofClass:[NSDictionary class]];
}

- (NSNumber*)numberForKeyPath:(NSString *)aKey {
    return [self valueForKeyPath:aKey ofClass:[NSNumber class]];
}

- (id)valueForKeyPath:(NSString *)aKey ofClass:(Class)expectedClass
{
	id value = [self valueForKeyPath:aKey];
    if (value == nil) {
        return nil;
    }
    if ([value isKindOfClass:[NSNull class]] == YES) {
        return nil;
    }
    if ([value isKindOfClass:expectedClass] == NO) {
        return nil;
    }
    return value;
}

#pragma mark - Derived - 

- (NSURL*)urlForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if([object isKindOfClass:[NSURL class]])
    {
        return object;
    }
    if([object isKindOfClass:[NSString class]])
    {
        return [NSURL URLWithString:(NSString*)object];
    }
    return nil;
}


@end
