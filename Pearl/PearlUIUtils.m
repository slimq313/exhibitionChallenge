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
//  PearlUIUtils.m
//  Pearl
//
//  Created by Maarten Billemont on 29/10/10.
//  Copyright 2010, lhunath (Maarten Billemont). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PearlUIUtils.h"
#import "PearlObjectUtils.h"
#import "PearlStringUtils.h"

CGRect CGRectWithX(CGRect rect, CGFloat x) {

    return (CGRect){ { x, rect.origin.y }, { rect.size.width, rect.size.height } };
}

CGRect CGRectWithY(CGRect rect, CGFloat y) {

    return (CGRect){ { rect.origin.x, y }, { rect.size.width, rect.size.height } };
}

CGRect CGRectWithWidth(CGRect rect, CGFloat width) {

    return (CGRect){ rect.origin, { width, rect.size.height } };
}

CGRect CGRectWithHeight(CGRect rect, CGFloat height) {

    return (CGRect){ rect.origin, { rect.size.width, height } };
}

CGRect CGRectWithOrigin(CGRect rect, CGPoint origin) {

    return (CGRect){ origin, rect.size };
}

CGRect CGRectWithSize(CGRect rect, CGSize size) {

    return (CGRect){ rect.origin, size };
}

CGPoint CGRectGetCenter(CGRect rect) {

    return CGPointMake( rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2 );
}

CGPoint CGRectGetTop(CGRect rect) {

    return CGPointMake( rect.origin.x + rect.size.width / 2, rect.origin.y );
}

CGPoint CGRectGetRight(CGRect rect) {

    return CGPointMake( rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2 );
}

CGPoint CGRectGetBottom(CGRect rect) {

    return CGPointMake( rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height );
}

CGPoint CGRectGetLeft(CGRect rect) {

    return CGPointMake( rect.origin.x, rect.origin.y + rect.size.height / 2 );
}

CGPoint CGRectGetTopLeft(CGRect rect) {

    return CGPointMake( rect.origin.x, rect.origin.y );
}

CGPoint CGRectGetTopRight(CGRect rect) {

    return CGPointMake( rect.origin.x + rect.size.width, rect.origin.y );
}

CGPoint CGRectGetBottomRight(CGRect rect) {

    return CGPointMake( rect.origin.x + rect.size.width, rect.origin.y + rect.size.height );
}

CGPoint CGRectGetBottomLeft(CGRect rect) {

    return CGPointMake( rect.origin.x, rect.origin.y + rect.size.height );
}

CGRect CGRectWithCenter(CGRect rect, CGPoint newCenter) {

    return CGRectFromCenterWithSize( newCenter, rect.size );
}

CGRect CGRectWithTop(CGRect rect, CGPoint newTop) {

    return CGRectFromCenterWithSize( CGPointMake( newTop.x, newTop.y + rect.size.height / 2 ), rect.size );
}

CGRect CGRectWithRight(CGRect rect, CGPoint newRight) {

    return CGRectFromCenterWithSize( CGPointMake( newRight.x - rect.size.width / 2, newRight.y ), rect.size );
}

CGRect CGRectWithBottom(CGRect rect, CGPoint newBottom) {

    return CGRectFromCenterWithSize( CGPointMake( newBottom.x, newBottom.y - rect.size.height / 2 ), rect.size );
}

CGRect CGRectWithLeft(CGRect rect, CGPoint newLeft) {

    return CGRectFromCenterWithSize( CGPointMake( newLeft.x + rect.size.width / 2, newLeft.y ), rect.size );
}

CGRect CGRectWithTopLeft(CGRect rect, CGPoint newTopLeft) {

    return CGRectFromOriginWithSize( newTopLeft, rect.size );
}

CGRect CGRectWithTopRight(CGRect rect, CGPoint newTopRight) {

    return CGRectFromOriginWithSize( CGPointMake( newTopRight.x - rect.size.width, newTopRight.y ), rect.size );
}

