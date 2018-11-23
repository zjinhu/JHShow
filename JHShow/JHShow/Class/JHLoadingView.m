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

@interface JHLoadingView ()
@property (nonatomic,strong)JHButton *loadingButton;
@end

@implementation JHLoadingView

SingletonM(JHLoadingView)

- (instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [JHShowConfig shared].loadingBgColor;
        //------- loading imageView -------//
        UIView *bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        bgView.backgroundColor = [JHShowConfig shared].loadingTintColor;
        bgView.layer.cornerRadius = [JHShowConfig shared].loadingCornerRadius;
        if ([JHShowConfig shared].loadingShadowColor!=[UIColor clearColor]) {
            bgView.layer.shadowColor = [JHShowConfig shared].loadingShadowColor.CGColor;
            bgView.layer.shadowOpacity = [JHShowConfig shared].loadingShadowOpacity;
            bgView.layer.shadowRadius = [JHShowConfig shared].loadingShadowRadius;
            bgView.layer.shadowOffset = CGSizeZero;
        }
        // 设置背景view的约束
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView.superview);
        }];
        
        _loadingButton = [[JHButton alloc] initWithType:[JHShowConfig shared].loadingType AndMarginArr:@[[NSNumber numberWithFloat:[JHShowConfig shared].loadingSpace]]];
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
            make.width.mas_lessThanOrEqualTo([JHShowConfig shared].loadingMaxWidth);
        }];
        
        [_loadingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_loadingButton.superview).offset([JHShowConfig shared].loadingVerticalPadding);
            make.left.equalTo(_loadingButton.superview).offset([JHShowConfig shared].loadingHorizontalPadding);
            make.bottom.equalTo(_loadingButton.superview).offset(-[JHShowConfig shared].loadingVerticalPadding);
            make.right.equalTo(_loadingButton.superview).offset(-[JHShowConfig shared].loadingHorizontalPadding);
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
