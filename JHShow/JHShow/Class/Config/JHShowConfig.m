//
//  JHShowConfig.m
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import "JHShowConfig.h"

@implementation JHShowConfig

static JHShowConfig *_showInstance;

+ (instancetype)shared {
    if (nil == _showInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _showInstance = [[JHShowConfig alloc] init];
        });
    }
    return _showInstance;
}

- (instancetype)init{
    if (self = [super init]) {
        ///////////loading/////////////
        _loadingMaxWidth = 130;
        _loadingMaxHeight = 130;
        _loadingCornerRadius = 5;
        _loadingTintColor= [UIColor whiteColor];
        _loadingTextFont= [UIFont systemFontOfSize:15];
        _loadingTextColor= [UIColor blackColor];
        _activityColor = [UIColor blackColor];
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
        _toastMaxHeight = 500;
        _toastPadding = 10;
        ////////////alert////////////////
        _alertMaxWidth = 280;
        _alertMaxHeight = 500;
        _alertCornerRadius = 5;
        _alertType = JHImageButtonTypeTop;
        _alertSpace = 5;
        _alertTitleFont = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
        _alertTitleColor = [UIColor blackColor];
        _alertTextFont = [UIFont systemFontOfSize:15];
        _alertTextColor = [UIColor blackColor];
        _alertButtonFont= [UIFont systemFontOfSize:17];
        _alertLeftColor= [UIColor blackColor];
        _alertRightColor= [UIColor blackColor];
        _alertBgColor= [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _alertShadowColor= [UIColor clearColor];
        _alertShadowOpacity = 0.5;
        _alertShadowRadius = 5;
        
    }
    return self ;
}
@end