CGRect CGRectWithBottomRight(CGRect rect, CGPoint newBottomRight) {

    return CGRectFromOriginWithSize( CGPointMake( newBottomRight.x - rect.size.width, newBottomRight.y - rect.size.height ), rect.size );
}

CGRect CGRectWithBottomLeft(CGRect rect, CGPoint newBottomLeft) {

    return CGRectFromOriginWithSize( CGPointMake( newBottomLeft.x, newBottomLeft.y - rect.size.height ), rect.size );
}

UIEdgeInsets UIEdgeInsetsUnionEdgeInsets(UIEdgeInsets a, UIEdgeInsets b) {

    return UIEdgeInsetsMake( MAX( a.top, b.top ), MAX( a.left, b.left ), MAX( a.bottom, b.bottom ), MAX( a.right, b.right ) );
}

UIEdgeInsets UIEdgeInsetsForRectSubtractingRect(CGRect insetRect, CGRect subtractRect) {

    if (!CGRectIntersectsRect( insetRect, subtractRect ))
        return UIEdgeInsetsZero;

    CGPoint topLeftBounds = CGRectGetTopLeft( insetRect );
    CGPoint bottomRightBounds = CGRectGetBottomRight( insetRect );
    CGPoint topLeftFrom = CGRectGetTopLeft( subtractRect );
    CGPoint bottomRightFrom = CGRectGetBottomRight( subtractRect );
    CGPoint topLeftInset = CGPointMinusCGPoint( bottomRightFrom, topLeftBounds );
    CGPoint bottomRightInset = CGPointMinusCGPoint( bottomRightBounds, topLeftFrom );

    CGFloat top = topLeftFrom.y <= insetRect.origin.y && bottomRightFrom.y < insetRect.size.height? MAX( 0, topLeftInset.y ): 0;
    CGFloat left = topLeftFrom.x <= insetRect.origin.x && bottomRightFrom.x < insetRect.size.width? MAX( 0, topLeftInset.x ): 0;
    CGFloat bottom = topLeftFrom.y > insetRect.origin.y && bottomRightFrom.y >= insetRect.size.height? MAX( 0, bottomRightInset.y ): 0;
    CGFloat right = topLeftFrom.x > insetRect.origin.y && bottomRightFrom.x >= insetRect.size.width? MAX( 0, bottomRightInset.x ): 0;

    return UIEdgeInsetsMake( top, left, bottom, right );
}

UIViewAnimationOptions UIViewAnimationCurveToOptions(UIViewAnimationCurve curve) {

    NSCAssert( UIViewAnimationCurveLinear << 16 == UIViewAnimationOptionCurveLinear, @"Unexpected implementation of UIViewAnimationCurve" );
    return (UIViewAnimationOptions)(curve << 16);;
}

CGPoint CGPointFromCGSize(const CGSize size) {

    return CGPointMake( size.width, size.height );
}

CGPoint CGPointFromCGSizeCenter(const CGSize size) {

    return CGPointMake( size.width / 2, size.height / 2 );
}

CGSize CGSizeFromCGPoint(const CGPoint point) {

    return CGSizeMake( point.x, point.y );
}

CGRect CGRectFromOriginWithSize(const CGPoint origin, const CGSize size) {

    return CGRectMake( origin.x, origin.y, size.width, size.height );
}

CGRect CGRectFromCenterWithSize(const CGPoint center, const CGSize size) {

    return CGRectMake( center.x - size.width / 2, center.y - size.height / 2, size.width, size.height );
}

