//
//  MessageThrottle.m
//  OCStudy
//
//  Created by hicodeboy on 2021/3/16.
//

#import "MessageThrottle.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <pthread.h>
#import <UIKit/UIKit.h>


static inline BOOL bm_object_isClass(id _Nullable obj) {
    if (!obj) return NO;
    return object_isClass(obj);
}

Class bm_metaClass(Class cls) {
    if (class_isMetaClass(cls)) {
        return cls;
    }
    return object_getClass(cls);
}

enum {
    BLOCK_HAS_COPY_DISPOSE =  (1 << 25),
    BLOCK_HAS_CTOR =          (1 << 26), // helpers have C++ code
    BLOCK_IS_GLOBAL =         (1 << 28),
    BLOCK_HAS_STRET =         (1 << 29), // IFF BLOCK_HAS_SIGNATURE
    BLOCK_HAS_SIGNATURE =     (1 << 30),
};

struct _BMBlockDescriptor {
    unsigned long reserved;;
    unsigned long size;
    void *rest[1];
};

struct _BMBlock {
    void *isa;
    int flags;
    int reserved;
    void *invoke;
    struct _BMBlockDescriptor *descriptor;
};

static const char * mt_blockMethodSignature(id blockObj) {
    struct _BMBlock *block = (__bridge void *)blockObj;
    struct _BMBlockDescriptor *descriptor = block->descriptor;
    assert(block->flags & BLOCK_HAS_SIGNATURE);
    int index = 0;
    if (block->flags & BLOCK_HAS_COPY_DISPOSE) {
        index += 2;
    }
    return descriptor->rest[index];
}


@interface MessageThrottle()
@property (nonatomic, strong) NSObject *flag;
@property (nonatomic, strong) NSDate *lastTime;

@end

@implementation MessageThrottle

- (instancetype)init {
    self = [super init];
    if (self) {
        _lastTime = [[NSDate alloc] init];
    }
    return self;
}


- (void)throttle:(ThrottleBlock)throttle mode:(ThrottleMode)mode{
    NSObject *flag = [[NSObject alloc] init];
    __weak typeof(self) weakSelf = self;
    
    weakSelf.flag = flag;
    NSDate *newDate = [[NSDate alloc] init];
    
    if (mode == ThrottleModeBefore) {
        NSInteger delay = weakSelf.lastTime.timeIntervalSince1970 - newDate.timeIntervalSince1970;
        
        if (delay < -1) {
            weakSelf.lastTime = [[NSDate alloc] init];
            throttle();
        }
    } else {
        NSInteger delay = newDate.timeIntervalSince1970 - weakSelf.lastTime.timeIntervalSince1970;
        if (delay > 1) {
            weakSelf.lastTime = [[NSDate alloc] init];
            throttle();
        }
    }
    
}

@end


@interface MessageDebounce()
@property (nonatomic, strong) NSObject *flag;
@end

@implementation MessageDebounce

- (void)debounce:(DebounceBlock)debounce {
    NSObject *flag = [[NSObject alloc] init];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.flag = flag;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            if (flag == weakSelf.flag) {
                debounce();
            }
        });
        
    });
}

@end
