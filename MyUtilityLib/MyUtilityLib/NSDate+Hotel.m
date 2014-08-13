//
//  NSDate+Hotel.m
//  HotelApp
//
//  Created by xwzhou on 14-4-22.
//
//

#import "NSDate+Hotel.h"

@implementation NSDate(Hotel)

- (NSInteger)weekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday fromDate:self];
    return [comps weekday];
}

@end