CGRect CGRectInCGRectWithSizeAndPadding(const CGRect parent, CGSize size, CGFloat top, CGFloat right, CGFloat bottom, CGFloat left) {

    if (size.width == CGFLOAT_MAX) {
        if (left == CGFLOAT_MAX && right == CGFLOAT_MAX)
            left = right = size.width = parent.size.width / 3;
        else if (left == CGFLOAT_MAX)
            left = size.width = (parent.size.width - right) / 2;
        else if (right == CGFLOAT_MAX)
            right = size.width = (parent.size.width - left) / 2;
        else
            size.width = parent.size.width - left - right;
    }
    if (size.height == CGFLOAT_MAX) {
        if (top == CGFLOAT_MAX && bottom == CGFLOAT_MAX)
            top = bottom = size.height = parent.size.height / 3;
        else if (top == CGFLOAT_MAX)
            top = size.height = (parent.size.height - bottom) / 2;
        else if (bottom == CGFLOAT_MAX)
            bottom = size.height = (parent.size.height - top) / 2;
        else
            size.height = parent.size.height - top - bottom;
    }
    if (top == CGFLOAT_MAX) {
        if (bottom == CGFLOAT_MAX)
            top = (parent.size.height - size.height) / 2;
        else
            top = parent.size.height - size.height - bottom;
    }
    if (left == CGFLOAT_MAX) {
        if (right == CGFLOAT_MAX)
            left = (parent.size.width - size.width) / 2;
        else
            left = parent.size.width - size.width - right;
    }

    return CGRectFromOriginWithSize( CGPointMake( left, top ), size );
}

CGPoint CGPointMinusCGPoint(const CGPoint origin, const CGPoint subtract) {

    return CGPointMake( origin.x - subtract.x, origin.y - subtract.y );
}

CGPoint CGPointPlusCGPoint(const CGPoint origin, const CGPoint add) {

    return CGPointMake( origin.x + add.x, origin.y + add.y );
}

CGPoint CGPointMultiply(const CGPoint origin, const CGFloat multiply) {

    return CGPointMake( origin.x * multiply, origin.y * multiply );
}

CGPoint CGPointMultiplyCGPoint(const CGPoint origin, const CGPoint multiply) {

    return CGPointMake( origin.x * multiply.x, origin.y * multiply.y );
}

CGPoint CGPointDistanceBetweenCGPoints(CGPoint from, CGPoint to) {

    return CGPointMinusCGPoint( to, from );
}

CGFloat DistanceBetweenCGPointsSq(CGPoint from, CGPoint to) {

    return (CGFloat)(pow( to.x - from.x, 2 ) + pow( to.y - from.y, 2 ));
}

CGFloat DistanceBetweenCGPoints(CGPoint from, CGPoint to) {

    return (CGFloat)sqrt( DistanceBetweenCGPointsSq( from, to ) );
}

@interface PearlUIUtilsKeyboardScrollView : NSObject

@property(nonatomic, retain) UIScrollView *keyboardScrollView;
@property(nonatomic) CGPoint keyboardScrollViewOriginalOffset;
@property(nonatomic) CGRect keyboardScrollViewOriginalFrame;

@end

@implementation PearlUIUtilsKeyboardScrollView

@synthesize keyboardScrollView = _keyboardScrollView;
@synthesize keyboardScrollViewOriginalOffset = _keyboardScrollViewOriginalOffset;
@synthesize keyboardScrollViewOriginalFrame = _keyboardScrollViewOriginalFrame;

- (id)init {

    if (!(self = [super init])) {
        return nil;
    }

    self.keyboardScrollViewOriginalFrame = CGRectNull;
    self.keyboardScrollViewOriginalOffset = CGPointZero;

    return self;
}

@end

@implementation UIView(PearlUIUtils)

- (NSArray *)addConstraintsWithVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)opts
                                    metrics:(NSDictionary *)metrics views:(NSDictionary *)views {

    return [self addConstraintsWithVisualFormats:@[ format ] options:opts metrics:metrics views:views];
}

- (NSArray *)addConstraintsWithVisualFormats:(NSArray *)formats options:(NSLayoutFormatOptions)opts
                                     metrics:(NSDictionary *)metrics views:(NSDictionary *)views {

    NSMutableArray *constraints = [NSMutableArray new];
    for (NSString *format in formats)
        [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:format options:opts metrics:metrics views:views]];
    [self addConstraints:constraints];

    return constraints;
}

