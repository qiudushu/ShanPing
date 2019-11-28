//
//  WTPresentTransition.h
//  WisdomTree
//
//  Created by able on 2018/1/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PresentOneTransitionType) {
    PresentOneTransitionTypePresent = 0,
    PresentOneTransitionTypeDismiss
};

@interface WTPresentTransition : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)transitionWithTransitionType:(PresentOneTransitionType)type;
- (instancetype)initWithTransitionType:(PresentOneTransitionType)type;

@end
