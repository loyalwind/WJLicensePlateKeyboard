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
    
    WJLicensePlateKeyboard *keyBaord = [[WJLicensePlateKeyboard alloc] init];
    keyBaord.inputTextView = _inputField2;
    _keyBaord = keyBaord;

    WJLicensePlateKeyView *keyView = [[WJLicensePlateKeyView alloc] init];
    keyView.backgroundColor = [UIColor greenColor];
    keyView.frame = CGRectMake(30, 150, 45, 45);
    keyView.text = @"湘";
    [self.view addSubview:keyView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // Dispose of any resources that can be recreated.
    [self.view endEditing:YES];
}

@end