- (NSArray *)applicableConstraints {

    NSMutableArray *applicableConstraints = [NSMutableArray new];
    for (UIView *constraintHolder = self; constraintHolder; constraintHolder = [constraintHolder superview]) {
        [constraintHolder updateConstraintsIfNeeded];

        for (NSLayoutConstraint *constraint in constraintHolder.constraints)
            if (constraint.firstItem == self || constraint.secondItem == self)
                [applicableConstraints addObject:constraint];
    }

    return applicableConstraints;
}

- (NSDictionary *)applicableConstraintsByHolder {

    NSMutableDictionary *constraintsByHolder = [NSMutableDictionary new];
    for (UIView *constraintHolder = self; constraintHolder; constraintHolder = [constraintHolder superview]) {
        NSValue *holderKey = [NSValue valueWithPointer:(__bridge void *)constraintHolder];
        [constraintHolder updateConstraintsIfNeeded];

        NSMutableArray *holderConstraints = constraintsByHolder[holderKey];
        if (!holderConstraints)
            constraintsByHolder[holderKey] = holderConstraints = [NSMutableArray new];
        for (NSLayoutConstraint *constraint in constraintHolder.constraints)
            if (constraint.firstItem == self || constraint.secondItem == self) {
                [holderConstraints addObject:constraint];
            }
    }

    return constraintsByHolder;
}

- (NSLayoutConstraint *)firstConstraintForAttribute:(NSLayoutAttribute)attribute {

    return [self firstConstraintForAttribute:attribute otherView:nil];
}

- (NSLayoutConstraint *)firstConstraintForAttribute:(NSLayoutAttribute)attribute otherView:(UIView *)otherView {

    for (NSLayoutConstraint *constraint in self.applicableConstraints)
        if (((constraint.firstItem == self && constraint.firstAttribute == attribute) ||
             (constraint.secondItem == self && constraint.secondAttribute == attribute)) &&
            (!otherView || constraint.firstItem == otherView || constraint.secondItem == otherView))
            return constraint;

    return nil;
}

- (void)setFrameFromCurrentSizeAndParentPaddingTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left {

    [self setFrameFromSize:self.frame.size andParentPaddingTop:top right:right bottom:bottom left:left];
}

- (void)setFrameFrom:(NSString *)layoutString {

    [self setFrameFrom:layoutString using:(PearlLayout){}];
}

- (void)setFrameFrom:(NSString *)layoutString x:(CGFloat)x {

    [self setFrameFrom:layoutString x:x y:0 z:0 using:(PearlLayout){}];
}

- (void)setFrameFrom:(NSString *)layoutString x:(CGFloat)x y:(CGFloat)y {

    [self setFrameFrom:layoutString x:x y:y z:0 using:(PearlLayout){}];
}

- (void)setFrameFrom:(NSString *)layoutString x:(CGFloat)x y:(CGFloat)y z:(CGFloat)z {

    [self setFrameFrom:layoutString x:x y:y z:z using:(PearlLayout){}];
}

- (void)setFrameFrom:(NSString *)layoutString using:(PearlLayout)layoutOverrides {

    [self setFrameFrom:layoutString x:0 y:0 z:0 using:layoutOverrides];
}

- (void)setFrameFrom:(NSString *)layoutString x:(CGFloat)x y:(CGFloat)y z:(CGFloat)z using:(PearlLayout)layoutOverrides {

    [self setFrameFrom:layoutString x:x y:y z:z using:layoutOverrides options:(PearlLayoutOption)0];
}

