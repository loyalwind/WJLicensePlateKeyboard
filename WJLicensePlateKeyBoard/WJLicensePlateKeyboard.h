//
//  WJLicensePlateKeyboard.h
//  WJLicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WJLicensePlateProvinceView.h"
#import "WJLicensePlateEnglishView.h"

typedef NS_ENUM(NSInteger,KeyboardSubKBFrameType) {
    KeyboardSubKBFrameTypeFill = 0,/**< 填充型 ,横屏时键盘与刘海的padding = 键盘与home键的padding */
    KeyboardSubKBFrameTypeSymmetric /**< 对称型 ,横屏时键盘与屏幕的左边padding = 键盘与屏幕的右边padding, 且刚好等于 kFringeTopPadding */
};

@interface WJLicensePlateKeyboard : UIView

/// 根据中文、英文字符集进行初始化构造，便于自定义调整字符集 和 顺序
/// @param zhCharacters 中文字符集
/// @param enCharacters 英文字符集
- (instancetype)initWithZhCharacters:(NSArray <NSString *> *)zhCharacters
                        enCharacters:(NSArray <NSString *> *)enCharacters;
/// 便于一些自定义中文字符集和调整顺序
/// @param chineseCharacters 中文字符
- (void)setChineseCharacters:(NSArray <NSString *> *)chineseCharacters;

/// 便于一些自定义英文字符集和调整顺序
/// @param englishCharacters 英文字符
- (void)setEnglishCharacters:(NSArray <NSString *> *)englishCharacters;

/// 根据中文键盘，英文键盘初始化总键盘
/// @param chineseView 中文键盘 多态类型 (WJLicensePlateProvinceView子类来自定义）
/// @param englishView 英文键盘 多态类型（WJLicensePlateEnglishView子类来自定义）
- (instancetype)initWithChineseView:(WJLicensePlateKBBaseView *)chineseView
                        englishView:(WJLicensePlateKBBaseView *)englishView;

/** 输入的 View */
@property (nonatomic, weak) UIView <UITextInput> * inputTextView;
/** 文字大小 (19)*/
@property (nonatomic, strong) UIFont *titleFont;
/** 泡泡文字大小(40) */
@property (nonatomic, strong) UIFont *paopaoFont;
/** 子键盘布局类型（默认 KeyboardSubKBFrameTypeFill）为了适配刘海屏 */
@property (nonatomic, assign) KeyboardSubKBFrameType subKBFrameType;

@end

