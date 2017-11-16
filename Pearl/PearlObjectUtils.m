/**
 * Copyright Maarten Billemont (http://www.lhunath.com, lhunath@lyndir.com)
 *
 * See the enclosed file LICENSE for license information (LGPLv3). If you did
 * not receive this file, see http://www.gnu.org/licenses/lgpl-3.0.txt
 *
 * @author   Maarten Billemont <lhunath@lyndir.com>
 * @license  http://www.gnu.org/licenses/lgpl-3.0.txt
 */

//
//  ObjectUtils.m
//  RedButton
//
//  Created by Maarten Billemont on 08/11/10.
//  Copyright 2010 Lyndir. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import "PearlObjectUtils.h"
#import "PearlStringUtils.h"

BOOL PearlMainQueue(void (^block)()) {

    if ([NSThread isMainThread]) {
        block();
        return YES;
    }

    dispatch_async( dispatch_get_main_queue(), block );
    return NO;
}

BOOL PearlNotMainQueue(void (^block)()) {

    if (![NSThread isMainThread]) {
        block();
        return YES;
    }

    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), block );
    return NO;
}

NSBlockOperation *PearlMainQueueOperation(void (^block)()) {

    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:block];
    [[NSOperationQueue mainQueue] addOperation:blockOperation];
    return blockOperation;
}

NSBlockOperation *PearlNotMainQueueOperation(void (^block)()) {

    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:block];
    NSOperationQueue *queue = [NSOperationQueue currentQueue];
    if (!queue || queue == [NSOperationQueue mainQueue])
        queue = [NSOperationQueue new];
    [queue addOperation:blockOperation];
    return blockOperation;
}

id PearlAwait(void (^block)(void (^setResult)(id result))) {

    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter( group );
    __block id result = nil;
    block( ^(id result_) {
        @try {
            result = result_;
        }
        @finally {
            dispatch_group_leave( group );
        }
    } );
    dispatch_group_wait( group, DISPATCH_TIME_FOREVER );

    return result;
}

id PearlMainQueueAwait(id (^block)()) {

    if ([NSThread isMainThread])
        return block();

    __block id result = nil;
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter( group );
    dispatch_async( dispatch_get_main_queue(), ^{
        @try {
            result = block();
        }
        @finally {
            dispatch_group_leave( group );
        }
    } );
    dispatch_group_wait( group, DISPATCH_TIME_FOREVER );

    return result;
}

BOOL PearlMainQueueWait(void (^block)()) {

    if ([NSThread isMainThread]) {
        block();
        return YES;
    }

    dispatch_group_t waitGroup = dispatch_group_create();
    dispatch_group_enter( waitGroup );
    dispatch_async( dispatch_get_main_queue(), ^{
        @try {
            block();
        }
        @finally {
            dispatch_group_leave( waitGroup );
        }
    } );
    dispatch_group_wait( waitGroup, DISPATCH_TIME_FOREVER );
    return NO;
}

BOOL PearlNotMainQueueWait(void (^block)()) {

    if (![NSThread isMainThread]) {
        block();
        return YES;
    }

    dispatch_group_t waitGroup = dispatch_group_create();
    dispatch_group_enter( waitGroup );
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^{
        @try {
            block();
        }
        @finally {
            dispatch_group_leave( waitGroup );
        }
    } );
    dispatch_group_wait( waitGroup, DISPATCH_TIME_FOREVER );
    return NO;
}

void PearlMainQueueAfter(NSTimeInterval seconds, void (^block)()) {

    return PearlQueueAfter( seconds, dispatch_get_main_queue(), block );
}

void PearlGlobalQueueAfter(NSTimeInterval seconds, void (^block)()) {

    PearlQueueAfter( seconds, dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), block );
}

void PearlQueueAfter(NSTimeInterval seconds, dispatch_queue_t queue, void (^block)()) {

    dispatch_after( dispatch_time( DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC) ), queue, block );
}

BOOL PearlIfNotRecursing(BOOL *recursing, void(^notRecursingBlock)()) {

    if (*recursing)
        return NO;

    *recursing = YES;
    notRecursingBlock();
    *recursing = NO;
    return YES;
}

NSUInteger PearlHashCode(NSUInteger firstHashCode, ...) {

    va_list objs;
    va_start( objs, firstHashCode );
    NSUInteger hashCode = 0;
    for (NSUInteger nextHashCode = firstHashCode; nextHashCode != (NSUInteger)-1; nextHashCode = va_arg( objs, NSUInteger ))
        hashCode = hashCode * 31 + nextHashCode;
    return hashCode;
}

@implementation PearlWeakReference

+ (instancetype)referenceWithObject:(id)object {

    PearlWeakReference *holder = [self new];
    holder.object = object;
    return holder;
}

- (BOOL)isEqual:(id)other {

    return [self.object isEqual:other];
}

- (NSUInteger)hash {

    return [self.object hash];
}

@end

@implementation NSObject(PearlObjectUtils)

- (NSString *)propertyWithValue:(id)value {

    NSString *propertyName = nil;
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList( [self class], &count );
    for (unsigned int p = 0; p < count; ++p) {
        NSString *currentPropertyName = strf( @"%s", property_getName( properties[p] ) );
        if ([self valueForKey:currentPropertyName] == value) {
            propertyName = currentPropertyName;
            break;
        }
    }
    free( properties );

    return propertyName;
}

- (void)setStrongAssociatedObject:(id)object forSelector:(SEL)sel {

    objc_setAssociatedObject( self, sel, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}

- (void)setWeakAssociatedObject:(id)object forSelector:(SEL)sel {

    [self setStrongAssociatedObject:[PearlWeakReference referenceWithObject:object] forSelector:sel];
}

- (id)getAssociatedObjectForSelector:(SEL)sel {

    id object = objc_getAssociatedObject( self, sel );
    return [object isKindOfClass:[PearlWeakReference class]]? ((PearlWeakReference *)object).object: object;
}

@end