- (void)setFrameFrom:(NSString *)layoutString x:(CGFloat)x y:(CGFloat)y z:(CGFloat)z using:(PearlLayout)layoutOverrides
             options:(PearlLayoutOption)options {

    static NSRegularExpression *layoutRE = nil;
    static dispatch_once_t once = 0;
    dispatch_once( &once, ^{
        layoutRE = [[NSRegularExpression alloc] initWithPattern:
                        @" *([^\\[| ]*)(?: *\\| *([^\\] ]*))? *\\[ *([\\|]*) *([^\\]\\|/ ]*)(?: */ *([^\\]\\|/ ]*))? *(?:[\\|]*) *\\] *(?:([^|]*) *\\| *)?([^,]*) *"
                                                        options:0 error:nil];
    } );

    // Parse
    NSTextCheckingResult
            *layoutComponents = [layoutRE firstMatchInString:layoutString options:0 range:NSMakeRange( 0, layoutString.length )];
    NSString *leftLayoutString = [layoutComponents rangeAtIndex:1].location == NSNotFound? nil:
                                 [layoutString substringWithRange:[layoutComponents rangeAtIndex:1]];
    NSString *topLayoutString = [layoutComponents rangeAtIndex:2].location == NSNotFound? nil:
                                [layoutString substringWithRange:[layoutComponents rangeAtIndex:2]];
    NSString *sizeLayoutString = [layoutComponents rangeAtIndex:3].location == NSNotFound? nil:
                                 [layoutString substringWithRange:[layoutComponents rangeAtIndex:3]];
    NSString *widthLayoutString = [layoutComponents rangeAtIndex:4].location == NSNotFound? nil:
                                  [layoutString substringWithRange:[layoutComponents rangeAtIndex:4]];
    NSString *heightLayoutString = [layoutComponents rangeAtIndex:5].location == NSNotFound? nil:
                                   [layoutString substringWithRange:[layoutComponents rangeAtIndex:5]];
    NSString *bottomLayoutString = [layoutComponents rangeAtIndex:6].location == NSNotFound? nil:
                                   [layoutString substringWithRange:[layoutComponents rangeAtIndex:6]];
    NSString *rightLayoutString = [layoutComponents rangeAtIndex:7].location == NSNotFound? nil:
                                  [layoutString substringWithRange:[layoutComponents rangeAtIndex:7]];
    CGFloat leftLayoutValue = [leftLayoutString floatValue], rightLayoutValue = [rightLayoutString floatValue];
    CGFloat widthLayoutValue = [widthLayoutString floatValue], heightLayoutValue = [heightLayoutString floatValue];
    CGFloat topLayoutValue = [topLayoutString floatValue], bottomLayoutValue = [bottomLayoutString floatValue];

    // Overrides
    if (layoutOverrides.left)
        leftLayoutValue = layoutOverrides.left;
    if (layoutOverrides.top)
        topLayoutValue = layoutOverrides.top;
    if (layoutOverrides.width)
        widthLayoutValue = layoutOverrides.width;
    if (layoutOverrides.height)
        heightLayoutValue = layoutOverrides.height;
    if (layoutOverrides.bottom)
        bottomLayoutValue = layoutOverrides.bottom;
    if (layoutOverrides.right)
        rightLayoutValue = layoutOverrides.right;

    // Options
    if ([sizeLayoutString rangeOfString:@"|"].location != NSNotFound)
        options |= PearlLayoutOptionConstrainSize;

    // Left
    if ([leftLayoutString isEqualToString:@">"])
        leftLayoutValue = CGFLOAT_MAX;
    else if ([leftLayoutString isEqualToString:@"-"] && [self.superview respondsToSelector:@selector( layoutMargins )])
        leftLayoutValue = self.superview.layoutMargins.left;
    else if ([leftLayoutString isEqualToString:@"="])
        leftLayoutValue = self.frame.origin.x;
    else if ([leftLayoutString isEqualToString:@"x"])
        leftLayoutValue = x;
    else if ([leftLayoutString isEqualToString:@"y"])
        leftLayoutValue = y;
    else if ([leftLayoutString isEqualToString:@"z"])
        leftLayoutValue = z;

    // Right
    if ([rightLayoutString isEqualToString:@"<"])
        rightLayoutValue = CGFLOAT_MAX;
    else if ([rightLayoutString isEqualToString:@"-"] && [self.superview respondsToSelector:@selector( layoutMargins )])
        rightLayoutValue = self.superview.layoutMargins.right;
    else if ([rightLayoutString isEqualToString:@"="])
        rightLayoutValue = CGRectGetRight( self.superview.bounds ).x - CGRectGetRight( self.frame ).x;
    else if ([rightLayoutString isEqualToString:@"x"])
        rightLayoutValue = x;
    else if ([rightLayoutString isEqualToString:@"y"])
        rightLayoutValue = y;
    else if ([rightLayoutString isEqualToString:@"z"])
        rightLayoutValue = z;

    // Top
    if ([topLayoutString isEqualToString:@">"])
        topLayoutValue = CGFLOAT_MAX;
    else if ([topLayoutString isEqualToString:@"-"] && [self.superview respondsToSelector:@selector( layoutMargins )])
        topLayoutValue = self.superview.layoutMargins.top;
    else if ([topLayoutString isEqualToString:@"="])
        topLayoutValue = self.frame.origin.y;
    else if ([topLayoutString isEqualToString:@"x"])
        topLayoutValue = x;
    else if ([topLayoutString isEqualToString:@"y"])
        topLayoutValue = y;
    else if ([topLayoutString isEqualToString:@"z"])
        topLayoutValue = z;

    // Bottom
    if ([bottomLayoutString isEqualToString:@"<"])
        bottomLayoutValue = CGFLOAT_MAX;
    else if ([bottomLayoutString isEqualToString:@"-"] && [self.superview respondsToSelector:@selector( layoutMargins )])
        bottomLayoutValue = self.superview.layoutMargins.bottom;
    else if ([bottomLayoutString isEqualToString:@"="])
        bottomLayoutValue = CGRectGetBottom( self.superview.bounds ).y - CGRectGetBottom( self.frame ).y;
    else if ([bottomLayoutString isEqualToString:@"x"])
        bottomLayoutValue = x;
    else if ([bottomLayoutString isEqualToString:@"y"])
        bottomLayoutValue = y;
    else if ([bottomLayoutString isEqualToString:@"z"])
        bottomLayoutValue = z;

    // Width
    if ([widthLayoutString isEqualToString:@"-"])
        widthLayoutValue = 44;
    else if ([widthLayoutString isEqualToString:@"="])
        widthLayoutValue = self.frame.size.width;
    else if ([widthLayoutString isEqualToString:@"x"])
        widthLayoutValue = x;
    else if ([widthLayoutString isEqualToString:@"y"])
        widthLayoutValue = y;
    else if ([widthLayoutString isEqualToString:@"z"])
        widthLayoutValue = z;
    else if (!widthLayoutString.length)
        widthLayoutValue = CGFLOAT_MIN;
    if (leftLayoutValue < CGFLOAT_MAX && rightLayoutValue < CGFLOAT_MAX) {
        NSAssert( widthLayoutValue == CGFLOAT_MIN, @"Cannot have fixed left, right and width values." );
        widthLayoutValue = CGFLOAT_MAX;
    }

    // Height
    if ([heightLayoutString isEqualToString:@"-"])
        heightLayoutValue = 44;
    else if ([heightLayoutString isEqualToString:@"="])
        heightLayoutValue = self.frame.size.height;
    else if ([heightLayoutString isEqualToString:@"x"])
        heightLayoutValue = x;
    else if ([heightLayoutString isEqualToString:@"y"])
        heightLayoutValue = y;
    else if ([heightLayoutString isEqualToString:@"z"])
        heightLayoutValue = z;
    else if (!heightLayoutString.length)
        heightLayoutValue = CGFLOAT_MIN;
    if (topLayoutValue < CGFLOAT_MAX && bottomLayoutValue < CGFLOAT_MAX) {
        NSAssert( heightLayoutValue == CGFLOAT_MIN, @"Cannot have fixed top, bottom and height values." );
        heightLayoutValue = CGFLOAT_MAX;
    }

    // Apply layout
    [self setFrameFromSize:CGSizeMake( widthLayoutValue, heightLayoutValue )
       andParentPaddingTop:topLayoutValue right:rightLayoutValue bottom:bottomLayoutValue left:leftLayoutValue
             constrainSize:options & PearlLayoutOptionConstrainSize];
}

