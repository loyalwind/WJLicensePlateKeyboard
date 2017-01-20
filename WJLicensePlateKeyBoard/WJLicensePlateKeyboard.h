//
//  WJLicensePlateKeyboard.h
//  WJLicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJLicensePlateKeyboard : UIView
/** 输入的 View */
@property (nonatomic, weak) UIView <UITextInput> * inputTextView;
/** 文字大小 (19)*/
@property (nonatomic, strong) UIFont *titleFont;
/** 泡泡文字大小(40) */
@property (nonatomic, strong) UIFont *paopaoFont;
@end
