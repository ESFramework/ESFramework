//
//  NSDictionary+ESExtension.m
//  ESFramework
//
//  Created by Elf Sundae on 2014/04/08.
//  Copyright © 2014-2020 https://0x123.com All rights reserved.
//

#import "NSDictionary+ESExtension.h"
#import "NSURLComponents+ESExtension.h"
#import "NSData+ESExtension.h"

@implementation NSDictionary (ESExtension)

- (NSDictionary *)entriesForKeys:(NSSet *)keys
{
    NSMutableDictionary *entries = [NSMutableDictionary dictionary];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            entries[key] = value;
        }
    }
    return [entries copy];
}

- (NSString *)URLQueryString
{
    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:@"http://0x123.com"];
    urlComponents.queryParameters = self;
    return urlComponents.percentEncodedQuery;
}

- (NSDictionary *)entriesPassingTest:(BOOL (NS_NOESCAPE ^)(id, id, BOOL *))predicate
{
    return [self entriesWithOptions:0 passingTest:predicate];
}

- (NSDictionary *)entriesWithOptions:(NSEnumerationOptions)opts passingTest:(BOOL (NS_NOESCAPE ^)(id, id, BOOL *))predicate
{
    NSArray *keys = [self keysOfEntriesWithOptions:opts passingTest:predicate].allObjects;
    NSArray *objects = [self objectsForKeys:keys notFoundMarker:[NSNull null]];
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSData *)JSONData
{
    return [self JSONDataWithOptions:0];
}

- (NSData *)JSONDataWithOptions:(NSJSONWritingOptions)opts
{
    return [NSJSONSerialization isValidJSONObject:self]
           ? [NSJSONSerialization dataWithJSONObject:self options:opts error:NULL]
           : nil;
}

- (NSString *)JSONString
{
    return [self JSONStringWithOptions:0];
}

- (NSString *)JSONStringWithOptions:(NSJSONWritingOptions)opts
{
    return [self JSONDataWithOptions:opts].UTF8String;
}

@end

#pragma mark - NSMutableDictionary (ESExtension)

@implementation NSMutableDictionary (ESExtension)

- (void)setObject:(id)object forKeyPath:(NSString *)keyPath
{
    NSMutableDictionary *dict = self;
    NSArray *keys = [keyPath componentsSeparatedByString:@"."];
    for (NSUInteger i = 0; i + 1 < keys.count; i++) {
        NSString *key = keys[i];
        NSMutableDictionary *current = dict[key];

        if ([current isKindOfClass:[NSDictionary class]] &&
            ![current isKindOfClass:[NSMutableDictionary class]]) {
            current = [current mutableCopy];
        }

        if (!current || ![current isKindOfClass:[NSMutableDictionary class]]) {
            current = [NSMutableDictionary dictionary];
        }

        dict[key] = current;
        dict = current;
    }

    dict[keys.lastObject] = object;
}

@end
