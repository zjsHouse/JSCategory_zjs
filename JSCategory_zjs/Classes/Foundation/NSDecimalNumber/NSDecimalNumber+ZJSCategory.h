//
//  NSDecimalNumber+ZJSCategory.h
//  Pods-ZJSCategory_Example
//
//  Created by zjsHouse on 2019/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, calculationType) {
Add,
Subtract,
Multiply,
Divide
};
@interface NSDecimalNumber (ZJSCategory)

+(NSDecimalNumber *)aDecimalNumberWithStringOrNumberOrDecimalNumber:(id)stringOrNumber1 type:(calculationType)type anotherDecimalNumberWithStringOrNumberOrDecimalNumber:(id)stringOrNumber2 andDecimalNumberHandler:(NSDecimalNumberHandler *)handler;

+(NSComparisonResult)aDecimalNumberWithStringOrNumberOrDecimalNumber:(id)stringOrNumber1 compareAnotherDecimalNumberWithStringOrNumberOrDecimalNumber:(id)stringOrNumber2;
+(NSString *)stringWithDecimalNumber:(NSDecimalNumber *)str1 scale:(NSInteger)scale;

extern NSComparisonResult StrNumCompare(id str1,id str2);

extern NSDecimalNumber *handlerDecimalNumber(id strOrNum,NSRoundingMode mode,int scale);


extern NSComparisonResult SNCompare(id strOrNum1,id strOrNum2);


extern NSDecimalNumber *SNAdd(id strOrNum1,id strOrNum2);
extern NSDecimalNumber *SNSub(id strOrNum1,id strOrNum2);
extern NSDecimalNumber *SNMul(id strOrNum1,id strOrNum2);
extern NSDecimalNumber *SNDiv(id strOrNum1,id strOrNum2);


extern NSDecimalNumber *SNMin(id strOrNum1,id strOrNum2);
extern NSDecimalNumber *SNMax(id strOrNum1,id strOrNum2);


extern NSDecimalNumber *SNAdd_handler(id strOrNum1,id strOrNum2,NSRoundingMode mode,int scale);
extern NSDecimalNumber *SNSub_handler(id strOrNum1,id strOrNum2,NSRoundingMode mode,int scale);
extern NSDecimalNumber *SNMul_handler(id strOrNum1,id strOrNum2,NSRoundingMode mode,int scale);
extern NSDecimalNumber *SNDiv_handler(id strOrNum1,id strOrNum2,NSRoundingMode mode,int scale);


extern NSDecimalNumber *SNMin_handler(id strOrNum1,id strOrNum2,NSRoundingMode mode,int scale);
extern NSDecimalNumber *SNMax_handler(id strOrNum1,id strOrNum2,NSRoundingMode mode,int scale);
@end

NS_ASSUME_NONNULL_END
