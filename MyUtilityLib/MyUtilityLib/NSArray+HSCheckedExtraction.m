//
//  NSArray+HSCheckedExtraction.m
//  XXXSearch
//
//  Created by Bruce Li on 08/11/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import "NSArray+HSCheckedExtraction.h"

@implementation NSArray (HSCheckedExtraction)

- (NSArray*)hs_arrayAtIndex:(NSUInteger)index
{
    return [self hs_objectAtIndex:index ofClass:[NSArray class] allowingNull:NO];
}

- (NSArray*)hs_nonEmptyArrayAtIndex:(NSUInteger)index
{
    NSArray* array = [self hs_arrayAtIndex:index];
    return array.count ? array : nil;
}

- (NSDictionary*)hs_dictionaryAtIndex:(NSUInteger)index
{
    return [self hs_objectAtIndex:index ofClass:[NSDictionary class] allowingNull:NO];
}

- (NSDictionary*)hs_nonEmptyDictionaryAtIndex:(NSUInteger)index
{
    NSDictionary* dictionary = [self hs_dictionaryAtIndex:index];
    return dictionary.count ? dictionary : nil;
}

- (id)hs_objectAtIndex:(NSUInteger)index ofClass:(Class)expectedClass allowingNull:(BOOL)allowNull
{
    if(!self.count || index == NSNotFound || index >= self.count)
    {
        // Invalid indexing.
        return nil;
    }
    
    id object = self[index];
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

@end
