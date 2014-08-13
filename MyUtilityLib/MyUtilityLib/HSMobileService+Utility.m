//
//  HSMobileService+Utility.m
//  HotelSDK
//
//  Created by liyanbo on 14-5-6.
//
//

#import "HSMobileService+Utility.h"

@implementation HSMobileService (Utility)

+ (NSString*) pathWithURL:(NSString*)url
{
    
    NSArray* section =  [url componentsSeparatedByString:@"/"];
    
    if (section.count <= 1) {
        return url;
    }
    
    NSMutableString* path = [NSMutableString string];
    for (int i = 0; i < section.count - 1; i ++) {

        [path appendFormat:@"%@/",[section objectAtIndex:i]];
    }

    return path;
}

+ (NSDictionary*) parameterWithURL:(NSString*)url
{
    NSArray* urlSection = [url componentsSeparatedByString:@"?"];
    NSMutableDictionary* parameter = [NSMutableDictionary dictionary];
    
    if (urlSection.count <= 1) {
        return parameter;
    }
    
    
    NSArray* parameterSection = [[urlSection objectAtIndex:1] componentsSeparatedByString:@"&"];
    
    for (int i = 0; i < parameterSection.count; i++)
    {
        NSRange found = [[parameterSection objectAtIndex:i] rangeOfString:@"=" ];
        if (found.location != NSNotFound)
        {
            NSArray* section =  [[parameterSection objectAtIndex:i] componentsSeparatedByString:@"="];
            [parameter setObject:[section objectAtIndex:1] forKey:[section objectAtIndex:0]];
        }
    }
    return parameter;
}

@end
