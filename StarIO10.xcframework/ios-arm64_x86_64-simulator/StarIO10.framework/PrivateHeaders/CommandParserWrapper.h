#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommandParserWrapper : NSObject

+ (NSString *)parse:(int)parserType data:(NSData *)data option:(NSString *)option;

@end

NS_ASSUME_NONNULL_END
