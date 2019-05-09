//
//  NSObject+JSKVO.m
//  JSCategory_zjs
//
//  Created by zjsHouse on 2019/5/8.
//

#import "NSObject+JSKVO.h"
#import <objc/runtime.h>

static const char listenedObjKVO;

@interface  JSKVOTarget  :NSObject

@property(nonatomic,copy) JSKVOBlock  block;

- (id)initWithBlock:(JSKVOBlock)block;
@end


@interface  JSKVO  :NSObject

//被监听的对象
@property (strong, nonatomic) id listenedObj;
//{@"keipath"=>JSKVOTarget}
@property (strong, nonatomic) NSDictionary *keyPathPointBlocks;

+ (instancetype)KVOWithListenedObj:(id)listenedObj
                           keyPath:(NSString *)keyPath
                             block:(JSKVOBlock)block;

@end

@implementation JSKVOTarget

-(id)initWithBlock:(JSKVOBlock)block{
    self = [super init];
    if (self) {
        self.block = block;
    }
    return self;
}

@end


@implementation JSKVO

+ (instancetype)KVOWithListenedObj:(id)listenedObj
                           keyPath:(NSString *)keyPath
                             block:(JSKVOBlock)block {
    JSKVO *kvo = [[JSKVO alloc] init];
    kvo.listenedObj = listenedObj;
    
    JSKVOTarget *target = [[JSKVOTarget alloc] initWithBlock:block];
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] init];
    [tmp setObject:target forKey:keyPath];
    kvo.keyPathPointBlocks = [NSDictionary dictionaryWithDictionary:tmp];
    return kvo;
}

@end

#pragma mark - NSObject (JSKVO)
@implementation NSObject (JSKVO)


- (void)listenObj:(id)obj keyPath:(NSString *)path response:(JSKVOBlock)listenRepose{
    
    JSKVO *kvo = [self getKVOWithlistenedObj:obj];
    
    if (kvo) {
        //已经添加的keypath不重复添加
        JSKVOTarget *target = [kvo.keyPathPointBlocks objectForKey:path];
        if (target) {
            return;
        }
    }
    
    if (!kvo) {
        kvo = [JSKVO KVOWithListenedObj:obj keyPath:path block:listenRepose];
    }
    
    //将block添加到target中用于添加到dictionary
    JSKVOTarget *target = [[JSKVOTarget alloc] initWithBlock:listenRepose];
    
    NSMutableDictionary *tmp = [[NSMutableDictionary alloc] initWithDictionary:kvo.keyPathPointBlocks];
    [tmp setValue:target forKey:path];
    
    //将keypath＝》target字典保存在KVO对象中
    kvo.keyPathPointBlocks = [NSDictionary dictionaryWithDictionary:tmp];
    
    //KVO保存到关联的数组中
    [self saveKVO:kvo];
    //执行KVO
    [self executeKVOWithObj:obj keyPath:path];
}

- (void)unListenAll {
    NSArray *array = objc_getAssociatedObject(self, &listenedObjKVO);
    if (!array) {
        return;
    }
    for (JSKVO *kvo in array) {
        [self unListenObj:kvo.listenedObj keyPath:nil];
    }
    
    
    
    
}

- (void)unListenObj:(id)obj keyPath:(NSString *)keyPath{
    NSArray *array = objc_getAssociatedObject(self, &listenedObjKVO);
    if (!array) {
        return;
    }
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:array];
    for (JSKVO *kvo in tmp) {
        if (kvo.listenedObj == obj) {
            
            NSMutableDictionary *tmpKeyPathPointBlocks = [NSMutableDictionary dictionaryWithDictionary:kvo.keyPathPointBlocks];
            
            if (keyPath) {
                //从队列中删除target
                [tmpKeyPathPointBlocks removeObjectForKey:keyPath];
                //删除keyPath的监听
                [kvo.listenedObj removeObserver:self forKeyPath:keyPath];
            } else {
                //keyPath==nil 移除所有这个对象监听
                NSArray *paths = [tmpKeyPathPointBlocks allKeys];
                for (NSString *path in paths) {
                    //删除Path的监听
                    [kvo.listenedObj removeObserver:self forKeyPath:path];
                }
                //从队列中删除所有target
                [tmpKeyPathPointBlocks removeAllObjects];
            }
            
            
            //当对象没有keyPath被监听时删除KVO对象
            if (tmpKeyPathPointBlocks.count == 0) [tmp removeObject:kvo];
            
            break;
        }
    }
    
    //当被清空时直接取消关联
    if (tmp.count==0) {
        objc_setAssociatedObject(self, &listenedObjKVO, nil, OBJC_ASSOCIATION_ASSIGN);
    } else {
        objc_setAssociatedObject(self, &listenedObjKVO, [NSArray arrayWithArray:tmp], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}




#pragma mark - private

- (JSKVO *)getKVOWithlistenedObj:(id)obj{
    NSArray *array = objc_getAssociatedObject(self, &listenedObjKVO);
    if (!array) {
        array = [NSArray array];
        objc_setAssociatedObject(self, &listenedObjKVO, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return nil;
    }
    
    for (JSKVO *kvo in array) {
        if (kvo.listenedObj == obj) {
            return kvo;
        }
    }
    return nil;
}

- (void)saveKVO:(JSKVO *)kvo{
    NSArray *array = objc_getAssociatedObject(self, &listenedObjKVO);
    //已经存在不需要重复添加
    if ([array containsObject:kvo]) {
        return;
    }
    
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:array];
    [tmp addObject:kvo];
    array = [NSArray arrayWithArray:tmp];
    objc_setAssociatedObject(self, &listenedObjKVO, array, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


#pragma mark - observer
//开始监听
- (void)executeKVOWithObj:(id)obj keyPath:(NSString *)keyPath{
    [obj addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

//监听返回
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    id new = [change objectForKey:@"new"];
    id old = [change objectForKey:@"old"];
    
    JSKVO *kvo = [self getKVOWithlistenedObj:object];
    JSKVOTarget *target = [kvo.keyPathPointBlocks objectForKey:keyPath];
    if (target) {
        target.block(old, new);
    }
    
}


@end
