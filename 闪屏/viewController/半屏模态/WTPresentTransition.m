//
//  WTPresentTransition.m
//  WisdomTree
//
//  Created by able on 2018/1/25.
//

#import "WTPresentTransition.h"
#import "UIView+Frame.h"
//#import "WTMacroDefine.h"


@interface WTPresentTransition ()

@property (nonatomic, assign) PresentOneTransitionType type;

@end

@implementation WTPresentTransition

+ (instancetype)transitionWithTransitionType:(PresentOneTransitionType)type{
    return [[self alloc] initWithTransitionType:type];
}

- (instancetype)initWithTransitionType:(PresentOneTransitionType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}



//动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _type == PresentOneTransitionTypePresent ? 0.5 : 0.25;
}


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    switch (_type) {
        case PresentOneTransitionTypePresent:
            [self presentAnimation:transitionContext];
            break;
            
        case PresentOneTransitionTypeDismiss:
            [self dismissAnimation:transitionContext];
            break;
    }
}


- (void)presentAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //通过viewControllerForKey取出转场前后的两个控制器，这里toVC就是vc1、fromVC就是vc2
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    //视图高度
    UIView *containerView = [transitionContext containerView];
    //这行用来整个容器高度
    containerView.frame = CGRectMake(0, 300, containerView.width, containerView.height - 300);
    [containerView addSubview:toVC.view];
    toVC.view.frame = CGRectMake(0, containerView.height, containerView.width, containerView.height);
    //开始动画吧，使用产生弹簧效果的动画API
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toVC.view.transform = CGAffineTransformMakeTranslation(0, -(containerView.height));
    } completion:^(BOOL finished) {
        //使用如下代码标记整个转场过程是否正常完成[transitionContext transitionWasCancelled]代表手势是否取消了，如果取消了就传NO表示转场失败，反之亦然，如果不是用手势的话直接传YES也是可以的，我们必须标记转场的状态，系统才知道处理转场后的操作，否者认为你一直还在，会出现无法交互的情况，切记
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场失败后的处理
        if ([transitionContext transitionWasCancelled]) {
            
        }
    }];
}

/**
 *  实现dimiss动画
 */
- (void)dismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    //注意在dismiss的时候fromVC就是vc2了，toVC才是VC1了，注意理解这个逻辑关系
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //动画吧
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
        fromVC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        if ([transitionContext transitionWasCancelled]) {
            //失败了接标记失败
            [transitionContext completeTransition:NO];
        }else{
            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
            [fromVC.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }
    }];
}



@end
