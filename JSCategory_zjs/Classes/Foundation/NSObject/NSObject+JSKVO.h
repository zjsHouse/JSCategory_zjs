//
//  NSObject+JSKVO.h
//  JSCategory_zjs
//
//  Created by zjsHouse on 2019/5/8.
//

#import <Foundation/Foundation.h>



//NS_ASSUME_NONNULL_BEGIN
typedef void(^JSKVOBlock)(id oldValue,id newValue);
@interface NSObject (JSKVO)


/**
 *  对象监听
 *
 *  @param obj          被监听的对象
 *  @param path         路径
 *  @param listenRepose 返回的block
 */
- (void)listenObj:(id)obj keyPath:(NSString *)path response:(JSKVOBlock)listenRepose;

/**
 *  取消监听
 *
 *  @param obj     被监听的对象
 *  @param keyPath 路径
 */
- (void)unListenObj:(id)obj keyPath:(NSString *)keyPath;

/**
 *  取消所有监听
 */
- (void)unListenAll;

@end

//NS_ASSUME_NONNULL_END
