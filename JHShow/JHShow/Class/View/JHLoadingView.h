//
//  JHLoadingView.h
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHShowConfig.h"

@interface JHLoadingView : UIView
/** loading信息 */
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSArray *imageArray;
@end
