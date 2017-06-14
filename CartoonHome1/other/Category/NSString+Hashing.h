

#import <Foundation/Foundation.h>
@interface NSString (NSString_Hashing)

/**
 *  @brief 大写
 *
 *  @return NSString
 */
- (NSString *)MD5Hash;
/**
 *  @brief 小写
 *
 *  @return NSString
 */
- (NSString *)md5;

/**
 *  @brief url encode编码
 *
 *  @return NSString
 */
- (NSString*)encodeString;

@end
