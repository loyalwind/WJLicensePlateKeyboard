//
//  WJLicensePlateKeyboard.h
//  WJLicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,KeyboardSubKBFrameType) {
    KeyboardSubKBFrameTypeFill = 0,/**< 填充型 ,横屏时键盘与刘海的padding = 键盘与home键的padding */
    KeyboardSubKBFrameTypeSymmetric /**< 对称型 ,横屏时键盘与屏幕的左边padding = 键盘与屏幕的右边padding, 且刚好等于 kiPhoneXFringeHeight */
};

@interface WJLicensePlateKeyboard : UIView
/** 输入的 View */
@property (nonatomic, weak) UIView <UITextInput> * inputTextView;
/** 文字大小 (19)*/
@property (nonatomic, strong) UIFont *titleFont;
/** 泡泡文字大小(40) */
@property (nonatomic, strong) UIFont *paopaoFont;
/** 子键盘布局类型（默认 KeyboardSubKBFrameTypeFill）为了适配iPhone X */
@property (nonatomic, assign) KeyboardSubKBFrameType subKBFrameType;
@end

@interface UIDevice (PlatformEx)
/** 平台名字 */
+ (NSString *)platformName;
/** 是否为iPhoneX */
+ (BOOL)isIPhoneX;
@end
