//
//  UIDevice+PKExtension.m
//  
//
//  Created by 彭维剑 on 2018/5/8.
//

#import "UIDevice+Extension.h"
#import <sys/utsname.h>
/**
    // iPhone X
    @"iPhone10,3", @"iPhone10,6",
    // iPhone XS MAX, iPhone XS, iPhone XR
    @"iPhone11,2", @"iPhone11,4", @"iPhone11,6", @"iPhone11,8",
    // iPhone 11, iPhone 11 Pro, iPhone 11 Pro Max
    @"iPhone12,1", @"iPhone12,3", @"iPhone12,5",
    // iPhone 12 MINI, iPhone 12, iPhone 12 Pro, iPhone 12 Pro Max
    @"iPhone13,1", @"iPhone13,2", @"iPhone13,3", @"iPhone13,4",
 */
static NSDictionary <NSString *, id> * __devicesMap = nil;

#if TARGET_IPHONE_SIMULATOR
static CGSize __fringeScreenSizes[] = {
    {375.f, 812.f},{812.f, 375.f},/// iPhone X, iPhone XS, iPhone 12 Mini, iPhone 14, iPhone 15
    {414.f, 896.f},{896.f, 414.f},/// iPhone XR,iPhone XS MAX,iPhone 11, iPhone 11 Pro Max
    {390.f, 844.f},{844.f, 390.f},/// iPhone 12,iPhone 12 Pro, iPhone 13, iPhone 13 Pro
    {428.f, 926.f},{926.f, 428.f},/// iPhone 12 Pro MAX, iPhone 13 Pro MAX, iPhone 14 Plus, iPhone 15 Plus
    {393.f, 852.f},{852.f, 393.f},/// iPhone 14 Pro, iPhone 15 Pro, iPhone 16
    {402.f, 874.f},{874.f, 401.f},/// iPhone 16 Pro, iPhone 16 Pro Max,
    {430.f, 932.f},{932.f, 430.f},/// iPhone 14 Pro Max, iPhone 15 Pro Max, iPhone 16 Plus
};
#endif

@implementation UIDevice (WJExtension)

+ (void)initialize
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WJLicensePlateKeyboard.bundle/UIDeviceModel" ofType:@"plist"];
    __devicesMap = [NSDictionary dictionaryWithContentsOfFile:path];
}

+ (void)setupDeviceModelFile:(NSString *)path {
    BOOL isDir = NO;
    if (path.length && [NSFileManager.defaultManager fileExistsAtPath:path isDirectory:&isDir] && !isDir) {
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
        if (dict)  __devicesMap = dict;
    }
}

+ (void)setupDeviceModelDict:(NSDictionary *)dict {
    if (dict) __devicesMap = dict;
}

+ (NSString *)platformName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

+ (BOOL)isFringeScreen
{
    static BOOL result = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
#if TARGET_IPHONE_SIMULATOR //模拟器
    CGSize size = [UIScreen mainScreen].bounds.size;
    int cout = sizeof(__fringeScreenSizes) / sizeof(__fringeScreenSizes[0]);
    for (int i=0; i<cout; i++) {
        if (CGSizeEqualToSize(__fringeScreenSizes[i],size)) {
            result = YES;
            break;
        };
    }
#else // 真机
    NSString * hardware = [self platformName];
    for (NSString *str in __devicesMap[@"FringeDevices"]) {
        if ([hardware isEqualToString:str]) {
            result = YES;
            break;
        }
    }
#endif
    });
    return result;
}

+ (NSString *)deviceModel
{
    static NSString *name = nil;
    if (!name) {
        NSString * hardware = [self platformName];
        name = __devicesMap[@"AllDevices"][hardware];
        if (!name) name = hardware;
    }
    return name;
}
@end