- (void)setFrameFromSize:(CGSize)size andParentPaddingTop:(CGFloat)top right:(CGFloat)right
                  bottom:(CGFloat)bottom left:(CGFloat)left {

    [self setFrameFromSize:size andParentPaddingTop:top right:right bottom:bottom left:left constrainSize:NO];
}

- (void)setFrameFromSize:(CGSize)size andParentPaddingTop:(CGFloat)top right:(CGFloat)right
                  bottom:(CGFloat)bottom left:(CGFloat)left constrainSize:(BOOL)constrainSize {

    CGFloat availableWidth = self.superview.bounds.size.width -
                             (left == CGFLOAT_MAX? 0: left) - (right == CGFLOAT_MAX? 0: right);
    CGFloat availableHeight = self.superview.bounds.size.height -
                              (top == CGFLOAT_MAX? 0: top) - (bottom == CGFLOAT_MAX? 0: bottom);
    CGSize resolvedSize = size;

    // Resolve our minimal size dimensions with the view's fitting size.
    if (size.width == CGFLOAT_MIN || size.height == CGFLOAT_MIN) {
        // For the fitting size, use 0 for unknown minimal bounds and the available space for unknown maximal bounds.
        resolvedSize = [self sizeThatFits:(CGSize){
                .width = size.width == CGFLOAT_MIN? 0: size.width == CGFLOAT_MAX? availableWidth: size.width,
                .height = size.height == CGFLOAT_MIN? 0: size.height == CGFLOAT_MAX? availableHeight: size.height,
        }];
        resolvedSize = CGSizeMake(
                size.width == CGFLOAT_MIN? resolvedSize.width: size.width,
                size.height == CGFLOAT_MIN? resolvedSize.height: size.height );
    }
    if (constrainSize)
        resolvedSize = CGSizeMake(
                resolvedSize.width == CGFLOAT_MAX? CGFLOAT_MAX: MIN( resolvedSize.width, availableWidth ),
                resolvedSize.height == CGFLOAT_MAX? CGFLOAT_MAX: MIN( resolvedSize.height, availableHeight ) );

    // Resolve the frame based on the parent's bounds and our layout parameters.
    self.frame = CGRectInCGRectWithSizeAndPadding( self.superview.bounds, resolvedSize, top, right, bottom, left );
}

