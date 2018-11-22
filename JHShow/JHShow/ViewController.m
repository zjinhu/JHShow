//
//  ViewController.m
//  JHShow
//
//  Created by 狄烨 . on 2018/11/19.
//  Copyright © 2018 狄烨 . All rights reserved.
//

#import "ViewController.h"
#import "JHShow.h"
#import "JHShowConfig.h"
#import "JHPopView.h"

@interface ViewController ()
@property (nonatomic ,strong) UIView *popView;
@property (nonatomic ,strong) UIView *coverView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    

    
    JHShowConfig *config = [JHShowConfig shared];
    config.loadingImagesArray = [self getImageArray];
    config.loadingType = JHImageButtonTypeRight;
    config.toastType = JHImageButtonTypeBottom;
    config.loadingShadowColor = [UIColor redColor];
    config.toastShadowColor = [UIColor purpleColor];
    
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn1];
    btn1.tag = 1;
    btn1.frame = CGRectMake(10, 100, 100, 44);
    [btn1 setTitle:@"loading text" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn2];
    btn2.tag = 2;
    btn2.frame = CGRectMake(180, 100, 80, 44);
    [btn2 setTitle:@"hid loading" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn3];
    btn3.tag = 3;
    btn3.frame = CGRectMake(10, 160, 80, 44);
    [btn3 setTitle:@"toast" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn4];
    btn4.tag = 4;
    btn4.frame = CGRectMake(50, 200, 80, 44);
    [btn4 setTitle:@"loading" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn5 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn5];
    btn5.tag = 5;
    btn5.frame = CGRectMake(160, 200, 100, 44);
    [btn5 setTitle:@"toast image" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn6 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn6];
    btn6.tag = 6;
    btn6.frame = CGRectMake(160, 300, 100, 44);
    [btn6 setTitle:@"pop" forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn7 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:btn7];
    btn7.tag = 7;
    btn7.frame = CGRectMake(160, 350, 100, 44);
    [btn7 setTitle:@"pop" forState:UIControlStateNormal];
    [btn7 addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)backButtonClicked:(UIButton *)btn {

    switch (btn.tag) {
        case 1:
            [JHShow showLoadingEventText:@"asdfasdfasdfasdfads"];
            break;
        case 2:
            [JHShow hidenLoading];
            break;
        case 3:
            [JHShow showText:@"asdfasdfasdfasdfsadfdfsdfsdfads"];
            break;
        case 4:
            [JHShow showLoading];
            break;
        case 5:
            [JHShow showText:@"qweqweqwe" withImage:[UIImage imageNamed:@"icon_kangaroo_global_loading_0"]];
            break;
        case 6:{
            [JHShow showPopView:self.coverView showType:PopViewShowTypeRight];
            break;}
        case 7:{
            [JHShow showPopViewCenter:self.popView animsted:YES];

            break;}
        default:
            break;
    }
}

-(NSMutableArray *)getImageArray{
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i = 0; i<15; i++) {
        NSString *imageName = [NSString stringWithFormat:@"icon_kangaroo_global_loading_%ld",(long)i];
        [array addObject:[UIImage imageNamed:imageName]];
    }
    return array;
}

-(UIView *)popView{
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
        _popView.backgroundColor = UIColor.purpleColor;
    }
    return _popView;
}
-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] initWithFrame:CGRectMake(10, 60, 300, 100)];
        _coverView.backgroundColor = UIColor.yellowColor;
    }
    return _coverView;
}

@end
