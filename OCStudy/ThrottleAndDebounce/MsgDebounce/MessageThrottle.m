//
//  MessageThrottle.m
//  OCStudy
//
//  Created by dujia on 2021/3/16.
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




@implementation MessageThrottle

+ (void)startTest {
    
}

@end