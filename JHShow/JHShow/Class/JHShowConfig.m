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
        _loadingMaxWidth = 130;
        _loadingCornerRadius = 5;
        _loadingTintColor= [UIColor whiteColor];
        _loadingTextFont= [UIFont systemFontOfSize:15];
        _loadingTextColor= [UIColor blackColor];
        _loadingShadowColor= [UIColor clearColor];
        _loadingShadowOpacity =0.5;
        _loadingShadowRadius = 5;
        _loadingBgColor= [[UIColor blackColor] colorWithAlphaComponent:0.2];
        _loadingAnimationTime = 0.5;
        _loadingType = JHImageButtonTypeTop;
        _loadingVerticalPadding = 10;
        _loadingHorizontalPadding = 10;
        _loadingSpace = 0;
        ////////////toast////////////////
        _toastShowTime =2;
        _toastCornerRadius = 5;
        _toastSpace = 5;
        _toastTextFont= [UIFont systemFontOfSize:15];
        _toastBgColor= [UIColor blackColor];
        _toastShadowColor= [UIColor clearColor];
        _toastShadowOpacity = 0.5;
        _toastShadowRadius = 5;
        _toastTextColor= [UIColor whiteColor];
        _toastType = JHImageButtonTypeTop;
        _toastMaxWidth = 200;
        _toastPadding = 10;
        
    }
    return self ;
}
@end
