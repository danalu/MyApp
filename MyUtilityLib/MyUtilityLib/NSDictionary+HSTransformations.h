//
//  NSDictionary+HSTransformations.h
//  XXXSearch
//
//  Created by Bruce Li on 03/07/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id(^HSDictionaryValueTransformer)(id obj);

extern HSDictionaryValueTransformer const HSTransformNumberOrIntegerStringToNumber;

extern HSDictionaryValueTransformer const HSTransformStringValueToString;

/**
 @category NSDictionary(HSTransformations)
 @brief Create new dictionaries by renaming keys in existing dictionaries.
 */
@interface NSDictionary (HSTransformations)

/**
 Return a version of the receiver with the keys renamed according to the argument. For example,
 this method can remap a dictionary such as @{ @"address1" : ... } to @{ @"street" : ... }.
 Values whose keys are not included in keyMap are not included in the returned dictionary.
 Same as -[NSDictionary dictionaryByRemappingKeys:keepUnmappedKeys:] with NO as the argument for
 keepUnmapped.
 @param keyMap A dictionary mapping keys in the receiver to keys in the returned dictionary.
 */
- (NSDictionary*)dictionaryByRemappingKeys:(NSDictionary*)keyMap;

/**
 Return a version of the receiver with the keys renamed and the values remapped. For example,
 this method can remap a dictionary such as @{ @"myNumber" : @"1234" } to @{ @"myProperNumber" : @1234 }.
 Values whose keys are not included in keyMap are not included in the returned dictionary.
 @param keyMap A dictionary mapping keys in the receiver to keys in the returned dictionary.
 @param valueMap A dictionary mapping values in the receiver to values in the returned dictionary.
 */
- (NSDictionary*)dictionaryByRemappingKeys:(NSDictionary *)keyMap values:(NSDictionary*)valueMap;

/**
 Return a version of the receiver with the keys renamed according to the argument. For example,
 this method can remap a dictionary such as @{ @"address1" : ... } to @{ @"street" : ... }.
 @param keepUnmapped If YES, values whose keys are not included in keyMap are included in the 
 returned dictionary under their existing names, otherwise they are excluded from the returned 
 dictionary.
 @param keyMap A dictionary mapping keys in the receiver to keys in the returned dictionary.
 */
- (NSDictionary*)dictionaryByRemappingKeys:(NSDictionary*)keyMap keepUnmappedKeys:(BOOL)keepUnmapped;

/**
 Return a version of the receiver with the keys renamed and the values remapped. For example,
 this method can remap a dictionary such as @{ @"myNumber" : @"1234" } to @{ @"myProperNumber" : @1234 }.
 @param keyMap A dictionary mapping keys in the receiver to keys in the returned dictionary.
 @param valueMap A dictionary mapping values in the receiver to values in the returned dictionary.
 @param keepUnmapped If YES, values whose keys are not included in keyMap are included in the
 returned dictionary under their existing names, otherwise they are excluded from the returned
 dictionary.
 */
- (NSDictionary*)dictionaryByRemappingKeys:(NSDictionary *)keyMap values:(NSDictionary*)valueMap keepUnmappedKeys:(BOOL)keepUnmapped;

@end
