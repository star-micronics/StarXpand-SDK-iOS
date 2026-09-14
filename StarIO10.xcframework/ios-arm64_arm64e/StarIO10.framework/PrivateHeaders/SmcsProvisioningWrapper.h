#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SmcsProvisioningWrapper : NSObject

+ (NSString *)valueForEnvironment:(int)environment index:(int)index;
+ (NSString *)platformTag;

@end

NS_ASSUME_NONNULL_END
