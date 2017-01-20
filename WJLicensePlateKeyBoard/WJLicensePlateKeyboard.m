//
//  WJLicensePlateKeyboard.m
//  WJLicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "WJLicensePlateKeyboard.h"
#import "WJLicensePlateEnglishView.h"
#import "WJLicensePlateProvinceView.h"
#import "WJLicensePlateKeyView.h"
#import "WJConst.h"

#define kScreenWidth UIScreen.mainScreen.bounds.size.width

@interface WJLicensePlateKeyboard ()<UIInputViewAudioFeedback,LicensePlateKBBaseViewDelegate>
/** 中文省份键盘 */
@property (nonatomic, weak) WJLicensePlateProvinceView *provinceView;
/** 英文字符数字键盘 */
@property (nonatomic, weak) WJLicensePlateEnglishView *englishView;
/** 当前显示的键盘 */
@property (nonatomic, weak) WJLicensePlateKBBaseView *currentKBBaseView;
/** 定时器  */
@property (nonatomic, strong) CADisplayLink *deleteBackwordLink;
/** 幂 */
@property (nonatomic, assign) NSUInteger power;

@end


@implementation WJLicensePlateKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect keyBoardFrame = CGRectMake(0, 0, kScreenWidth, kKBHeight);
    if (self = [super initWithFrame:keyBoardFrame]) {
        [self setupSubKeyBoardViews];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, kScreenWidth, kKBHeight);
    [self setupSubKeyBoardViews];
}
- (void)setupSubKeyBoardViews
{
    // 省份键盘
    WJLicensePlateProvinceView *provinceView = [[WJLicensePlateProvinceView alloc] init];
    [self addSubview:provinceView];
    provinceView.hidden = NO;
    _provinceView = provinceView;
    provinceView.delegate = self;
    
    // 英文数字键盘
    WJLicensePlateEnglishView *englishView = [[WJLicensePlateEnglishView alloc] init];
    englishView.hidden = YES;
    [self addSubview:englishView];
    _englishView = englishView;
    englishView.delegate = self;
    
    // 记录当前显示省份键盘
    _currentKBBaseView = provinceView;
    
    // 监听屏幕方向变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenOrientationDidChanged:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)setInputTextView:(UIView<UITextInput> *)inputTextView
{
    _inputTextView = inputTextView;
    
    if ([inputTextView isKindOfClass:[UITextView class]]){
        
        [(UITextView *)inputTextView setInputView:self];
    }else if ([inputTextView isKindOfClass:[UITextField class]]){
        
        [(UITextField *)inputTextView setInputView:self];
    }
}
- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    for (UIView *view in self.provinceView.keyViews) {
        if ([view isKindOfClass:[WJLicensePlateKeyView class]]) {
            WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
            keyView.titleFont = titleFont;
        }
    }
    for (UIView *view in self.englishView.keyViews) {
        if ([view isKindOfClass:[WJLicensePlateKeyView class]]) {
            WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
            keyView.titleFont = titleFont;
        }
    }
}

- (void)setPaopaoFont:(UIFont *)paopaoFont
{
    _paopaoFont = paopaoFont;
    for (UIView *view in self.provinceView.keyViews) {
        if ([view isKindOfClass:[WJLicensePlateKeyView class]]) {
            WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
            keyView.paopaoFont = paopaoFont;
        }
    }
    for (UIView *view in self.englishView.keyViews) {
        if ([view isKindOfClass:[WJLicensePlateKeyView class]]) {
            WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
            keyView.paopaoFont = paopaoFont;
        }
    }
}

