//
//  LicensePlateKeyView.m
//  LicensePlateKeyboard
//
//  Created by 彭维剑 on 2017/1/16.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "WJLicensePlateKeyView.h"
#import "WJConst.h"

#define kTitleFontSize 19.0
#define kPaoPaoFontSize 40.0

@interface WJLicensePlateKeyView ()
{
    UIFont *_titleFont;
    UIFont *_paopaoFont;
    // 文字颜色 （用于适配深色，浅色模式）
    UIColor *_titleTextColor;
    // 泡泡背景颜色 （用于适配深色，浅色模式）
    UIColor *_popBgColor;
}
/** titleLabel */
@property (nonatomic, weak) UILabel *titleLabel;
/** popLabel */
@property (nonatomic, strong) UILabel *popLabel;
@end

IB_DESIGNABLE

@implementation WJLicensePlateKeyView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupStyle];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupStyle];
}

- (void)setupStyle
{
    self.layer.cornerRadius = kPaopaoAndKeyViewCornerRedius;
    self.layer.masksToBounds = YES;
    self.clipsToBounds = NO;
    _paopaoHidden = YES;
    
    [self setupColor];
}

- (void)setupColor {
    if (@available(iOS 12.0, *)) {
        switch (self.traitCollection.userInterfaceStyle) {
            case UIUserInterfaceStyleDark:
                [self setupDarkModeColor];
                break;
            default:
                [self setupLightModeColor];
                break;
        }
    } else {
        [self setupLightModeColor];
    }
}

- (void)setupLightModeColor {
    self.backgroundColor = [UIColor whiteColor];
    _titleLabel.textColor = _titleTextColor = [UIColor blackColor];
    _popLabel.backgroundColor = _popBgColor = [UIColor colorWithWhite:0.95 alpha:1.0];
}

- (void)setupDarkModeColor {
    self.backgroundColor = [UIColor blackColor];
    _titleLabel.textColor = _titleTextColor = [UIColor whiteColor];
    _popLabel.backgroundColor = _popBgColor = [UIColor colorWithWhite:0.3 alpha:1.0];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = self.titleFont;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = _titleTextColor;
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:titleLabel];
        NSDictionary *views = @{@"titleLabel":titleLabel};
        NSArray *constraintHs = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleLabel]-0-|" options:kNilOptions metrics:nil views:views];
        NSArray *constraintVs = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[titleLabel]-0-|" options:kNilOptions metrics:nil views:views];
        [self addConstraints:constraintHs];
        [self addConstraints:constraintVs];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}
- (UILabel *)popLabel
{
    if (!_popLabel) {
        UILabel *popLabel = [[UILabel alloc] init];
        popLabel.text = self.titleLabel.text;
        popLabel.hidden = YES;
        popLabel.textAlignment = NSTextAlignmentCenter;
        popLabel.backgroundColor = _popBgColor;
        popLabel.layer.cornerRadius = kPaopaoAndKeyViewCornerRedius;
        popLabel.layer.masksToBounds = YES;
        popLabel.translatesAutoresizingMaskIntoConstraints = NO;
        popLabel.font = self.paopaoFont;
        [self addSubview:popLabel];
        // 宽度
        NSLayoutConstraint *popLabelW = [NSLayoutConstraint constraintWithItem:popLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:40];
        [popLabel addConstraint:popLabelW];
        // 高度
        NSLayoutConstraint *popLabelH = [NSLayoutConstraint constraintWithItem:popLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:kNilOptions multiplier:1.0 constant:60];
        [popLabel addConstraint:popLabelH];

        // 中心点 X
        NSLayoutConstraint *popLabelCenterX = [NSLayoutConstraint constraintWithItem:popLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0];
        [self addConstraint:popLabelCenterX];
        // 底部
        NSLayoutConstraint *popLabelBottom = [NSLayoutConstraint constraintWithItem:popLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
        [self addConstraint:popLabelBottom];
        _popLabel = popLabel;
    }
    return _popLabel;
}
- (void)setText:(NSString *)text
{
    _text = text;
    self.titleLabel.text = text;
    self.popLabel.text = text;
}
- (void)setPaopaoHidden:(BOOL)paopaoHidden
{
    _paopaoHidden = paopaoHidden;
    self.popLabel.hidden = paopaoHidden;
}
- (void)setTitleFont:(UIFont *)titleFont
{
    if (titleFont) {
        _titleFont = titleFont;
        self.titleLabel.font = titleFont;
    }else{
        UIFont *tempFont = [UIFont systemFontOfSize:kTitleFontSize];;
        _titleFont = tempFont;
        self.titleLabel.font = tempFont;
    }
}
- (UIFont *)titleFont
{
    return _titleFont?_titleFont:[UIFont systemFontOfSize:kTitleFontSize];
}

- (void)setPaopaoFont:(UIFont *)paopaoFont
{
    if (paopaoFont) {
        _paopaoFont = paopaoFont;
        _popLabel.font = paopaoFont;
    }else{
        UIFont *tempFont = [UIFont systemFontOfSize:kPaoPaoFontSize];;
        _popLabel.font = tempFont;
        _paopaoFont = tempFont;
    }
}
- (UIFont *)paopaoFont
{
    return _paopaoFont?_paopaoFont:[UIFont systemFontOfSize:kPaoPaoFontSize];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.paopaoHidden = NO;
    [[UIDevice currentDevice] playInputClick];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.paopaoHidden = YES;
    [super touchesEnded:touches withEvent:event];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    if (@available(iOS 12.0, *)) {
        [self setupColor];
    } else {
        [super traitCollectionDidChange:previousTraitCollection];
    }
}

@end