+ (instancetype)findAsSuperviewOf:(UIView *)view {

    for (UIView *candidate = view; candidate; candidate = [candidate superview])
        if ([candidate isKindOfClass:self])
            return candidate;

    return nil;
}

- (BOOL)isOrHasSuperviewOfKind:(Class)kind {

    for (UIView *view = self; view; view = [view superview])
        if ([view isKindOfClass:kind])
            return YES;

    return NO;
}

- (BOOL)enumerateViews:(void ( ^ )(UIView *subview, BOOL *stop, BOOL *recurse))block recurse:(BOOL)recurseDefault {

    BOOL stop = NO, recurse = recurseDefault;
    block( self, &stop, &recurse );
    if (stop)
        return NO;

    if (recurse)
        for (UIView *subview in self.subviews)
            if (![subview enumerateViews:block recurse:recurseDefault])
                return NO;

    return YES;
}

- (void)printSuperHierarchy {

    NSUInteger indent = 0;
    for (UIView *view = self; view; view = view.superview) {
        NSLog( strf( @"%%%lds %%@", (long)indent ), "", [view infoDescription] );
        indent += 4;
    }
}

- (void)printChildHierarchy {

    [self printChildHierarchyWithIndent:0];
}

- (void)printChildHierarchyWithIndent:(NSUInteger)indent {

    NSLog( strf( @"%%%lds %%@", (long)indent ), "", [self infoDescription] );

    for (UIView *child in self.subviews)
        [child printChildHierarchyWithIndent:indent + 4];
}

