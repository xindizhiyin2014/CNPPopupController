//
//  JKPopupView.m
//  JKPopupController
//
//  Created by JackLee on 2019/3/26.
//

#import "JKPopupView.h"
#import "CNPPopupController.h"
#import "JKPopupMacro.h"
#import <HexColors/HexColor.h>
#import <JKSandBoxManager/JKSandBoxManager.h>
#import <JKUIHelper/UIView+JKRoundCorner.h>
@interface JKPopupView ()<CNPPopupControllerDelegate>

@property (nonatomic, strong) CNPPopupController *popupController;

@end

@implementation JKPopupView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setDismissOnBackgroundTap:(BOOL)dismissOnBackgroundTap{
    _dismissOnBackgroundTap = dismissOnBackgroundTap;
    
    self.popupController.theme.shouldDismissOnBackgroundTouch = dismissOnBackgroundTap;
}

- (void)setPopupType:(JKPopupType)popupType{
    _popupType = popupType;
    
    if (popupType == JKPopupTypeAlert) {
        self.popupController.theme.popupStyle = CNPPopupStyleCentered;
        self.popupController.theme.presentationStyle = CNPPopupPresentationStyleFadeIn;
    }else if (popupType == JKPopupTypeActionSheet){
        self.popupController.theme.popupStyle = CNPPopupStyleActionSheet;
        self.popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromBottom;
    }else if (popupType == JKPopupTypeFullScreen){
        self.popupController.theme.popupStyle = CNPPopupStyleFullscreen;
        self.popupController.theme.presentationStyle = CNPPopupPresentationStyleSlideInFromBottom;
    }
}

- (CNPPopupController *)popupController{
    if (!_popupController) {
        
        _popupController = [[CNPPopupController alloc] initWithContents:@[self]];
        _popupController.theme = [CNPPopupTheme defaultTheme];
        _popupController.theme.backgroundColor = [UIColor clearColor];
        _popupController.theme.cornerRadius = 0;
        _popupController.theme.popupContentInsets = UIEdgeInsetsZero;
        _popupController.theme.contentVerticalPadding = 0;
        _popupController.theme.maxPopupWidth = SCREEN_WIDTH;
        _popupController.theme.maskType = CNPPopupMaskTypeCustom;
        _popupController.theme.movesAboveKeyboard = NO;
        _popupController.theme.customMaskColor = [[UIColor colorWithHexString:@"#000000"] colorWithAlphaComponent:0.36];
        
        _popupController.delegate = self;
    }
    return _popupController;
}


- (void)showViewAnimated:(BOOL)flag{
    [self.popupController presentPopupControllerAnimated:flag];
}

- (void)dismissViewAnimated:(BOOL)flag{
    [self.popupController dismissPopupControllerAnimated:flag];
}


#pragma mark CNPPopupControllerDelegate
- (void)popupControllerWillPresent:(CNPPopupController *)controller{
    if (self.liftBlock) {
        self.liftBlock(JKPopupLifeStateWillShow);
    }
}

- (void)popupControllerDidPresent:(CNPPopupController *)controller{
    if (self.liftBlock) {
        self.liftBlock(JKPopupLifeStateDidShow);
    }
}


- (void)popupControllerWillDismiss:(CNPPopupController *)controller{
    if (self.liftBlock) {
        self.liftBlock(JKPopupLifeStateWillHide);
    }
}

- (void)popupControllerDidDismiss:(CNPPopupController *)controller{
    if (self.liftBlock) {
        self.liftBlock(JKPopupLifeStateDidHide);
    }
    self.popupController = nil;
}


- (void)resetViewFrame:(CGRect)frame{
    [self.popupController resetViewFrame:frame];
}


@end



@implementation JKPopupAlertView

- (instancetype)initCloseViewWithContentView:(UIView *)contentView{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height+ 60*kIPadScale);
        
        
        UIView *contentBgView = [[UIView alloc] initWithFrame:contentView.bounds];
        contentBgView.backgroundColor = [UIColor clearColor];
        contentBgView.layer.masksToBounds = YES;
        contentBgView.layer.cornerRadius = 16*kIPadScale;
        [self addSubview:contentBgView];
        
        [contentBgView addSubview:contentView];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[JKSandBoxManager imageWithName:@"icon_common_alertClose" podName:@"JKPopupController"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(closeBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.frame = CGRectMake((self.frame.size.width - 40 *kIPadScale)/2, contentView.frame.origin.y + contentView.frame.size.height + 14 *kIPadScale, 40 *kIPadScale, 40 *kIPadScale);
       
        self.dismissOnBackgroundTap = NO;
        self.popupType = JKPopupTypeAlert;
    }
    return self;
}
- (void)closeBtnDidClicked:(UIButton *)sender{
    [self dismissViewAnimated:YES];
}

@end;




@implementation JKPopupActionView

- (instancetype)initBottomViewWithContentView:(UIView *)contentView title:(NSString *)title{
    self = [super init];
    if (self) {
        
        CGFloat topSpace = 0;
        if (title && [title isKindOfClass:[NSString class]] && title.length > 0) {
            topSpace = 48*kIPadScale;
            
            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topSpace)];
            topView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
            [self addSubview:topView];
            [topView  jkDrawRoundCornerWithCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:16 *kIPadScale];
           
            UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 16 *kIPadScale)];
            titleLab.textColor = [UIColor colorWithHexString:@"#000000"];
            titleLab.font = [UIFont systemFontOfSize:16*kIPadScale];
            titleLab.text = title;
            [topView addSubview:titleLab];
            titleLab.center = topView.center;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[JKSandBoxManager imageWithName:@"icon_common_actionClose" podName:@"JKPopupController"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(closeBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            [topView addSubview:btn];
            btn.frame = CGRectMake(topView.frame.size.width -8 *kIPadScale -40 *kIPadScale, (topView.frame.size.height - 40 *kIPadScale)/2, 40 *kIPadScale, 40 *kIPadScale);
            
            UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, topView.frame.size.height -1, topView.frame.size.width, 1)];
            line.backgroundColor = [UIColor colorWithHexString:@"#E8E8E8"];
            line.alpha = 0.5;
            [topView addSubview:line];
            
        }
        
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, contentView.frame.size.height + topSpace);
        
        
        UIView *contentBgView = [[UIView alloc] initWithFrame:CGRectMake(0, topSpace, SCREEN_WIDTH, contentView.frame.size.height)];
        contentBgView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [self addSubview:contentBgView];
        
        [contentBgView addSubview:contentView];
        
        
        self.dismissOnBackgroundTap = YES;
        self.popupType = JKPopupTypeActionSheet;
    }
    return self;
}
- (void)closeBtnDidClicked:(UIButton *)sender{
    [self dismissViewAnimated:YES];
}

- (instancetype)initBottomViewWithContentView:(UIView *)contentView{
    CGRect frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height + kBottomSafeAreaHeight);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.dismissOnBackgroundTap = YES;
        self.popupType = JKPopupTypeActionSheet;
        [self addSubview:contentView];
    }
    return self;
}

- (instancetype)initInputViewWithContentView:(UIView *)contentView{
    CGRect frame = CGRectMake(0, 0, contentView.frame.size.width, contentView.frame.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.dismissOnBackgroundTap = YES;
        self.popupType = JKPopupTypeActionSheet;
        [self addSubview:contentView];
    }
    return self;
}

@end;
