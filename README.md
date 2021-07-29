# WJLicensePlateKeyboard
自定义的车牌号码输入键盘，支持横竖屏模式，支持省份简称汉字，英文字母，数字的输入，输入时可以播放音效。


### 如何使用

```objc
#import "ViewController.h"
#import "WJLicensePlateKeyboard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField2;
@property (strong, nonatomic) WJLicensePlateKeyboard *keyBaord;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 方式1
    WJLicensePlateKeyboard *keyBaord = [[WJLicensePlateKeyboard alloc] init];
    
    // 方式2 自定义中英文字符集和顺序
    /*
    NSArray *chinese = @[@"警",@"宁",@"新",@"琼",@"皖",@"鄂",@"豫",@"陕",@"渝",@"粤",@"桂",@"吉",@"黑",@"鲁",
                         @"苏",@"冀",@"晋",@"赣",@"沪",@"京",@"津",@"辽",@"浙",@"湘",@"川",
                         @"云",@"贵",@"蒙",@"闽",@"甘",@"青",@"藏"];
    NSArray *english = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"P",
                         @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"X",@"B",@"N",@"M"];
    WJLicensePlateKeyboard *keyBaord = [[WJLicensePlateKeyboard alloc] initWithZhCharacters:chinese enCharacters:english];
    */
    
    // 方式3 自定义键盘
    /*
    WJLicensePlateProvinceView *provinceView = [[WJLicensePlateProvinceView alloc] init];
    // 继承关系：EnglishKeyboardView --> WJLicensePlateEnglishView --> WJLicensePlateKBBaseView
    EnglishKeyboardView *englishView = [[EnglishKeyboardView alloc] init];
    WJLicensePlateKeyboard *keyBaord = [[WJLicensePlateKeyboard alloc] initWithChineseView:provinceView englishView:englishView];
    */
    
    keyBaord.inputTextView = _inputField2;
    _keyBaord = keyBaord;
}
@end
```

+ 方式1.下载源码，把`WJLicensePlateKeyBoard`文件夹拖到项目中，
  + `Destination` 勾选 `Cope items if needed`
  + `Added folders` 选择 `Create groups`

+ 方式2. 通过 `Cocoapods` 安装

  ```ruby
  platform :ios, '8.0'
  target 'Your Target' do
  
  pod 'WJLicensePlateKeyboard'
  
  end
  ```

### 效果图

![竖屏](https://github.com/loyalwind/WJLicensePlateKeyboard/blob/master/demo/gif/portrait.gif)

![横屏](https://github.com/loyalwind/WJLicensePlateKeyboard/blob/master/demo/gif/landscape.gif)

