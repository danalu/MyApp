//
//  NSDictionary+HSTransformations.m
//  XXXSearch
//
//  Created by Bruce Li on 03/07/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import "NSDictionary+HSTransformations.h"

HSDictionaryValueTransformer const HSTransformNumberOrIntegerStringToNumber = ^id(id obj){
    
    if([obj isKindOfClass:[NSNumber class]])
    {
        return obj;
    }
    else if([obj isKindOfClass:[NSString class]] && [obj length] > 0)
    {
        return @([obj integerValue]);
    }
    return nil;
};

HSDictionaryValueTransformer const HSTransformStringValueToString = ^id(id obj){
    if([obj isKindOfClass:[NSString class]])
    {
        return obj;
    }
    else if([obj respondsToSelector:@selector(stringValue)])
    {
        return [obj stringValue];
    }
    return nil;
};

@implementation NSDictionary (HSTransformations)

- (NSDictionary*)dictionaryByRemappingKeys:(NSDictionary*)keyMap
{
    return [self dictionaryByRemappingKeys:keyMap keepUnmappedKeys:NO];
}

- (NSDictionary*)dictionaryByRemappingKeys:(NSDictionary*)keyMap keepUnmappedKeys:(BOOL)keepUnmapped
{
    NSMutableDictionary* remappedDictionary = [[NSMutableDictionary alloc] initWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString* remappedKey = keyMap[key];
        if(!keyMap[key] && keepUnmapped)
        {
            remappedKey = key;
        }
        if(remappedKey)
        {
            remappedDictionary[remappedKey] = obj;
        }
    }];
    return [remappedDictionary copy];
}

- (NSDictionary*)dictionaryByRemappingKeys:(NSDictionary*)keyMap values:(NSDictionary*)valueMap
{
    return [self dictionaryByRemappingKeys:keyMap values:valueMap keepUnmappedKeys:NO];
}

- (NSDictionary*)dictionaryByRemappingKeys:(NSDictionary *)keyMap values:(NSDictionary*)valueMap keepUnmappedKeys:(BOOL)keepUnmapped
{
    NSMutableDictionary* remappedDictionary = [[NSMutableDictionary alloc] initWithCapacity:self.count];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString* remappedKey = keyMap[key];
        if(!keyMap[key] && keepUnmapped)
        {
            remappedKey = key;
        }
        if(remappedKey)
        {
            HSDictionaryValueTransformer transformer = valueMap[key];
            id remappedValue = transformer ? transformer(obj) : obj;
            if(remappedValue)
            {
                remappedDictionary[remappedKey] = remappedValue;
            }
        }
    }];
    return [remappedDictionary copy];
}

@end
