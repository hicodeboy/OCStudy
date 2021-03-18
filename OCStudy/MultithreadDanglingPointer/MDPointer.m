//
//  MDPointer.m
//  OCStudy
//
//  Created by dujia on 2021/3/8.
//

#import "MDPointer.h"
#import <objc/runtime.h>

@interface MDPointer()
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSLock *lock;
@end

static dispatch_queue_t initQueue;
static void* initQueueKey;
static void* initQueueContext;


@implementation MDPointer


+ (void) load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            initQueue = dispatch_get_main_queue();
            initQueueKey = @"mainQueue";
            initQueueContext = @"mainQueueContext";
            dispatch_queue_set_specific(initQueue, initQueueKey, initQueueContext, nil);
        } else {
            const char *label = [NSStringFromSelector(_cmd) UTF8String];
            initQueueKey = &initQueueKey;
            initQueueContext = &initQueueContext;
            initQueue = dispatch_queue_create(label, nil);
            dispatch_queue_set_specific(initQueue, initQueueKey, initQueueContext, nil);
        }
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


- (instancetype)init {
    self = [super init];
    if (self) {
        _lock = [[NSLock alloc] init];
        
        
        
        
    }
    return self;
}

- (void)mdTest1 {
    __weak typeof(self) weakSelf = self;
    for (int i = 0; i < 1; i++) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [weakSelf.lock lock];
            self.data = [[NSMutableData alloc] init];
//            [weakSelf.lock unlock];
        });
    }
}

- (void)setData:(NSMutableData *)data {
    _data = data;
    
}


- (void)mdTest2 {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if ([NSThread isMainThread]) {
            initQueue = dispatch_get_main_queue();
            initQueueKey = @"mainQueue";
            initQueueContext = @"mainQueueContext";
            dispatch_queue_set_specific(initQueue, initQueueKey, initQueueContext, nil);
            
        } else {
            const char *label = [NSStringFromSelector(_cmd) UTF8String];
            initQueueKey = &initQueueKey;
            initQueueContext = &initQueueContext;
            initQueue = dispatch_queue_create(label, nil);
            dispatch_queue_set_specific(initQueue, initQueueKey, initQueueContext, nil);
        }

        
    });
    
    
    
//    void* context =  dispatch_queue_get_specific(initQueue, initQueueKey);
    
//    NSLog(@"%@  %@", initQueueKey, initQueueContext);
    
}

- (void)mdTest3 {
    
    void* context = dispatch_queue_get_specific(initQueue, initQueueKey);
    
    
    
    if (context == initQueueContext) {
        NSLog(@"同一个队列");
    } else {
        NSLog(@"不在当前队列");
    }
}

// 1 主线程只会执行主队列吗？
- (void)quest1 {
    
    NSLog(@"main thread %d", [NSThread isMainThread]);
    const char *label = [@"hello" UTF8String];
    initQueueKey = &initQueueKey;
    initQueueContext = &initQueueContext;
    initQueue = dispatch_queue_create(label, nil);
    dispatch_queue_set_specific(initQueue, initQueueKey, initQueueContext, nil);
    NSLog(@"main queue: initQueueKey = %@ ", dispatch_get_specific(initQueueKey));
    
}



- (void)hookAllPropertiesSetter {
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *readWritedProperties = [[NSMutableArray alloc] init];
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        unsigned int attrCount;
        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
        
        BOOL isReadOnlyProperty = NO;
        for (unsigned int j = 0; j < attrCount; j++) {
            if (attrs[j].name[0] == 'R') {
                isReadOnlyProperty = YES;
                break;
            }
        }
        free(attrs);
        if (!isReadOnlyProperty) {
            [readWritedProperties addObject:propertyName];
        }
    }
    free(properties);
    
    for (NSString *propertyName in readWritedProperties) {
        NSLog(@"%@",  [propertyName substringFromIndex:1]);
        
        NSString *setterName = [NSString stringWithFormat:@"set%@%@:", [propertyName substringToIndex:1].uppercaseString, [propertyName substringFromIndex:1]];
        
        NSString *hookSetterName = [NSString stringWithFormat:@"hook_set%@:", propertyName];
        SEL originSetter = NSSelectorFromString(setterName);
        SEL newSetter = NSSelectorFromString(hookSetterName);
        swizzleMethod([self class], originSetter, newSetter);
        
    }
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selName = NSStringFromSelector(sel);
    if ([selName hasPrefix:@"hook_"]) {
        Method proxyMethod = class_getInstanceMethod([self class], @selector(hook_proxy:));
        class_addMethod([self class], sel, method_getImplementation(proxyMethod), method_getTypeEncoding(proxyMethod));
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}


- (void)hook_proxy:(NSObject *)proxyObject {
    NSLog(@"hook_proxy");
    NSString *originalSelector = NSStringFromSelector(_cmd);
    NSString *propertyName = [[originalSelector stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]] stringByReplacingOccurrencesOfString:@"set" withString:@""];
    if (propertyName.length <= 0) return;
    NSString *ivarName = [NSString stringWithFormat:@"_%@%@", [propertyName substringToIndex:1].lowercaseString, [propertyName substringFromIndex:1]];
    
    NSLog(@"hook_proxy is %@ for property %@", proxyObject, propertyName);
    
}



@end
