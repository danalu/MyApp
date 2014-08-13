//
//  HSMobileService+Utility.h
//  HotelSDK
//
//  Created by liyanbo on 14-5-6.
//
//

#import "HSMobileService.h"

@interface HSMobileService (Utility)

+ (NSString*) pathWithURL:(NSString*)url;
+ (NSDictionary*) parameterWithURL:(NSString*)url;

@end
