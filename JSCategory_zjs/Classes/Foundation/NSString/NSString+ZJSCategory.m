//
//  NSString+ZJSCategory.m
//  Pods-ZJSCategory_Example
//
//  Created by zjsHouse on 2019/4/24.
//

#import "NSString+ZJSCategory.h"

@implementation NSString (ZJSCategory)
//是否1开头的11位手机号
- (BOOL)js_validatePhoneNO{
    NSString * predicateFormat = @"^1\\d{10}";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateFormat];
    
    return [predicate evaluateWithObject:self];
    
}

//是否纯数字额字符串
- (BOOL)js_validatePureDigitalWithCapacity:(NSInteger)capacity{
    NSString * predicateFormat = [NSString stringWithFormat:@"^[0-9]{%ld}", (long)capacity];
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicateFormat];
    
    return [predicate evaluateWithObject:self];
}

//邮箱格式验证
- (BOOL)js_validateEmail{
    NSString * emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z0-9.-]{2,6}";
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [predicate evaluateWithObject:self];
}

//nsDate格式化 yyyy-MM-dd HH:mm:ss
- (NSString *)js_stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
/**
 修剪头部和尾部的空白字符（空格和换行符）
 */
- (NSString *)js_stringByTrim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    return [self stringByTrimmingCharactersInSet:set];
}
@end
