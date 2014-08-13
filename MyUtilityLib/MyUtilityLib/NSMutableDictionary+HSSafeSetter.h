//
//  NSMutableDictionary+HSSafeSetter.h
//  Navigator
//
//  Created by Bruce Li on 24/09/2013.
//  Copyright (c) 2013 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (HSSafeSetter)

- (void)hs_setSafeValue:(id)value forKey:(NSString*)key;

- (void)hs_setSafeValue:(id)value withDefault:(id)defaultForUnsafeValues forKey:(NSString*)key;

@end
