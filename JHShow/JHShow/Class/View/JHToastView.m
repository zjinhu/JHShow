//
//  JHToastView.m
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import "JHToastView.h"
#import <Masonry/Masonry.h>
#import <JHButton/JHButton.h>
#import "JHShowConfig.h"

@interface JHToastView ()
@property (nonatomic,strong)JHButton *toastButton;
@end

@implementation JHToastView

- (instancetype)init{
    if (self = [super init]) {

        UIView *bgView = [[UIView alloc] init];
        [self addSubview:bgView];
        bgView.backgroundColor = [JHShowConfig shared].toastBgColor;
        bgView.layer.cornerRadius = [JHShowConfig shared].toastCornerRadius;
        if ([JHShowConfig shared].toastShadowColor!=[UIColor clearColor]) {
            bgView.layer.shadowColor = [JHShowConfig shared].toastShadowColor.CGColor;
            bgView.layer.shadowOpacity = [JHShowConfig shared].toastShadowOpacity;
            bgView.layer.shadowRadius = [JHShowConfig shared].toastShadowRadius;
            bgView.layer.shadowOffset = CGSizeZero;
        }
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.equalTo(bgView.superview);
        }];
        
        _toastButton = [[JHButton alloc] initWithType:[JHShowConfig shared].toastType AndMarginArr:@[[NSNumber numberWithFloat:[JHShowConfig shared].toastSpace]]];
        _toastButton.backgroundColor = [UIColor clearColor];
        _toastButton.contentLabel.textColor = [JHShowConfig shared].toastTextColor;
        _toastButton.contentLabel.font = [JHShowConfig shared].toastTextFont;
        _toastButton.contentLabel.numberOfLines = 0;
        _toastButton.contentLabel.textAlignment =NSTextAlignmentCenter;
        [bgView addSubview:_toastButton];

        // 设置label的约束
        [_toastButton.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_lessThanOrEqualTo([JHShowConfig shared].toastMaxWidth);
        }];
        
        [_toastButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_toastButton.superview).offset([JHShowConfig shared].toastPadding);
            make.bottom.right.equalTo(_toastButton.superview).offset(-[JHShowConfig shared].toastPadding);
        }];
    }
    return self;
}
-(void)setText:(NSString *)text{
    _text= text;
    _toastButton.text = text;
}
-(void)setImage:(UIImage *)image{
    _image= image;
    _toastButton.image = image;
}
@end
