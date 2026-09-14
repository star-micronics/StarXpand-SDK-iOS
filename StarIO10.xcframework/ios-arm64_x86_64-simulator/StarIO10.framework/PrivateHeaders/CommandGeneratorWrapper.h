#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommandGeneratorWrapper : NSObject

+ (NSData *)generate:(int)commandGeneratorType
              option:(NSString *)option
        errorMessage:(NSString * _Nullable * _Nullable)errorMessage;

@end

NS_ASSUME_NONNULL_END
