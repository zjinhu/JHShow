//
//  JHAlertView
//  JHShow
//
//  Created by 狄烨 . on 2018/12/26.
//  Copyright © 2018 HU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHAlertView : UIView
/**
 有图片有内容有标题的弹窗
 */
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                  messageText:(id)message
              leftButtonTitle:(NSString *)leftTitle
             rightButtonTitle:(NSString *)rigthTitle;


@property (nonatomic, strong) dispatch_block_t leftBlock;
@property (nonatomic, strong) dispatch_block_t rightBlock;
@property (nonatomic, strong) dispatch_block_t dismissBlock;

@end

