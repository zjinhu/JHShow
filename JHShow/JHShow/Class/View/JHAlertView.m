//
//  JHAlertView
//  JHShow
//
//  Created by 狄烨 . on 2018/12/26.
//  Copyright © 2018 HU. All rights reserved.
//

#import "JHAlertView.h"
#import "JHShowConfig.h"
#import <QuartzCore/QuartzCore.h>
#import <Masonry/Masonry.h>
#import <JHButton/JHButton.h>

static const CGFloat kButtonHeight = 50.0f;

@interface JHAlertView ()
@property (nonatomic, strong) JHButton *alertTitle;
@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UILabel *alertTitleLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;
@end

@implementation JHAlertView

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                  messageText:(id)message
              leftButtonTitle:(NSString *)leftTitle
             rightButtonTitle:(NSString *)rigthTitle{
    if (self = [super init]) {
        self.backgroundColor = [JHShowConfig shared].alertBgColor;
        
        UIView *bgView =[UIView new];
        bgView.layer.cornerRadius =[JHShowConfig shared].alertCornerRadius;
        bgView.layer.masksToBounds = YES;
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(bgView.superview);
            make.width.mas_equalTo([JHShowConfig shared].alertMaxWidth);
            make.height.mas_lessThanOrEqualTo([JHShowConfig shared].alertMaxHeight);
        }];
        
        _alertTitle = [[JHButton alloc] initWithType:JHImageButtonTypeTop AndMarginArr:@[@([JHShowConfig shared].alertSpace)]];
        _alertTitle.contentLabel.font = [JHShowConfig shared].alertTitleFont;
        _alertTitle.contentLabel.numberOfLines = 0;
        _alertTitle.imageView.contentMode =UIViewContentModeScaleToFill;
        _alertTitle.contentLabel.textAlignment = NSTextAlignmentCenter;
        _alertTitle.contentLabel.textColor = [JHShowConfig shared].alertTitleColor;
        _alertTitle.imageView.image =image;
        _alertTitle.contentLabel.text = title;
    
        [bgView addSubview:_alertTitle];
        [_alertTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgView.mas_top).offset(10);
            make.left.equalTo(bgView.mas_left);
            make.right.equalTo(bgView.mas_right);
        }];
       
        _alertContentLabel = [[UILabel alloc] init];
        _alertContentLabel.numberOfLines = 0;
        _alertContentLabel.textAlignment = NSTextAlignmentCenter;
        _alertContentLabel.textColor = [JHShowConfig shared].alertTextColor;
        _alertContentLabel.font = [JHShowConfig shared].alertTextFont;
        [bgView addSubview:_alertContentLabel];
        [_alertContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_alertTitle.mas_bottom).offset(10);
            make.left.equalTo(bgView.mas_left).offset(20);
            make.right.equalTo(bgView.mas_right).offset(-20);
        }];
        
        //保证_alertTitle 不被压缩，只压缩_alertContentLabel
        [_alertTitle setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisVertical];
        [_alertContentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
        
        if ([message isKindOfClass:[NSMutableAttributedString class]]) {
            _alertContentLabel.attributedText = message;
        }
        if ([message isKindOfClass:[NSString class]]) {
            _alertContentLabel.text = message;
        }
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = ColorFromName(0xe3e3e3);
        [bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_alertContentLabel.mas_bottom).offset(20);
            make.left.equalTo(bgView.mas_left);
            make.right.equalTo(bgView.mas_right);
            make.height.mas_equalTo((1 / [UIScreen mainScreen].scale));
        }];
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        _leftBtn.titleLabel.font = [JHShowConfig shared].alertButtonFont;
        [_leftBtn setTitleColor:[JHShowConfig shared].alertLeftColor forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_leftBtn];
        [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kButtonHeight);
            make.left.equalTo(bgView.mas_left);
            make.right.equalTo(bgView.mas_centerX);
            make.top.equalTo(lineView.mas_bottom);
        }];
        
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [JHShowConfig shared].alertButtonFont;
        [_rightBtn setTitleColor:[JHShowConfig shared].alertRightColor forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:_rightBtn];
        [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kButtonHeight);
            make.left.equalTo( leftTitle? bgView.mas_centerX :bgView.mas_left);
            make.right.equalTo(bgView.mas_right);
            make.top.equalTo(lineView.mas_bottom);
            make.bottom.equalTo(bgView.mas_bottom);
        }];
 
        UIView *vLineView = [[UIView alloc] init];
        vLineView.backgroundColor = ColorFromName(0xe3e3e3);
        [bgView addSubview:vLineView];
        [vLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_rightBtn.mas_top);
            make.centerX.equalTo(bgView.mas_centerX);
            make.bottom.equalTo(_rightBtn.mas_bottom);
            make.width.mas_equalTo((1 / [UIScreen mainScreen].scale));
        }];
        
        if (!leftTitle) {
            _leftBtn.hidden =YES;
            vLineView.hidden =YES;
        }else {
            _leftBtn.hidden =NO;
            vLineView.hidden =NO;
        }
    }
    return self;
}

- (void)dismissAlert
{
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

-(void)leftClick{
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
}

-(void)rightClick{
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
}

@end
