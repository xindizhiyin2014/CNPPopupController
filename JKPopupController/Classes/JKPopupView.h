//
//  JKPopupView.h
//  JKPopupController
//
//  Created by JackLee on 2019/3/26.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,JKPopupType) {
    JKPopupTypeAlert = 0,
    JKPopupTypeActionSheet,
    JKPopupTypeFullScreen
};

typedef NS_ENUM(NSInteger,JKPopupLifeState){
    JKPopupLifeStateUndefined = 0,
    JKPopupLifeStateWillShow,
    JKPopupLifeStateDidShow,
    JKPopupLifeStateWillHide,
    JKPopupLifeStateDidHide,
};

typedef void(^JKPopupViewLifeBlock)(JKPopupLifeState lifeState);

NS_ASSUME_NONNULL_BEGIN

@interface JKPopupView : UIView

@property (nonatomic, assign) JKPopupType popupType;
@property (nonatomic, assign) BOOL dismissOnBackgroundTap;


@property (nonatomic, copy) JKPopupViewLifeBlock liftBlock;

- (void)showViewAnimated:(BOOL)animated;
- (void)dismissViewAnimated:(BOOL)animated;


- (void)resetViewFrame:(CGRect)frame;

@end



@interface JKPopupAlertView : JKPopupView

- (instancetype)initCloseViewWithContentView:(UIView *)contentView;

@end



@interface JKPopupActionView : JKPopupView

- (instancetype)initBottomViewWithContentView:(UIView *)contentView title:(NSString *)title;

- (instancetype)initBottomViewWithContentView:(UIView *)contentView;


- (instancetype)initInputViewWithContentView:(UIView *)contentView;

@end

NS_ASSUME_NONNULL_END
