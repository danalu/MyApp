//
//  NSArray+HSCheckedExtraction.h
//  XXXSearch
//
//  Created by Bruce Li on 08/11/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HSCheckedExtraction)

- (NSArray*)hs_arrayAtIndex:(NSUInteger)index;

- (NSArray*)hs_nonEmptyArrayAtIndex:(NSUInteger)index;

- (NSDictionary*)hs_dictionaryAtIndex:(NSUInteger)index;

- (NSDictionary*)hs_nonEmptyDictionaryAtIndex:(NSUInteger)index;

- (id)hs_objectAtIndex:(NSUInteger)index ofClass:(Class)expectedClass allowingNull:(BOOL)allowNull;


@end
