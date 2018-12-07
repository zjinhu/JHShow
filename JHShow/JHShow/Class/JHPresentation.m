//
//  JHPresentation.m
//  JHShow
//
//  Created by 狄烨 . on 2018/12/7.
//  Copyright © 2018 狄烨 . All rights reserved.
//
#import "JHShowConfig.h"
#import "JHPresentation.h"
#import "JHPopViewController.h"
#import "UIApplication+GetRootVC.h"
@interface JHPresentation () <UIViewControllerAnimatedTransitioning>
@property(nonatomic, assign) BOOL isAnimating; // 响应键盘动画中
/** 蒙板 */
@property(nonatomic, strong) UIView *coverView;
/// 辅助pop控制器
@property (nonatomic, weak) JHPopViewController *toVc;
@property(nonatomic, strong) UIView *popView;
@property(nonatomic, assign) CGRect popViewFrame;///记录最终正常位置

@property(nonatomic, assign) PresentationType showType; // 响应键盘动画中
@end

@implementation JHPresentation
+ (instancetype)showView:(UIView *)popView{
    UIViewController *topVc = [[UIApplication sharedApplication] currentViewController];
    
    JHPopViewController *toVc = [[JHPopViewController alloc] init];
    [popView layoutIfNeeded];
    toVc.popView = popView;
    
    JHPresentation *pt= [[JHPresentation alloc] initWithPresentedViewController:toVc
                                                         presentingViewController:topVc];
    
    pt.allowObserverForKeyBoard = YES;
    pt.transitionDuration = 0.5;
    pt.allowTapDismiss = YES;
    pt.toVc = toVc;
    pt.popView =popView;
    [topVc presentViewController:toVc animated:YES completion:nil];
    return pt;
}
+ (instancetype)showView:(UIView *)contentView withShowType:(PresentationType)type{
    UIViewController *topVc = [[UIApplication sharedApplication] currentViewController];
    
    JHPopViewController *toVc = [[JHPopViewController alloc] init];
    [contentView layoutIfNeeded];
    toVc.popView = contentView;
    
    JHPresentation *pt= [[JHPresentation alloc] initWithPresentedViewController:toVc
                                                         presentingViewController:topVc];
    
    pt.allowObserverForKeyBoard = YES;
    pt.transitionDuration = 0.5;
    pt.allowTapDismiss = YES;
    pt.toVc = toVc;
    pt.popView =contentView;
    pt.showType = type;
    [topVc presentViewController:toVc animated:YES completion:nil];
    return pt;
}
#pragma mark - Actions
- (void)tap:(UITapGestureRecognizer *)tap {
    if (self.allowTapDismiss) {
        [self dismiss];
    }
}

- (void)dismiss {
    [self.presentedViewController dismissViewControllerAnimated:YES completion:_hiddenPresentation];
}

//| ------------------------------第一步内容----------------------------------------------
#pragma mark - UIViewControllerTransitioningDelegate
/*
 * 来告诉控制器，谁是动画主管(UIPresentationController)，因为此类继承了UIPresentationController，就返回了self
 */
- (UIPresentationController* )presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return self;
}

// 返回的对象控制Presented时的动画 (开始动画的具体细节负责类)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}
// 由返回的控制器控制dismissed时的动画 (结束动画的具体细节负责类)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}
//| ------------------------------第二步内容----------------------------------------------
#pragma mark - 重写UIPresentationController个别方法
// 默认方法
- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController];
    if (self) {
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        presentedViewController.transitioningDelegate = self;
    }
    return self;
}

- (void)presentationTransitionWillBegin{
    _coverView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    _coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [_coverView addGestureRecognizer:tap];
    [self.containerView addSubview:_coverView]; // 添加到动画容器View中。
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    self.coverView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.coverView.alpha = 0.5f;
    } completion:nil];
}

- (void)presentationTransitionDidEnd:(BOOL)completed{
    if (completed == NO){
        [self.coverView removeFromSuperview];
        self.coverView = nil;
    }
}

