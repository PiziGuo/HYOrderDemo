//
//  NSString+HYString.m
//  HYiTong
//
//  Created by David on 2016/12/30.
//  Copyright © 2016年 com.HROCLoud. All rights reserved.
//

#import "NSString+HYString.h"

@implementation NSString (HYString)


+ (instancetype)safeStringWithObject:(id)object {
    
    if ([object isKindOfClass:[NSString class]]) {
        
        if (![self isBlank:object] && object) {
            return object;
        }else{
            return @"";
        }
        
    } else if ([object isKindOfClass:[NSNumber class]]) {
        
        NSString *tempStr = [NSString stringWithFormat:@"%@",object];
        return tempStr;
        
    } else if (object == [NSNull null]){
        
        return @"";
    } else {
        
        return @"";
    }
}



+(BOOL)isBlank:(id)object {
    
    if ([object isKindOfClass:[NSString class]]) {
        
        if ( object == nil || object == NULL || [object isEqualToString : @"(null)" ] || [object isEqualToString : @"" ] || [object isEqual:[NSNull null]] || [object isEqualToString:@"<null>"]) {
            return YES ;
        }
        
        if ( [object isKindOfClass:[NSNull class]] ) {
            return YES ;
        }
        if ((id)object == [NSNull null]) {
            return YES;
        }
        if ( [[object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0 ) {
            return YES;
        }
        
    } else if ([object isKindOfClass:[NSNumber class]]) {
        
        NSString *boolStr = [NSString stringWithFormat:@"%@",object];
        return boolStr.boolValue;
        
    } else if (object == [NSNull null]) {
        
        return YES;
    }
    return NO ;
}

//


/**
 根据时间字符串转换为目标时间格式

 @param timeStr 时间字符串
 @return 目标时间格式
 */
+ (NSString *)transTimeString:(NSString *)timeStr {
    
    NSString* newTimeStr = [timeStr substringWithRange:NSMakeRange(6, timeStr.length-13)];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[newTimeStr doubleValue]/1000.0];
    NSDateFormatter* format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *orderTime = [format stringFromDate:date];
    return orderTime;
    
}


@end
