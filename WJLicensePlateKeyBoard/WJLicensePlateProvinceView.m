//
//  WJLicensePlateProvinceView.m
//  WJLicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "WjLicensePlateProvinceView.h"
#import "WJLicensePlateKeyView.h"
#import "WJConst.h"

@interface WJLicensePlateProvinceView ()
/** 英文字符集  */
@property (nonatomic, strong) NSArray <NSString *> *characters;

@end

@implementation WJLicensePlateProvinceView
@synthesize characters = _characters;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *button = [self viewWithTag:WJFunctionButtonTypeSwitch];
        [button setTitle:@"英文" forState: UIControlStateNormal];
    }
    return self;
}
- (NSArray<NSString *> *)characters
{
    if (!_characters) {
        _characters = @[@"琼",@"皖",@"鄂",@"豫",@"陕",@"渝",@"粤",@"桂",@"吉",@"黑",@"鲁",@"苏",@"冀",@"晋",@"赣",@"沪",@"京",@"津",@"辽",@"浙",@"湘",@"川",@"云",@"贵",@"蒙",@"闽",@"甘",@"青",@"宁",@"新",@"藏",@"警"];
    }
    return _characters;
}
- (NSInteger)rows
{
    return kKBRow;
}
- (NSInteger)columns
{
    return kProvinceColumn;
}
- (WJLicensePlateKeyboardType)switch2KeyBoardType
{
    return WJLicensePlateKeyboardTypeEnglish;
}
- (BOOL)needSwitchKBAfterTouchEnd
{
    return YES;
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//
//    CGFloat buttonW = (self.frame.size.width - (kProvinceColumn-1)*kKeyViewMarginH)/kProvinceColumn;
//    CGFloat buttonH = (self.frame.size.height - (kKBRow-1)*kKeyViewMarginV)/kKBRow;
//    CGFloat buttonX = 0;
//    CGFloat buttonY = 0;
//    
//    NSUInteger totalCount = self.keyViews.count;
//    for (NSUInteger index = 0;index<totalCount;index++) {
//        UIButton *button = self.keyViews[index];
//        buttonY = (buttonH + kKeyViewMarginV) * (index/kProvinceColumn);
//        
//        if (index/kProvinceColumn == 3) {
//            CGFloat buttonW1 = (self.frame.size.width - (kKeyViewMarginH + buttonW)* (totalCount-27-2)-kKeyViewMarginH)* 0.5;
//            if (index == 27) {
//                buttonX = 0;
//            }else if(index == totalCount-1){
//                buttonX = (buttonW1 - buttonW) + (kKeyViewMarginH + buttonW) * (index%kProvinceColumn);
//            }else {
//                buttonX = (buttonW1 - buttonW) + (kKeyViewMarginH + buttonW) * (index%kProvinceColumn);
//                buttonW1 = buttonW;
//            }
//            button.frame = CGRectMake(buttonX, buttonY, buttonW1, buttonH);
//        }else{
//            buttonX = (buttonW + kKeyViewMarginH) * (index%kProvinceColumn);
//            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        }
//    }
//}
//

@end
