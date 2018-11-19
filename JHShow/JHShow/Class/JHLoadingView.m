//
//  JHLoadingView.m
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import "JHLoadingView.h"
#import <Masonry/Masonry.h>
#import <JHButton/JHButton.h>
#import "JHShowConfig.h"

@interface JHLoadingView ()
@property (nonatomic,strong)JHButton *loadingButton;
@end

static JHLoadingView *loading;

@implementation JHLoadingView

+ (instancetype)shareLoading {
    if (loading == nil) {
        loading = [[JHLoadingView alloc] init];
    }
    return loading;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [JHShowConfig shared].loadingBgColor;
        
        //------- loading imageView -------//
        
        UIView *bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        bgView.backgroundColor = [JHShowConfig shared].loadingTintColor;
        bgView.layer.cornerRadius = [JHShowConfig shared].loadingCornerRadius;
        if ([JHShowConfig shared].loadingShadowColor!=[UIColor clearColor]) {
            bgView.layer.shadowColor = [JHShowConfig shared].loadingShadowColor.CGColor;
            bgView.layer.shadowOpacity = 0.5f;
            bgView.layer.shadowRadius = 5.f;
            bgView.layer.shadowOffset = CGSizeZero;
        }
        // 设置背景view的约束
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView.superview);
        }];
        
        _loadingButton = [[JHButton alloc] initWithType:[JHShowConfig shared].loadingType AndMarginArr:@[@0]];
        _loadingButton.backgroundColor = [UIColor clearColor];
        
        NSAssert([JHShowConfig shared].loadingImagesArray, @"you should set a image array!") ;
        UIImage *image = [JHShowConfig shared].loadingImagesArray.firstObject;
        _loadingButton.image = image;
        _loadingButton.imageView.animationImages = [JHShowConfig shared].loadingImagesArray;
        _loadingButton.imageView.animationDuration = [JHShowConfig shared].loadingAnimationTime;
        _loadingButton.imageView.animationRepeatCount = 0;
        [_loadingButton.imageView startAnimating];
        
        _loadingButton.contentLabel.textColor = [JHShowConfig shared].loadingTextColor;
        _loadingButton.contentLabel.font = [JHShowConfig shared].loadingTextFont;
        _loadingButton.contentLabel.numberOfLines = 0;
        _loadingButton.contentLabel.textAlignment =NSTextAlignmentCenter;
        [bgView addSubview:_loadingButton];
        
        // 设置背景view的约束
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView.superview);
        }];
        
        // 设置label的约束
        [_loadingButton.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo(130);
        }];
        
        [_loadingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_loadingButton.superview).offset(10);
            make.bottom.right.equalTo(_loadingButton.superview).offset(-10);
        }];
    }
    return self;
}

#pragma mark - 赋值
/** 赋值loading说明信息 */
- (void)setText:(NSString *)text{
    _text = text;
    _loadingButton.text = text;
}

@end