- (NSString *)infoDescription {

    // Get background color
    CGFloat red, green, blue, alpha;
    [self.backgroundColor getRed:&red green:&green blue:&blue alpha:&alpha];
    NSString *backgroundString = strf( @"%02hhx/%02hhx%02hhx%02hhx",
            (char)(alpha * 256), (char)(red * 256), (char)(green * 256), (char)(blue * 256) );

    // Find the view controller
    UIResponder *nextResponder = [self nextResponder];
    while ([nextResponder isKindOfClass:[UIView class]])
        nextResponder = [nextResponder nextResponder];
    UIViewController *viewController = nil;
    if ([nextResponder isKindOfClass:[UIViewController class]])
        if ((viewController = (UIViewController *)nextResponder).view != self)
            viewController = nil;
    NSString *property = [viewController propertyWithValue:self];

    return strf( strf( @"%@ t:%%d, a:%%0.1f, h:%%@, b:%%@, f:%%@, %%@", viewController? @"+ %@ (%@)%@": @"- %@%@%@" ),
            NSStringFromClass( [viewController class] )?: @"", [self class], property?: @"",
            self.tag, self.alpha, @(self.hidden), backgroundString,
            NSStringFromCGRect( self.frame ), [self debugDescription] );
}

- (NSString *)layoutDescription {

    NSMutableString *layout = [NSMutableString new], *ancestry = [NSMutableString new];
    [layout appendFormat:@"Constraints affecting: %@", [self infoDescription]];
    for (UIView *constraintHolder = self; constraintHolder; constraintHolder = [constraintHolder superview], [ancestry appendString:@":"])
        for (NSLayoutConstraint *constraint in constraintHolder.constraints) {
            if (constraint.firstItem != self && constraint.secondItem != self)
                continue;

            [layout appendFormat:@"\n  - [%@%@] %@", ancestry, [constraintHolder class], [constraint debugDescription]];
        }

    return layout;
}

- (UIView *)subviewClosestTo:(CGPoint)point {

    return [PearlUIUtils viewClosestTo:point ofArray:self.subviews];
}

- (CGRect)contentBoundsIgnoringSubviews:(UIView *)ignoredSubviews, ... {

    return [self contentBoundsIgnoringSubviewsArray:va_array( ignoredSubviews )];
}

- (CGRect)contentBoundsIgnoringSubviewsArray:(NSArray *)ignoredSubviewsArray {

    CGRect contentRect = self.bounds;
    if (!self.clipsToBounds)
        for (UIView *subview in self.subviews)
            if (!subview.hidden && subview.alpha > DBL_EPSILON && ![ignoredSubviewsArray containsObject:subview])
                contentRect = CGRectUnion( contentRect,
                        [self    convertRect:
                                        [subview contentBoundsIgnoringSubviewsArray:ignoredSubviewsArray]
                                 fromView:subview] );

    return contentRect;
}

- (CGRect)frameInWindow {

    return [self.window convertRect:self.bounds fromView:self];
}

- (UIView *)findFirstResponderInHierarchy {

    if (self.isFirstResponder)
        return self;

    UIView *firstResponder = nil;
    for (UIView *subView in self.subviews)
        if ((firstResponder = [subView findFirstResponderInHierarchy]))
            break;

    return firstResponder;
}

@end

@implementation PearlUIUtils

+ (UIView *)viewClosestTo:(CGPoint)point of:(UIView *)views, ... {

    return [self viewClosestTo:point ofArray:va_array( views )];
}

+ (UIView *)viewClosestTo:(CGPoint)point ofArray:(NSArray *)views {

    UIView *closestView = nil;
    CGFloat closestDistance = 0;
    for (UIView *view in views) {
        if (view.hidden || view.alpha < DBL_EPSILON)
            continue;

        CGFloat distance = DistanceBetweenCGPointsSq( view.center, point );
        if (closestDistance < DBL_EPSILON || distance < closestDistance) {
            closestDistance = distance;
            closestView = view;
        }
    }

    return closestView;
}

@end
