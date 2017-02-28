//
//  NSString+HYString.h
//  HYiTong
//
//  Created by David on 2016/12/30.
//  Copyright © 2016年 com.HROCLoud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HYString)

+ (instancetype)safeStringWithObject:(id)object;

+ (instancetype)transTimeString:(NSString *)timeStr;

@end
