//
//  NSInvocation+ESExtension.m
//  ESFramework
//
//  Created by Elf Sundae on 2019/04/23.
//  Copyright © 2014-2020 https://0x123.com All rights reserved.
//

#import "NSInvocation+ESExtension.h"
#import <CoreGraphics/CoreGraphics.h>
#if !TARGET_OS_OSX
#import <UIKit/UIKit.h>
#endif
#if !TARGET_OS_WATCH
#import <QuartzCore/QuartzCore.h>
#endif

static id __gNil = nil;

@implementation NSInvocation (ESExtension)

+ (instancetype)invocationWithTarget:(id)target selector:(SEL)selector, ...
{
    va_list arguments;
    va_start(arguments, selector);
    NSInvocation *invocation = [NSInvocation invocationWithTarget:target selector:selector arguments:arguments];
    va_end(arguments);

    return invocation;
}

+ (instancetype)invocationWithTarget:(id)target selector:(SEL)selector arguments:(va_list)arguments
{
    NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
    if (!signature) {
        return nil;
    }

    NSInvocation *invocation = [self invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:selector];

    for (NSUInteger argIndex = 2; argIndex < signature.numberOfArguments; argIndex++) {
        // https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
        const char *argType = [signature getArgumentTypeAtIndex:argIndex];

#define CMPString(str, str1)    (0 == strcmp(str, str1))
#define CMPType(type)           (CMPString(@encode(type), argType))

#define SetArgumentWithValue(type) do { \
        type arg = va_arg(arguments, type); \
        [invocation setArgument:&arg atIndex:argIndex]; \
} while (0)

#define SetArgumentWithPointer(type) do { \
        type arg = va_arg(arguments, type); \
        if (arg) [invocation setArgument:arg atIndex:argIndex]; \
        else [invocation setArgument:&__gNil atIndex:argIndex]; \
} while (0)

#define IfTypeThenSetValueAs(type, asType)      if (CMPType(type)) { SetArgumentWithValue(asType); }
#define IfTypeThenSetValue(type)                IfTypeThenSetValueAs(type, type)
#define IfTypeThenSetPointer(type)              if (CMPType(type)) { SetArgumentWithPointer(type); }

#define ElseIfTypeThenSetValueAs(type, asType)  else IfTypeThenSetValueAs(type, asType)
#define ElseIfTypeThenSetValue(type)            else IfTypeThenSetValue(type)
#define ElseIfTypeThenSetPointer(type)          else IfTypeThenSetPointer(type)

        IfTypeThenSetValueAs(char, int)
        ElseIfTypeThenSetValueAs(unsigned char, int)
        ElseIfTypeThenSetValueAs(short, int)
        ElseIfTypeThenSetValueAs(unsigned short, int)
        ElseIfTypeThenSetValueAs(BOOL, int)
        ElseIfTypeThenSetValue(int)
        ElseIfTypeThenSetValue(unsigned int)
        ElseIfTypeThenSetValue(long)
        ElseIfTypeThenSetValue(unsigned long)
        ElseIfTypeThenSetValue(long long)
        ElseIfTypeThenSetValue(unsigned long long)
        ElseIfTypeThenSetValueAs(float, double)
        ElseIfTypeThenSetValue(double)
        ElseIfTypeThenSetValue(long double)
        ElseIfTypeThenSetValue(char *)
        ElseIfTypeThenSetValue(Class)
        ElseIfTypeThenSetValue(SEL)
        ElseIfTypeThenSetValue(NSRange)
        ElseIfTypeThenSetValue(CGPoint)
        ElseIfTypeThenSetValue(CGSize)
        ElseIfTypeThenSetValue(CGVector)
        ElseIfTypeThenSetValue(CGRect)
        ElseIfTypeThenSetValue(CGAffineTransform)
#if !TARGET_OS_OSX
        ElseIfTypeThenSetValue(UIEdgeInsets)
        ElseIfTypeThenSetValue(UIOffset)
#endif
#if !TARGET_OS_WATCH
        ElseIfTypeThenSetValue(CATransform3D)
#endif
        ElseIfTypeThenSetValue(id)
        else if (CMPString(argType, "@?")) {
            // block
            SetArgumentWithValue(id);
        } else if (argType[0] == '^') {
            IfTypeThenSetValue(short *)
            ElseIfTypeThenSetValue(unsigned short *)
            ElseIfTypeThenSetValue(BOOL *)
            ElseIfTypeThenSetValue(int *)
            ElseIfTypeThenSetValue(unsigned int *)
            ElseIfTypeThenSetValue(long *)
            ElseIfTypeThenSetValue(unsigned long *)
            ElseIfTypeThenSetValue(long long *)
            ElseIfTypeThenSetValue(unsigned long long *)
            ElseIfTypeThenSetValue(float *)
            ElseIfTypeThenSetValue(double *)
            ElseIfTypeThenSetValue(long double *)
            ElseIfTypeThenSetValue(char **)
            ElseIfTypeThenSetValue(Class *)
            ElseIfTypeThenSetValue(SEL *)
            ElseIfTypeThenSetValue(NSRange *)
            ElseIfTypeThenSetValue(CGPoint *)
            ElseIfTypeThenSetValue(CGSize *)
            ElseIfTypeThenSetValue(CGVector *)
            ElseIfTypeThenSetValue(CGRect *)
            ElseIfTypeThenSetValue(CGAffineTransform *)
#if !TARGET_OS_OSX
            ElseIfTypeThenSetValue(UIEdgeInsets *)
            ElseIfTypeThenSetValue(UIOffset *)
#endif
#if !TARGET_OS_WATCH
            ElseIfTypeThenSetValue(CATransform3D *)
#endif
            else if (CMPString(argType, "^@")) {
                SetArgumentWithValue(void *);
            } else {
                SetArgumentWithPointer(void *);
            }
        } else {
            SetArgumentWithPointer(void *);
        }
    } /* for-loop */

#undef CMPString
#undef CMPType
#undef SetArgumentWithValue
#undef SetArgumentWithPointer
#undef IfTypeThenSetValueAs
#undef IfTypeThenSetValue
#undef IfTypeThenSetPointer
#undef ElseIfTypeThenSetValueAs
#undef ElseIfTypeThenSetValue
#undef ElseIfTypeThenSetPointer

    return invocation;
}

@end
