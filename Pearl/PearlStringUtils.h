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
//  StringUtils.h
//  Pearl
//
//  Created by Maarten Billemont on 05/11/09.
//  Copyright 2009, lhunath (Maarten Billemont). All rights reserved.
//

#import <Foundation/Foundation.h>

__BEGIN_DECLS
extern NSString *strf(NSString *format, ...) NS_FORMAT_FUNCTION( 1, 2 );
extern NSString *strl(NSString *format, ...) NS_FORMAT_FUNCTION( 1, 0 );
extern NSString *strtl(NSString *tableName, NSString *format, ...) NS_FORMAT_FUNCTION( 2, 0 );
extern NSMutableAttributedString *stra(id string, NSDictionary *attributes);
extern NSMutableAttributedString *strra(id string, NSRange range, NSDictionary *attributes);
extern NSMutableAttributedString *strarm(id string, id attributes, ...) NS_REQUIRES_NIL_TERMINATION;
extern NSMutableAttributedString *straf(id format, ...); // Only supports %@ in format string.

/** Generate a string that contains the given string but pads it to the given length if it is less by adding spaces on the right side. */
extern NSString *RPad(const NSString *string, const NSUInteger l);
/** Generate a string that contains the given string but pads it to the given length if it is less by adding spaces on the left side. */
extern NSString *LPad(const NSString *string, const NSUInteger l);
__END_DECLS

@interface NSString(PearlStringUtils)

- (NSString *)stringByDeletingMatchesOf:(NSString *)pattern;
- (NSString *)stringByDeletingMatchesOfExpression:(NSRegularExpression *)expression;

- (NSString *)stringByReplacingMatchesOf:(NSString *)pattern withTemplate:(NSString *)templ;
- (NSString *)stringByReplacingMatchesOfExpression:(NSRegularExpression *)expression withTemplate:(NSString *)templ;

/** Returns an array with substrings of this string matching the capture groups in the expression for the first match of the expression against this string.
 * Note: Returns NSNull for groups that did not participate in the match. */
- (NSArray<NSString *> *)firstMatchGroupsOfExpression:(NSRegularExpression *)expression;

@end
