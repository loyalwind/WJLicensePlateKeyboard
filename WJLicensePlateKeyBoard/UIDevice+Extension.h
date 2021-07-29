//
//  UIDevice+Extension.h
//  
//
//  Created by 彭维剑 on 2018/5/8.
//

#import <UIKit/UIKit.h>

/// NOTE: 以后苹果发布了新机型，需要在 UIDeviceModel.plist 添加进去

@interface UIDevice (WJExtension)
/** 设备的硬件字符串
 
 *  例如："iPod3,1"、 @"iPad8,8"、 @"iPhone13,1" 等等
 */
+ (NSString *)platformName;

/** 是否为刘海屏 */
+ (BOOL)isFringeScreen;

/** 设备名

 *  例如：iPhone 6, iPad Pro, iPad Mini, iPod touch
 */
+ (NSString *)deviceModel;
@end