- (CADisplayLink *)deleteBackwordLink
{
    if (!_deleteBackwordLink) {
        _deleteBackwordLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(startDeleteBackword)];
        _deleteBackwordLink.paused = YES;
        // 初始定时为0.2秒（1.0/60*12）
        _deleteBackwordLink.frameInterval = 12;
        [_deleteBackwordLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _deleteBackwordLink;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.provinceView.frame = CGRectInset(self.bounds, kKeyViewMarginH, kKeyViewMarginH);
    self.englishView.frame = CGRectInset(self.bounds, kKeyViewMarginH, kKeyViewMarginH);
}

#pragma mark - LicensePlateKBBaseViewDelegate
- (void)licensePlateKBBaseView:(WJLicensePlateKBBaseView *)kbBaseView didSwitch2KBType:(WJLicensePlateKeyboardType)switch2KBType playInput:(BOOL)playInput
{
    if (playInput) [[UIDevice currentDevice] playInputClick];

    switch (switch2KBType) {
        case WJLicensePlateKeyboardTypeEnglish:
            self.provinceView.hidden = YES;
            self.englishView.hidden = NO;
            _currentKBBaseView = self.englishView;
            break;
        case WJLicensePlateKeyboardTypeProvince:
            self.provinceView.hidden = NO;
            self.englishView.hidden = YES;
            _currentKBBaseView = self.provinceView;
            break;
        default:
            break;
    }
}
- (void)licensePlateKBBaseView:(WJLicensePlateKBBaseView *)kbBaseView didInsertText:(NSString *)text
{
    [self.inputTextView insertText:text];
}

- (void)licensePlateKBBaseViewStartDeleteBackward:(WJLicensePlateKBBaseView *)kbBaseView
{
    if(self.inputTextView.hasText && self._canDeleteBackword){
        self.deleteBackwordLink.paused = NO;
    }else{
        [[UIDevice currentDevice] playInputClick];
    }
}
- (void)licensePlateKBBaseViewEndDeleteBackward:(WJLicensePlateKBBaseView *)kbBaseView
{
    [self stopDeleteBackward];
}

- (void)licensePlateKBBaseViewDidFinish:(WJLicensePlateKBBaseView *)kbBaseView
{
    [[UIDevice currentDevice] playInputClick];
    [self.inputTextView resignFirstResponder];
}
#pragma mark - 定时器
- (void)startDeleteBackword
{
    [[UIDevice currentDevice] playInputClick];
    [_inputTextView deleteBackward];
    if(self.inputTextView.hasText && self._canDeleteBackword){
        // 0.2--0.183--0.166--0.15--0.083---0.05---0.033
        // 12----11----10----8-----4------3------1.5
        // 12--(12-2^0)--(12-2^1)---(12-2^2)----(12-2^3)----2
        if (_power > 3) {
            _deleteBackwordLink.frameInterval = 2;
        }else{
            _deleteBackwordLink.frameInterval = 12-powl(2,_power);
            _power++;
        }
    }else{
        [self stopDeleteBackward];
    }
}
- (void)stopDeleteBackward
{
    [_deleteBackwordLink invalidate];
    _deleteBackwordLink = nil;
    _power = 0;
}

// 是否可回删文字
- (BOOL)_canDeleteBackword
{
    // 选中的文字不为空，可直接删除
    BOOL empty = self.inputTextView.selectedTextRange.empty;
    if (!empty) return YES;
    UITextPosition *startP = self.inputTextView.selectedTextRange.start;
    UITextPosition *endP = self.inputTextView.selectedTextRange.end;
    if([startP isKindOfClass:NSClassFromString(@"_UITextKitTextPosition")]&&[endP isKindOfClass:NSClassFromString(@"_UITextKitTextPosition")]){
        long long startL = [[startP valueForKeyPath:@"_offset"] longLongValue];
        long long endL = [[endP valueForKeyPath:@"_offset"] longLongValue];
        //说明光标在（0，0）位置，没有可删除的
        return (0!=startL || 0!=endL);
    }else{
        return YES;
    }
}
#pragma mark - UIInputViewAudioFeedback
- (BOOL)enableInputClicksWhenVisible
{
    return YES;
}

- (void)screenOrientationDidChanged:(NSNotification *)note
{
    [self.currentKBBaseView handleRotateScreenOrOn2OffScreen];

//    LicensePlateKBBaseView *currentKBBaseView = self.currentKBBaseView;
//    currentKBBaseView.userInteractionEnabled = YES;
//    for (UIView *view in currentKBBaseView.keyViews) {
//        if ([view isKindOfClass:[WJLicensePlateKeyView class]]) {
//            WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
//            if (keyView.paopaoHidden == NO) {
//                keyView.paopaoHidden = YES;
//                break;
//            }
//        }
//    }
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self.currentKBBaseView handleRotateScreenOrOn2OffScreen];
//    LicensePlateKBBaseView *currentKBBaseView = self.currentKBBaseView;
//    currentKBBaseView.userInteractionEnabled = YES;
//    NSLog(@"%s---%@",__func__,newSuperview);
//    if (newSuperview) return;
//    for (UIView *view in currentKBBaseView.keyViews) {
//        if ([view isKindOfClass:[WJLicensePlateKeyView class]]) {
//            WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
//            if (keyView.paopaoHidden == NO) {
//                keyView.paopaoHidden = YES;
//                break;
//            }
//        }
//    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