- (void)dismissalTransitionWillBegin{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.coverView.alpha = 0.f;
    } completion:nil];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed{
    if (completed == YES){
        [self.coverView removeFromSuperview];
        self.coverView = nil;
    }
}
//| --------以下四个方法，是按照苹果官方Demo里的，都是为了计算目标控制器View的frame的----------------
//  当 presentation controller 接收到
//  -viewWillTransitionToSize:withTransitionCoordinator: message it calls this
//  method to retrieve the new size for the presentedViewController's view.
//  The presentation controller then sends a
//  -viewWillTransitionToSize:withTransitionCoordinator: message to the
//  presentedViewController with this size as the first argument.
//
//  Note that it is up to the presentation controller to adjust the frame
//  of the presented view controller's view to match this promised size.
//  We do this in -containerViewWillLayoutSubviews.
//
- (CGSize)sizeForChildContentContainer:(id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize{
    if (container == self.presentedViewController){
        return ((UIViewController*)container).preferredContentSize;
    }else{
        return [super sizeForChildContentContainer:container withParentContainerSize:parentSize];
    }
}

//在我们的自定义呈现中，被呈现的 view 并没有完全完全填充整个屏幕，
//被呈现的 view 的过渡动画之后的最终位置，是由 UIPresentationViewController 来负责定义的。
//我们重载 frameOfPresentedViewInContainerView 方法来定义这个最终位置
- (CGRect)frameOfPresentedViewInContainerView{
    CGRect containerViewBounds = self.containerView.bounds;
    CGSize presentedViewContentSize = [self sizeForChildContentContainer:self.presentedViewController withParentContainerSize:containerViewBounds.size];
    
    // The presented view extends presentedViewContentSize.height points from
    // the bottom edge of the screen.
    CGRect presentedViewControllerFrame = containerViewBounds;
    presentedViewControllerFrame.size.height = presentedViewContentSize.height;
    presentedViewControllerFrame.origin.y = CGRectGetMaxY(containerViewBounds) - presentedViewContentSize.height;
    return presentedViewControllerFrame;
}

//  This method is similar to the -viewWillLayoutSubviews method in
//  UIViewController.  It allows the presentation controller to alter the
//  layout of any custom views it manages.
//
- (void)containerViewWillLayoutSubviews{
    [super containerViewWillLayoutSubviews];
    self.coverView.frame = self.containerView.bounds;
}


//  This method is invoked whenever the presentedViewController's
//  preferredContentSize property changes.  It is also invoked just before the
//  presentation transition begins (prior to -presentationTransitionWillBegin).
//  建议就这样重写就行，这个应该是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
//  可以使用UIContentContainer的方法来调整任何子视图控制器的大小或位置。
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    if (container == self.presentedViewController){
        [self.containerView setNeedsLayout];
    }
}

