//
//  WJLicensePlateKBaseView.m
//  WJLicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/17.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "WJLicensePlateKBBaseView.h"
#import "WJLicensePlateKeyView.h"
#import "WJConst.h"

@interface WJLicensePlateKBBaseView ()
{
    /** 按钮集合  */
    NSMutableArray <__kindof UIView *> *_keyViews;
}
/** 当前显示的按键 view */
@property (nonatomic, weak) WJLicensePlateKeyView *currentKeyView;
@end

@implementation WJLicensePlateKBBaseView
- (instancetype)initWithCharacters:(NSArray<NSString *> *)characters {
    _characters = characters;
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupKeyViews];
    }
    return self;
}

- (void)setupKeyViews {
    NSUInteger totalCharacter = self.characters.count;
    NSInteger rows = self.rows;
    NSInteger colunms = self.columns;
    _keyViews = [NSMutableArray array];
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"WJLicensePlateKeyboard.bundle" ofType:nil];
    for (NSUInteger index = 0; index < totalCharacter; index++) {
        NSString *character = self.characters[index];
        WJLicensePlateKeyView *keyView = [[WJLicensePlateKeyView alloc] init];
        keyView.titleLabel.text = character;
        [self addSubview:keyView];
        [_keyViews addObject:keyView];
        
        if (index == colunms * (rows-1)-2) { // 删除按钮、切换输入按钮
            NSString *fileName = [NSString stringWithFormat:@"%@/icon_delete",bundle];
            UIButton *delButton = [self createButtonWithTitle:nil imageName:fileName];
            delButton.tag = WJFunctionButtonTypeDelete;
            [delButton addTarget:self action:@selector(functionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
            [delButton addTarget:self action:@selector(functionButtonTouchDown:) forControlEvents:UIControlEventTouchDown];

            [_keyViews addObject:delButton];
            [self addSubview:delButton];
            
            UIButton *switchButton = [self createButtonWithTitle:self.switchText imageName:nil];
            [switchButton addTarget:self action:@selector(functionButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
            switchButton.tag = WJFunctionButtonTypeSwitch;
            [_keyViews addObject:switchButton];
            [self addSubview:switchButton];
            
        }else if (index == totalCharacter-1) {
            
            UIButton *doneButton = [self createButtonWithTitle:self.doneText imageName:nil];
            [doneButton addTarget:self action:@selector(functionButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
            
            doneButton.tag = WJFunctionButtonTypeFinish;
            [_keyViews addObject:doneButton];
            [self addSubview:doneButton];
        }
    }
}
- (void)setCharacters:(NSArray<NSString *> *)characters {
    if ([self needResetCharacters:characters]) {
        _characters = characters;
        
        // 移除旧的的
        for (UIView *view in _keyViews) {
            [view removeFromSuperview];
        }
        [_keyViews removeAllObjects];
        
        // 重新创建新的
        [self setupKeyViews];
    }
}


- (BOOL)needResetCharacters:(NSArray<NSString *> *)characters {
    NSInteger count1 = characters.count;
    NSInteger count2 = _characters.count;
    if (count1 == 0 || count2 == 0 || (count1 != count2)) {
        return YES;
    }
    
    BOOL needReset = NO; // 是否需要重置
    for (int i = 0; i < count1; i++) {
        if (characters[i] != _characters[i]) { // 内容相同
            needReset = YES;
            break;
        }
    }
        
    return needReset;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger column = self.columns;
    NSInteger rows = self.rows;

    if (column<3 || rows <3)return;
    
    CGFloat viewW = (self.frame.size.width - (column-1)*kKeyViewMarginH)/column;
    CGFloat viewH = (self.frame.size.height - (rows-1)*kKeyViewMarginV)/rows;
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    NSUInteger totalCount = self.keyViews.count;
    for (NSUInteger index = 0;index<totalCount;index++) {
        
        UIView *view = self.keyViews[index];
        viewY = (viewH + kKeyViewMarginV) * (index/column);
        
        if (index/column == 3) {
            CGFloat viewW1 = (self.frame.size.width - (kKeyViewMarginH + viewW)*(totalCount-(rows-1)*column-2)-kKeyViewMarginH)* 0.5;
            if (index == (rows-1)*column) {
                viewX = 0;
            }else if(index == totalCount-1){
                viewX = (viewW1 - viewW) + (kKeyViewMarginH + viewW) * (index%column);
            }else {
                viewX = (viewW1 - viewW) + (kKeyViewMarginH + viewW) * (index%column);
                viewW1 = viewW;
            }
            view.frame = CGRectMake(viewX, viewY, viewW1, viewH);
        }else{
            viewX = (viewW + kKeyViewMarginH) * (index%column);
            view.frame = CGRectMake(viewX, viewY, viewW, viewH);
        }
    }
}

#pragma mark - ButtonAction
- (void)functionButtonTouchUpInside:(UIButton *)button
{
    if (WJFunctionButtonTypeDelete == button.tag) {
        if([self.delegate respondsToSelector:@selector(licensePlateKBBaseViewEndDeleteBackward:)]){
            [self.delegate licensePlateKBBaseViewEndDeleteBackward:self];
        }
    }
}

- (void)functionButtonTouchDown:(UIButton *)button
{
    if (WJFunctionButtonTypeDelete == button.tag) {
        if([self.delegate respondsToSelector:@selector(licensePlateKBBaseViewStartDeleteBackward:)]){
            [self.delegate licensePlateKBBaseViewStartDeleteBackward:self];
        }
    }else if (WJFunctionButtonTypeSwitch == button.tag){
        if([self.delegate respondsToSelector:@selector(licensePlateKBBaseView:didSwitch2KBType:playInput:)]){
            [self.delegate licensePlateKBBaseView:self didSwitch2KBType:self.switch2KeyBoardType playInput:YES];
        }
    }else if (WJFunctionButtonTypeFinish == button.tag){
        if([self.delegate respondsToSelector:@selector(licensePlateKBBaseViewDidFinish:)]){
            [self.delegate licensePlateKBBaseViewDidFinish:self];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.userInteractionEnabled = NO;
    CGPoint location = [touches.anyObject locationInView:self];
    
    for (UIView *view in self.keyViews) {
        //  不是这种按键类型，直接下一次循环
        if (![view isKindOfClass:WJLicensePlateKeyView.class]) continue;
      
        if(CGRectContainsPoint(view.frame, location)){
            self.currentKeyView = (WJLicensePlateKeyView *)view;
            break;
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint location = [touches.anyObject locationInView:self];
    for (UIView *view in self.keyViews) {
        //  不是这种按键类型，直接下一次循环
        if (![view isKindOfClass:WJLicensePlateKeyView.class]) continue;
        WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
        // 当前移动触摸点在按键上，就进行显示 paopao
        if(CGRectContainsPoint(keyView.frame, location)){
            keyView.paopaoHidden = NO;
            self.currentKeyView = keyView;
        }else{
            if (keyView.paopaoHidden == NO){
                keyView.paopaoHidden = YES;
            }
        }
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 插入文字处理，方式1和方式2都可以，不过方式1更靠谱些，
    // 方式1
    for (UIView *view in self.keyViews) {
        //  不是这种按键类型，直接下一次循环
        if (![view isKindOfClass:WJLicensePlateKeyView.class])continue;
        WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
        // 当前按键的paopao 是没有隐藏，就进行隐藏
        if (keyView.paopaoHidden == NO){
            keyView.paopaoHidden = YES;
        }
        if(self.currentKeyView.isPaopaoHidden == NO){
            self.currentKeyView.paopaoHidden = YES;
        }
        // 当前结束触摸点在按键上，就进行插入文字处理
        CGPoint location = [touches.anyObject locationInView:self];
        if (CGRectContainsPoint(keyView.frame, location)){
            if([self.delegate respondsToSelector:@selector(licensePlateKBBaseView:didInsertText:)]){
                [self.delegate licensePlateKBBaseView:self didInsertText:keyView.titleLabel.text];
            }
            break;
        }
    }
    // 方式2
//    CGPoint location = [touches.anyObject locationInView:self.currentKeyView];
//    if (CGRectContainsPoint(self.currentKeyView.bounds, location)){
//        self.currentKeyView.paopaoHidden = YES;
//        if([self.delegate respondsToSelector:@selector(licensePlateKBBaseView:didInsertText:)]){
//            [self.delegate licensePlateKBBaseView:self didInsertText:self.currentKeyView.titleLabel.text];
//        }
//    }
    
    // 是否需要切换键盘
    if (self.needSwitchKBAfterTouchEnd) {
        if([self.delegate respondsToSelector:@selector(licensePlateKBBaseView:didSwitch2KBType:playInput:)]){
            [self.delegate licensePlateKBBaseView:self didSwitch2KBType:WJLicensePlateKeyboardTypeEnglish playInput:NO];
        }
    }
    self.userInteractionEnabled = YES;
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
{
    CGPoint location = [touches.anyObject locationInView:self];

    NSLog(@"%s",__func__);
    for (UIView *view in self.keyViews) {
        if ([view isKindOfClass:WJLicensePlateKeyView.class] && CGRectContainsPoint(view.frame, location)){
            WJLicensePlateKeyView *keyView = (WJLicensePlateKeyView *)view;
            if (keyView.paopaoHidden == NO){
                keyView.paopaoHidden = YES;
                break;
            }
        }
    }
    self.userInteractionEnabled = YES;
}

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
- (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    NSString *lightImgName = [imageName stringByAppendingString:@"_highlight"];
    [button setImage:[UIImage imageNamed:lightImgName] forState:UIControlStateHighlighted];

    [button setBackgroundImage:[self imageFromColor:UIColor.lightGrayColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[self imageFromColor:UIColor.whiteColor] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    button.titleLabel.adjustsFontSizeToFitWidth = YES;
    button.layer.cornerRadius = kPaopaoAndKeyViewCornerRedius;
    button.layer.masksToBounds = YES;
    return button;
}

- (void)handleRotateScreenOrOn2OffScreen
{
    if (self.currentKeyView.paopaoHidden == NO) {
        self.currentKeyView.paopaoHidden = YES;
    }
    self.userInteractionEnabled = YES;
}
- (NSArray <NSString *> *)characters
{
    return nil;
}

- (NSString *)doneText {
    return @"完成";
}
- (NSString *)switchText {
    return @"切换";
}
- (NSInteger)rows
{
    return -1;
}
- (NSInteger)columns
{
    return -1;
}
- (WJLicensePlateKeyboardType)switch2KeyBoardType
{
    return WJLicensePlateKeyboardTypeProvince;
}
- (BOOL)needSwitchKBAfterTouchEnd
{
    return NO;
}
@end
