//
//  LicensePlateKeyView.h
//  LicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJLicensePlateKeyView : UIView
/** 标题 label */
@property (nonatomic, weak, readonly) UILabel *titleLabel;
/** 设置泡泡显示和隐藏 (默认 YES)*/
@property (nonatomic, assign, getter=isPaopaoHidden) BOOL paopaoHidden;
/** 文字 */
@property (nonatomic, copy)IBInspectable NSString *text;
/** 文字大小 (19)*/
@property (nonatomic, strong) UIFont *titleFont;
/** 泡泡文字大小(40) */
@property (nonatomic, strong) UIFont *paopaoFont;

@end
