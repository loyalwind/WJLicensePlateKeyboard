//
//  ViewController.m
//  ProvinceKeyBoard
//
//  Created by 彭维剑 on 2017/1/20.
//  Copyright © 2017年 pengweijian. All rights reserved.
//

#import "ViewController.h"
#import "WJLicensePlateKeyboard.h"
#import "WJLicensePlateKeyView.h"
#import "EnglishKeyboardView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UITextField *inputField2;
@property (weak, nonatomic) IBOutlet UITextField *inputField3;
@property (strong, nonatomic) WJLicensePlateKeyboard *keyBaord;
@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) CGFloat paopaoFontSize;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test1];
    [self test2];
//    [self test3];
    
    WJLicensePlateKeyView *keyView = [[WJLicensePlateKeyView alloc] init];
    keyView.backgroundColor = [UIColor greenColor];
    keyView.frame = CGRectMake(30, 150, 45, 45);
    keyView.text = @"湘";
    [self.view addSubview:keyView];
}

- (void)test1 {
    WJLicensePlateKeyboard *keyBaord = [[WJLicensePlateKeyboard alloc] init];
    keyBaord.inputTextView = _inputField2;
    _keyBaord = keyBaord;
}

- (void)test2 {
    
    NSArray *chinese = @[@"警",@"宁",@"新",@"琼",@"皖",@"鄂",@"豫",@"陕",@"渝",@"粤",@"桂",@"吉",@"黑",@"鲁",
                         @"苏",@"冀",@"晋",@"赣",@"沪",@"京",@"津",@"辽",@"浙",@"湘",@"川",
                         @"云",@"贵",@"蒙",@"闽",@"甘",@"青",@"藏"];
    NSArray *english = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"P",
                         @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"X",@"B",@"N",@"M"];
//    WJLicensePlateKeyboard *keyBaord = [[WJLicensePlateKeyboard alloc] init];
//    [keyBaord setChineseCharacters:chinese];
//    [keyBaord setEnglishCharacters:english];
    WJLicensePlateKeyboard *keyBaord = [[WJLicensePlateKeyboard alloc] initWithZhCharacters:chinese enCharacters:english];
    [keyBaord setChineseCharacters:chinese];
    [keyBaord setEnglishCharacters:english];
    keyBaord.inputTextView = _inputField2;
    _keyBaord = keyBaord;
}

- (void)test3 {
    WJLicensePlateProvinceView *provinceView = [[WJLicensePlateProvinceView alloc] init];
    EnglishKeyboardView *englishView = [[EnglishKeyboardView alloc] init];
    WJLicensePlateKeyboard *keyBaord = [[WJLicensePlateKeyboard alloc] initWithChineseView:provinceView englishView:englishView];
    keyBaord.inputTextView = _inputField2;
    _keyBaord = keyBaord;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // Dispose of any resources that can be recreated.
    [self.view endEditing:YES];
}

@end
