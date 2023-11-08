//
//  UIDevice+Extension.h
//  
//
//  Created by 彭维剑 on 2018/5/8.
//

#import <UIKit/UIKit.h>

/// NOTE: 以后苹果发布了新机型，需要在 UIDeviceModel.plist 添加进去

@interface UIDevice (WJExtension)
/** 设置自定义设备模型plist文件 
 * 内容格式参考 WJLicensePlateKeyboard.bundle/UIDeviceModel.plist 里面的
 *
 * - Parameter path: plist文件路径
 */
+ (void)setupDeviceModelFile:(NSString *)path;
/** 设置自定义设备模型字典
 * 内容格式参考 WJLicensePlateKeyboard.bundle/UIDeviceModel.plist 里面的
 *
 * - Parameter dict: 设备模型字典
 */
+ (void)setupDeviceModelDict:(NSDictionary *)dict;
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
