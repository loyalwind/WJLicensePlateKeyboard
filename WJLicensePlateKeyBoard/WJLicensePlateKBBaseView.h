//
//  WJLicensePlateKBaseView.h
//  WJLicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/17.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJLicensePlateKBBaseView,WJLicensePlateKeyView;

/**
 功能按钮类型
 - WJFunctionButtonTypeDelete: 回删按钮类型
 - WJFunctionButtonTypeSwitch: 切换键盘按钮类型
 - WJFunctionButtonTypeFinish: 完成按钮类型
 */

typedef NS_ENUM(NSInteger, WJFunctionButtonType) {
    WJFunctionButtonTypeDelete = 50, // 回删按钮 sss
    WJFunctionButtonTypeSwitch = 100,
    WJFunctionButtonTypeFinish = 150,
};

/**
 键盘类型
 - WJLicensePlateKeyboardTypeProvince:  汉字省份键盘
 - WJLicensePlateKeyboardTypeEnglish: 英文和数字键盘
 */
typedef NS_ENUM(NSInteger, WJLicensePlateKeyboardType) {
    WJLicensePlateKeyboardTypeProvince = 1,
    WJLicensePlateKeyboardTypeEnglish = 2
};

/**
 代理协议
 */
@protocol LicensePlateKBBaseViewDelegate <NSObject>
@optional
/**
 通知代理切换键盘
 @param switch2KBType 切换到哪种键盘类型
 @param playInput 是否需要播放切换声音
 */
- (void)licensePlateKBBaseView:(WJLicensePlateKBBaseView *)kbBaseView
              didSwitch2KBType:(WJLicensePlateKeyboardType)switch2KBType
                     playInput:(BOOL)playInput;
/**
 通知代理插入文字
 @param text 插入的文字
 */
- (void)licensePlateKBBaseView:(WJLicensePlateKBBaseView *)kbBaseView didInsertText:(NSString *)text;

/**
 通知代理开始回删文字
 */
- (void)licensePlateKBBaseViewStartDeleteBackward:(WJLicensePlateKBBaseView *)kbBaseView;

/**
 通知代理结束回删文字
 */
- (void)licensePlateKBBaseViewEndDeleteBackward:(WJLicensePlateKBBaseView *)kbBaseView;

/**
 通知代理点击完成
 */
- (void)licensePlateKBBaseViewDidFinish:(WJLicensePlateKBBaseView *)kbBaseView;

@end

@interface WJLicensePlateKBBaseView : UIView
{
@protected
    NSArray <NSString *> *_characters;
}

/// 根据给定字符集合初始化
/// @param characters 给定字符集合
- (instancetype)initWithCharacters:(NSArray <NSString *> *)characters;
/** 字符集  */
@property (nonatomic, strong) NSArray <NSString *> *characters;
/** 完成字符文字 (完成) */
@property (nonatomic, strong, readonly) NSString *doneText;
/** 切换字符文字（中文, 英文） */
@property (nonatomic, strong, readonly) NSString *switchText;
/** 按键集合  */
@property (nonatomic, strong, readonly) NSArray <__kindof UIView *> *keyViews;
/** 行数 */
@property (nonatomic, assign, readonly) NSInteger rows;
/** 列数 */
@property (nonatomic, assign, readonly) NSInteger columns;
/** 切换键盘时，切换的键盘类型 */
@property (nonatomic, assign,readonly) WJLicensePlateKeyboardType switch2KeyBoardType;
/** 在触摸结束后是否需要切换键盘 */
@property (nonatomic, assign,readonly) BOOL needSwitchKBAfterTouchEnd;
/** 代理 */
@property (nonatomic, weak) id<LicensePlateKBBaseViewDelegate> delegate;
/** 当前的显示的按键 */
//@property (nonatomic, weak, readonly) LicensePlateKeyView *currentKeyView;
/** 处理离开屏幕或者屏幕旋转 */
- (void)handleRotateScreenOrOn2OffScreen;

- (UIImage *)imageFromColor:(UIColor *)color;

- (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end
