//
//  EnglishKeyboardView.m
//  WJLicensePlateKeyBoard
//
//  Created by Loyalwind on 2021/7/29.
//  Copyright © 2021 pengweijian. All rights reserved.
//

#import "EnglishKeyboardView.h"

@implementation EnglishKeyboardView

- (NSArray<NSString *> *)characters {
    if (!_characters) {
        _characters = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"P",
                        @"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",];
    }
    return _characters;
}

- (NSInteger)rows {
    return 3;
}

@end
