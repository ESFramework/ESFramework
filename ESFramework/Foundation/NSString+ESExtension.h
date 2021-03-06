//
//  NSString+ESExtension.h
//  ESFramework
//
//  Created by Elf Sundae on 2014/04/06.
//  Copyright © 2014-2020 https://0x123.com All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (ESExtension)

/**
 * Returns a NSData object containing a representation of the string encoded using UTF-8 encoding.
 */
- (nullable NSData *)dataValue;

/**
 * Returns a new string made by trimming whitespace and newline characters.
 */
- (NSString *)trimmedString;

/**
 * Returns a percent escaped string following RFC 3986 for a query string key or value.
 */
- (nullable NSString *)URLEncodedString;

/**
 * Returns a new string made by replacing all percent encoded sequences with the matching UTF-8 characters.
 */
- (nullable NSString *)URLDecodedString;

- (NSString *)stringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options;
- (NSString *)stringByReplacingWithDictionary:(NSDictionary *)dictionary options:(NSStringCompareOptions)options;

- (NSString *)stringByDeletingCharactersInSet:(NSCharacterSet *)characters;
- (NSString *)stringByDeletingCharactersInString:(NSString *)string;

/**
 * Returns the URL query parameters.
 */
- (nullable NSDictionary<NSString *, id> *)URLQueryParameters;

/**
 * Returns a newly created URL string added the given query parameters.
 */
- (NSString *)stringByAddingURLQueryParameters:(NSDictionary<NSString *, id> *)parameters;

/**
 * Converts the JSON string to an Foundation object.
 */
- (nullable id)JSONObject;

/**
 * Converts the JSON string to an Foundation object.
 */
- (nullable id)JSONObjectWithOptions:(NSJSONReadingOptions)options;

- (NSData *)md5HashData;
- (NSString *)md5HashString;

- (NSData *)sha1HashData;
- (NSString *)sha1HashString;
- (NSData *)sha224HashData;
- (NSString *)sha224HashString;
- (NSData *)sha256HashData;
- (NSString *)sha256HashString;
- (NSData *)sha384HashData;
- (NSString *)sha384HashString;
- (NSData *)sha512HashData;
- (NSString *)sha512HashString;

- (NSData *)hmacMD5HashDataWithKey:(NSData *)key;
- (NSString *)hmacMD5HashStringWithKey:(NSString *)key;
- (NSData *)hmacSHA1HashDataWithKey:(NSData *)key;
- (NSString *)hmacSHA1HashStringWithKey:(NSString *)key;
- (NSData *)hmacSHA224HashDataWithKey:(NSData *)key;
- (NSString *)hmacSHA224HashStringWithKey:(NSString *)key;
- (NSData *)hmacSHA256HashDataWithKey:(NSData *)key;
- (NSString *)hmacSHA256HashStringWithKey:(NSString *)key;
- (NSData *)hmacSHA384HashDataWithKey:(NSData *)key;
- (NSString *)hmacSHA384HashStringWithKey:(NSString *)key;
- (NSData *)hmacSHA512HashDataWithKey:(NSData *)key;
- (NSString *)hmacSHA512HashStringWithKey:(NSString *)key;

- (NSData *)base64EncodedData;
- (NSString *)base64EncodedString;
- (NSString *)base64EncodedURLSafeString;
- (nullable NSData *)base64DecodedData;
- (nullable NSString *)base64DecodedString;

// AES encryption, see NSData(ESExtension) for more methods.

- (nullable NSData *)aesEncryptedDataWithKey:(NSData *)key IV:(NSData *)IV error:(NSError **)error;
- (nullable NSData *)aesEncryptedDataWithKeyString:(NSString *)key IVString:(NSString *)IV error:(NSError **)error;
- (nullable NSData *)aesEncryptedDataWithHexKey:(NSString *)key hexIV:(NSString *)IV error:(NSError **)error;

@end

@interface NSMutableString (ESExtension)

- (NSUInteger)replaceOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options;

- (void)replaceWithDictionary:(NSDictionary<NSString *, NSString *> *)dictionary options:(NSStringCompareOptions)options;

@end

NS_ASSUME_NONNULL_END
