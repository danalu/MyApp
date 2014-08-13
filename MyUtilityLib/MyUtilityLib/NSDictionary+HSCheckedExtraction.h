//
//  NSDictionary+HSCheckedExtraction.h
//  XXXSearch
//
//  Created by Bruce Li on 27/06/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @category NSDictionary(HSCheckedExtraction)
 @brief Extract keys of expected types from dictionaries, optionally allowing nulls.
 */
@interface NSDictionary (HSCheckedExtraction)

/**
 Returns an NSNumber value associated with the given key.
 @param aKey The key whose associated value we are interested in.
 @return A number associated with aKey, or nil if aKey does not exist or the value is not a kind of NSNumber.
 */
- (NSNumber*)numberForKey:(id)aKey;

/**
 Returns a string value associated with the given key.
 @param aKey The key whose associated value we are interested in.
 @return A string associated with aKey, or nil if aKey does not exist or the value is not a kind of NSString.
 */
- (NSString*)stringForKey:(id)aKey;

/**
 Returns a non-empty string value associated with the given key - the string must have a non-zero length or nil is returned instead.
 @param aKey The key whose associated value we are interested in.
 @return A string with length > 0 associated with aKey, or nil if aKey does not exist or the value is not a kind of NSString or is an empty string.
 */
- (NSString*)nonEmptyStringForKey:(id)aKey;

/**
 Returns a URL value at the given key. If the underlying value is an NSString, it will be converted to a URL using -[NSURL URLForString:].
 @param aKey The key whose associated value we are interested in.
 @return A URL associated with aKey, or nil if aKey does not exist or the value is not a kind of NSString or NSURL or is a NSString that cannot be converted to a NSURL.
 */
- (NSURL*)urlForKey:(id)aKey;

/**
 Returns an array value associated with the given key. Empty arrays can be returned if required.
 @param aKey The key whose associated value we are interested in.
 @return An array associated with aKey, or nil if aKey does not exist or the value is not a kind of NSArray.
 */
- (NSArray*)arrayForKey:(id)aKey;

/**
 Returns an array value associated with the given key that has at least one entry. Empty arrays will not be returned.
 @param aKey The key whose associated value we are interested in.
 @return An array associated with aKey, or nil if aKey does not exist or the value is not a kind of NSArray or is an empty array.
 */
- (NSArray*)nonEmptyArrayForKey:(id)aKey;

/**
 Returns a dictionary value associated with the given key.
 @param aKey The key whose associated value we are interested in.
 @return A dictionary associated with aKey, or nil if aKey does not exist or the value is not a kind of NSDictionary.
 */
- (NSDictionary*)dictionaryForKey:(id)aKey;

/**
 Returns a dictionary value associated with the given key that has at least one entry. Empty dictionaries will not be returned.
 @param aKey The key whose associated value we are interested in.
 @return A dictionary associated with aKey, or nil if aKey does not exist or the value is not a kind of NSDictionary or is an empty dictionary.
 */
- (NSDictionary*)nonEmptyDictionaryForKey:(id)aKey;

/**
 Returns the value associated with the given key in the dictionary, as long as it is of the expected type, otherwise returns nil. Optionally allows NSNulls to be returned if present.
 @param aKey The key whose associated value we are interested in.
 @param expectedClass The class/class cluster we expect the value to be an instance of/a member of.
 @param allowNull If YES and the value associated with the key is NSNull, NSNull will be returned.
 @return An object of the expected type associated with aKey, or nil if aKey does not exist or the value associated with it is not a kind of the requested type. Exceptionally, if allowNull is YES, NSNull values may be returned.
 */
- (id)objectForKey:(id)aKey ofClass:(Class)expectedClass allowingNull:(BOOL)allowNull;

- (NSString*)nonEmptyStringForKeyPath:(NSString *)aKey;
- (NSArray*)nonEmptyArrayForKeyPath:(NSString *)aKey;
- (NSDictionary*)nonEmptyDictionaryForKeyPath:(NSString *)aKey;
- (NSNumber*)numberForKeyPath:(NSString *)aKey;

@end
