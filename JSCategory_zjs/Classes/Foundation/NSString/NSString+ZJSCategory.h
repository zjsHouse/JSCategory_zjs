//
//  NSString+ZJSCategory.h
//  Pods-ZJSCategory_Example
//
//  Created by zjsHouse on 2019/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZJSCategory)
//是否1开头的11位手机号
- (BOOL)js_validatePhoneNO;
//是否纯数字额字符串
- (BOOL)js_validatePureDigitalWithCapacity:(NSInteger)capacity;

//邮箱格式验证
- (BOOL)js_validateEmail;

//nsDate格式化 yyyy-MM-dd HH:mm:ss
- (NSString *)js_stringFromDate:(NSDate *)date;
/**
 修剪头部和尾部的空白字符（空格和换行符）
 */
- (NSString *)js_stringByTrim;
@end

NS_ASSUME_NONNULL_END