//| ------------------------------第三步内容----------------------------------------------
#pragma mark UIViewControllerAnimatedTransitioning具体动画实现
/** 返回动画时长
 * @param transitionContext 上下文, 里面保存了动画需要的所有参数
 * @return 动画时长
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return [transitionContext isAnimated] ? _transitionDuration : 0.f;
}

// 动画效果
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 1.获取源控制器、目标控制器、动画容器View
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    __unused UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    // 2. 获取源控制器、目标控制器 的View，但是注意二者在开始动画，消失动画，身份是不一样的：
    // 也可以直接通过上面获取控制器获取，比如：toViewController.view
    // For a Presentation:
    //      fromView = The presenting view.
    //      toView   = The presented view.
    // For a Dismissal:
    //      fromView = The presented view.
    //      toView   = The presenting view.
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    fromView.alpha = 1.0f;
    toView.alpha = 0.0f;
    [containerView addSubview:toView];  //必须添加到动画容器View上。
    
    if (self.showType!= PresentationTypeDefult) {
        [self showPresentationType:transitionContext
                fromViewController:fromViewController
                  toViewController:toViewController
                     containerView:containerView
                          fromView:fromView
                            toView:toView];
    }else{
        [self showDefaultCenter:transitionContext
             fromViewController:fromViewController
               toViewController:toViewController
                  containerView:containerView
                       fromView:fromView
                         toView:toView];
    }
    
}

- (void)animationEnded:(BOOL) transitionCompleted{
    // 动画结束...
}

- (void)showDefaultCenter:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
       fromViewController:(UIViewController *)fromViewController
         toViewController:(UIViewController *)toViewController
            containerView:(UIView *)containerView
                 fromView:(UIView *)fromView
                   toView:(UIView *)toView{
    
    
    // 判断是present 还是 dismiss
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    CGFloat screenW = CGRectGetWidth(containerView.bounds);
    CGFloat screenH = CGRectGetHeight(containerView.bounds);
    
    // 屏幕顶部：
    CGFloat x = (screenW-CGRectGetWidth(_popView.frame))/2;
    CGFloat y = (screenH-CGRectGetHeight(_popView.frame))/2;
    CGFloat w = CGRectGetWidth(_popView.frame);
    CGFloat h = CGRectGetHeight(_popView.frame);
    // 屏幕中间：
    CGRect centerFrame = CGRectMake(x, y, w, h);
    
    if (isPresenting) {
        toView.frame = centerFrame;
    }
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    // duration： 动画时长
    // delay： 决定了动画在延迟多久之后执行
    // damping：速度衰减比例。取值范围0 ~ 1，值越低震动越强
    // velocity：初始化速度，值越高则物品的速度越快
    // UIViewAnimationOptionCurveEaseInOut 加速，后减速
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isPresenting){
            toView.frame = centerFrame;
        }else{
            fromView.frame = centerFrame;
        }
        fromView.alpha = 0.0f;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
        self.popViewFrame=centerFrame;
    }];
}

- (void)showPresentationType:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
          fromViewController:(UIViewController *)fromViewController
            toViewController:(UIViewController *)toViewController
               containerView:(UIView *)containerView
                    fromView:(UIView *)fromView
                      toView:(UIView *)toView{
    
    // 判断是present 还是 dismiss
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    
    CGFloat screenW = CGRectGetWidth(containerView.bounds);
    CGFloat screenH = CGRectGetHeight(containerView.bounds);
    
    CGRect hideFrame = CGRectZero;
    CGRect showFrame = CGRectZero;
    
    CGRect rect = _popView.frame;
    
    if (CGRectGetWidth(self.popViewFrame)>0) {
        rect = self.popViewFrame;
    }
    
    CGFloat x = CGRectGetMinX(rect);
    CGFloat y = CGRectGetMinY(rect);
    CGFloat w = CGRectGetWidth(rect);
    CGFloat h = CGRectGetHeight(rect);
    switch (self.showType) {
        case PresentationTypeTop:
            // 屏幕顶部：
            hideFrame = CGRectMake(x, -h-y, w, h);
            showFrame = CGRectMake(x, y, w, h);
            break;
        case PresentationTypeLeft:
            hideFrame = CGRectMake(-w, y, w, h);
            showFrame = CGRectMake(x, y, w, h);
            break;
        case PresentationTypeRight:
            hideFrame = CGRectMake(screenW, y, w, h);
            showFrame = CGRectMake(screenW-w-x, y, w, h);
            break;
        case PresentationTypeBottom:
            hideFrame = CGRectMake(x, screenH, w, h);
            showFrame = CGRectMake(x, screenH-HOME_INDICATOR_HEIGHT-h-y, w, h);
            break;
        default:
            break;
    }
    if (isPresenting) {
        toView.frame = hideFrame;
    }
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        if (isPresenting){
            toView.frame = showFrame;
        }else{
            fromView.frame = hideFrame;
        }
        fromView.alpha = 0.0f;
        toView.alpha = 1.0;
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!wasCancelled];
        self.popViewFrame = showFrame;
    }];
    
}

#pragma mark 关联键盘动画
- (void)setAllowObserverForKeyBoard:(BOOL)allowObserverForKeyBoard {
    _allowObserverForKeyBoard = allowObserverForKeyBoard;
    if (_allowObserverForKeyBoard ) { //&& _pType !=
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerOfKeyBoard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(observerOfKeyBoard:) name:UIKeyboardWillHideNotification object:nil];
    }else {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}
#pragma mark @protocol KeyboardObserver

- (void)observerOfKeyBoard:(NSNotification *)notification {
    UIView *view = self.presentedView;
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    CGRect rect1 = view.frame;
    CGRect rect2 = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if ([notification.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        
        if(CGRectIntersectsRect(rect1, rect2)) {
            self.isAnimating = YES;
            CGRect frame = view.frame;
            CGFloat offsetY = CGRectGetMaxY(rect1) - CGRectGetMinY(rect2);
            frame.origin.y -= offsetY;
            [UIView animateWithDuration:duration animations:^{
                view.frame = frame;
            } completion:^(BOOL finished) {
                self.isAnimating = NO;
            }];
        }
        
    }else {
        
        [UIView animateWithDuration:duration animations:^{
            view.frame = self.popViewFrame;
        }];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
