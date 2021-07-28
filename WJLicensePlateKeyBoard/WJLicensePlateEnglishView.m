//
//  LicensePlateEnglishView.m
//  LicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "WJLicensePlateEnglishView.h"
#import "WJLicensePlateKeyView.h"
#import "WJConst.h"

@implementation WJLicensePlateEnglishView

- (NSArray<NSString *> *)characters
{
    if (!_characters) {
        NSString *str = @"1234567890QWERTYUPASDFGHJKLZXCVBNM";
        NSMutableArray *temArray = [NSMutableArray array];
        for (int i=0; i<str.length; i++) {
            NSString *subStr = [str substringWithRange:NSMakeRange(i, 1)];
            [temArray addObject:subStr];
        }
        _characters = temArray;
    }
    return _characters;
}
- (NSString *)switchText {
    return @"中文";
}

- (NSInteger)rows
{
    return kKBRow;
}
- (NSInteger)columns
{
    return kEnglishColumn;
}
- (WJLicensePlateKeyboardType)switch2KeyBoardType
{
    return WJLicensePlateKeyboardTypeProvince;
}
- (BOOL)needSwitchKBAfterTouchEnd
{
    return NO;
}
//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    CGFloat buttonW = (self.frame.size.width - (kEnglishColumn-1)*kKeyViewMarginH)/kEnglishColumn;
//    CGFloat buttonH = (self.frame.size.height - (kKBRow-1)*kKeyViewMarginV)/kKBRow;
//    CGFloat buttonX = 0;
//    CGFloat buttonY = 0;
//
//    NSUInteger totalCount = self.keyViews.count;
//    for (NSUInteger index = 0;index<totalCount;index++) {
//        UIButton *button = self.keyViews[index];
//        buttonY = (buttonH + kKeyViewMarginV) * (index/kEnglishColumn);
//
//        if (index/kEnglishColumn == 3) {
//            CGFloat buttonW1 = (self.frame.size.width - (kKeyViewMarginH + buttonW)* (totalCount-30-2)-kKeyViewMarginH)* 0.5;
//            if (index == 30) {
//                buttonX = 0;
//            }else if(index == totalCount-1){
//                buttonX = (buttonW1 - buttonW) + (kKeyViewMarginH + buttonW) * (index%kEnglishColumn);
//            }else {
//                buttonX = (buttonW1 - buttonW) + (kKeyViewMarginH + buttonW) * (index%kEnglishColumn);
//                buttonW1 = buttonW;
//            }
//            button.frame = CGRectMake(buttonX, buttonY, buttonW1, buttonH);
//        }else{
//            buttonX = (buttonW + kKeyViewMarginH) * (index%kEnglishColumn);
//            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        }
//    }
//}

@end
