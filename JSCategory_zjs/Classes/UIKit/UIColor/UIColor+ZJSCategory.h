//
//  UIColor+ZJSCategory.h
//  FBSnapshotTestCase
//
//  Created by zjsHouse on 2019/5/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZJSCategory)
/**
 获取相应的 HEX 组成的颜色对象
 
 @param hexString HEX: 例如: @"0xF0F", @"66ccff", @"#66CCFF88"
 */
+ (nullable UIColor *)zjs_colorWithHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
