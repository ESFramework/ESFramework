//
//  NSString+ESExtension.m
//  ESFramework
//
//  Created by Elf Sundae on 2014/04/06.
//  Copyright © 2014-2020 https://0x123.com All rights reserved.
//

#import "NSString+ESExtension.h"
#import "ESHelpers.h"
#import "NSCharacterSet+ESExtension.h"
#import "NSURLComponents+ESExtension.h"
#import "NSData+ESExtension.h"

@implementation NSString (ESExtension)

- (nullable NSData *)dataValue
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)trimmedString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)URLEncodedString
{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLEncodingAllowedCharacterSet]];
}

- (NSString *)URLDecodedString
{
    return [[self stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByRemovingPercentEncoding];
}

- (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options
{
    return [self stringByReplacingOccurrencesOfString:target withString:replacement options:options range:NSMakeRange(0, self.length)];
}

- (NSString *)stringByReplacingWithDictionary:(NSDictionary *)dictionary options:(NSStringCompareOptions)options
{
    NSMutableString *result = [self mutableCopy];
    [result replaceWithDictionary:dictionary options:options];
    return [result copy];
}

- (NSString *)stringByDeletingCharactersInSet:(NSCharacterSet *)characters
{
    return [[self componentsSeparatedByCharactersInSet:characters] componentsJoinedByString:@""];
}

- (NSString *)stringByDeletingCharactersInString:(NSString *)string
{
    return [self stringByDeletingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:string]];
}

- (NSDictionary<NSString *, id> *)URLQueryParameters
{
    return [NSURLComponents componentsWithString:self].queryParameters;
}

- (NSString *)stringByAddingURLQueryParameters:(NSDictionary<NSString *, id> *)parameters
{
    NSURLComponents *components = [NSURLComponents componentsWithString:self];
    [components addQueryParameters:parameters];
    return components.string;
}

- (id)JSONObject
{
    return [self JSONObjectWithOptions:0];
}

- (id)JSONObjectWithOptions:(NSJSONReadingOptions)options
{
    return [self.dataValue JSONObjectWithOptions:options];
}

- (NSData *)md5HashData
{
    return [self.dataValue md5HashData];
}

- (NSString *)md5HashString
{
    return [self.dataValue md5HashString];
}

- (NSData *)sha1HashData
{
    return [self.dataValue sha1HashData];
}

- (NSString *)sha1HashString
{
    return [self.dataValue sha1HashString];
}

- (NSData *)sha224HashData
{
    return [self.dataValue sha224HashData];
}

- (NSString *)sha224HashString
{
    return [self.dataValue sha224HashString];
}

- (NSData *)sha256HashData
{
    return [self.dataValue sha256HashData];
}

- (NSString *)sha256HashString
{
    return [self.dataValue sha256HashString];
}

- (NSData *)sha384HashData
{
    return [self.dataValue sha384HashData];
}

- (NSString *)sha384HashString
{
    return [self.dataValue sha384HashString];
}

- (NSData *)sha512HashData
{
    return [self.dataValue sha512HashData];
}

- (NSString *)sha512HashString
{
    return [self.dataValue sha512HashString];
}

- (NSData *)hmacMD5HashDataWithKey:(NSData *)key
{
    return [self.dataValue hmacMD5HashDataWithKey:key];
}

- (NSString *)hmacMD5HashStringWithKey:(NSString *)key
{
    return [self.dataValue hmacMD5HashStringWithKey:key];
}

- (NSData *)hmacSHA1HashDataWithKey:(NSData *)key
{
    return [self.dataValue hmacSHA1HashDataWithKey:key];
}

- (NSString *)hmacSHA1HashStringWithKey:(NSString *)key
{
    return [self.dataValue hmacSHA1HashStringWithKey:key];
}

- (NSData *)hmacSHA224HashDataWithKey:(NSData *)key
{
    return [self.dataValue hmacSHA224HashDataWithKey:key];
}

- (NSString *)hmacSHA224HashStringWithKey:(NSString *)key
{
    return [self.dataValue hmacSHA224HashStringWithKey:key];
}

- (NSData *)hmacSHA256HashDataWithKey:(NSData *)key
{
    return [self.dataValue hmacSHA256HashDataWithKey:key];
}

- (NSString *)hmacSHA256HashStringWithKey:(NSString *)key
{
    return [self.dataValue hmacSHA256HashStringWithKey:key];
}

- (NSData *)hmacSHA384HashDataWithKey:(NSData *)key
{
    return [self.dataValue hmacSHA384HashDataWithKey:key];
}

- (NSString *)hmacSHA384HashStringWithKey:(NSString *)key
{
    return [self.dataValue hmacSHA384HashStringWithKey:key];
}

- (NSData *)hmacSHA512HashDataWithKey:(NSData *)key
{
    return [self.dataValue hmacSHA512HashDataWithKey:key];
}

- (NSString *)hmacSHA512HashStringWithKey:(NSString *)key
{
    return [self.dataValue hmacSHA512HashStringWithKey:key];
}

- (NSData *)base64EncodedData
{
    return [self.dataValue base64EncodedData];
}

- (NSString *)base64EncodedString
{
    return [self.dataValue base64EncodedString];
}

- (NSString *)base64EncodedURLSafeString
{
    return [self.dataValue base64EncodedURLSafeString];
}

- (NSData *)base64DecodedData
{
    // Restore the URL-safe string to the original base64 encoded string
    NSString *string = [[self stringByReplacingOccurrencesOfString:@"-" withString:@"+"]
                        stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSUInteger equalLength = string.length % 4;
    if (equalLength) {
        string = [string stringByPaddingToLength:string.length + 4 - equalLength withString:@"=" startingAtIndex:0];
    }

    return [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
}

- (NSString *)base64DecodedString
{
    return self.base64DecodedData.UTF8String;
}

- (nullable NSData *)aesEncryptedDataWithKey:(NSData *)key IV:(NSData *)IV error:(NSError **)error
{
    return [self.dataValue aesEncryptedDataWithKey:key IV:IV error:error];
}

- (nullable NSData *)aesEncryptedDataWithKeyString:(NSString *)key IVString:(NSString *)IV error:(NSError **)error
{
    return [self.dataValue aesEncryptedDataWithKeyString:key IVString:IV error:error];
}

- (nullable NSData *)aesEncryptedDataWithHexKey:(NSString *)key hexIV:(NSString *)IV error:(NSError **)error
{
    return [self.dataValue aesEncryptedDataWithHexKey:key hexIV:IV error:error];
}

@end

@implementation NSMutableString (ESExtension)

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options
{
    return [self replaceOccurrencesOfString:target withString:replacement options:options range:NSMakeRange(0, self.length)];
}

- (void)replaceWithDictionary:(NSDictionary<NSString *, NSString *> *)dictionary options:(NSStringCompareOptions)options
{
    for (NSString *key in dictionary) {
        [self replaceOccurrencesOfString:key withString:dictionary[key] options:options];
    }
}

@end
