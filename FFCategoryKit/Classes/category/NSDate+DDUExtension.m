//
//  NSDate+DDUExtension.m
//  DDU
//
//  Created by 沈士新 on 2017/8/28.
//  Copyright © 2017年 沈士新. All rights reserved.
//

#import "NSDate+DDUExtension.h"

@implementation NSDate (DDUExtension)
+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        NSLog(@"oneDay比 anotherDay时间晚");
        return 1;
    }
    else if (result == NSOrderedAscending){
        NSLog(@"oneDay比 anotherDay时间早");
        return -1;
    }
    NSLog(@"两者时间是同一个时间");
    return 0;
    
}

/**
 *  将0时区的时间转成0时区的时间戳
 */
+ (NSString *)transformToTimestampWithDate:(NSDate *)date{
    NSTimeInterval inter = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld", (long)inter];
}

/**
 *  将0时区的时间戳转成0时区的时间
 */
+ (NSDate *)transformToDateWithTimestamp:(NSString *)timestamp{
    NSTimeInterval inter = [timestamp doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:inter];
    return date;
}

/**
 *  将0时区的时间戳转成8时区的时间文本格式（“2015-12-13 13：34：45”）
 */
+ (NSString *)transformToStringWithTimestamp:(NSString *)timestamp{
    //1.先将时间戳->NSDate
    NSDate *date = [self transformToDateWithTimestamp:timestamp];
    //2.将date->NSString
    return [[self transformToStringWithDate:date] substringToIndex:16];
}


/**
 *  将0时区的时间戳(10位数)转成8时区的时间文本格式（“2012-12-12 12：12”）,带有只有时分的
 */
+ (NSString *)transformToHourMiniteFormatWithTimestamp:(NSString *)timestamp{
    //1.先将时间戳->NSDate
    NSDate *date = [self transformToDateWithTimestamp:timestamp];
    //2.将date->NSString
    return [[self transformToStringWithDate:date] substringToIndex:13];
}

/**
 *  将8时区的时间文本格式（“2015-12-13 13：34：45”）转成 0时区的时间戳
 */
+ (NSString *)transformToTimestampWithString:(NSString *)string{
    //1.先将NSString->NSDate
    NSDate *date = [self transformToDateWithString:string];
    //2.将date->timestamp
    return [self transformToStringWithDate:date];
}

/**
 *  将8时区的时间文本格式（“2015-12-13 13：34：45”）转成 0时区的NSDate
 */
+ (NSDate *)transformToDateWithString:(NSString *)string{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [df dateFromString:string];
    return date;
}

/**
 *  将0时区的NSDate转成 8时区的时间文本格式（“2015-12-13 13：34：45”）
 */
+ (NSString *)transformToStringWithDate:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [df stringFromDate:date];
    return string;
}




@end
