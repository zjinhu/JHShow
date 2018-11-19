//
//  JHShowConfig.m
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import "JHShowConfig.h"

@implementation JHShowConfig

SingletonM(JHShowConfig)

- (instancetype)init{
    if (self = [super init]) {
        ///////////loading/////////////
        _loadingCornerRadius = 5;
        _loadingTintColor= [UIColor whiteColor];
        _loadingTextFont= [UIFont systemFontOfSize:15];
        _loadingTextColor= [UIColor blackColor];
        _loadingShadowColor= [UIColor clearColor];
        _loadingBgColor= [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
        _loadingAnimationTime = 0.5;
        _loadingType = JHImageButtonTypeTop;
        ////////////toast////////////////
        _toastShowTime =2;
        _toastCornerRadius = 5;
        _toastSpace = 5;
        _toastTextFont= [UIFont systemFontOfSize:15];
        _toastBgColor= [UIColor blackColor];
        _toastTextColor= [UIColor whiteColor];
        _toastType = JHImageButtonTypeTop;
    }
    return self ;
}
@end
