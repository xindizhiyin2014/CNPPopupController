//
//  JKDatePickerView.m
//  JKPopupController
//
//  Created by JackLee on 2019/3/26.
//

#import "JKDatePickerView.h"
#import "JKPopupMacro.h"
#import <HexColors/HexColor.h>
#import "JKPopupView.h"
@interface JKDatePickerView()
@property (nonatomic,weak) JKPopupActionView *popupView;
@property (nonatomic,strong) UIDatePicker *datePicker;
@end

@implementation JKDatePickerView
-(id)init{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    self.backgroundColor = [UIColor whiteColor];
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    topView.backgroundColor = [[UIColor colorWithHexString:@"#2F464F"] colorWithAlphaComponent:0.1];
    [self addSubview:topView];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor colorWithHexString:@"#2F464F"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:cancelBtn];
    cancelBtn.frame = CGRectMake(10, 0, 50, 40);
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor colorWithHexString:@"#01BE5C"] forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(completeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:completeBtn];
    completeBtn.frame = CGRectMake(topView.frame.size.width - 50 -10, 0, 50, 40);

    UIDatePicker *datePicker =[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 180)];
    [self addSubview:datePicker];
    self.datePicker = datePicker;
    self.datePickerModel = UIDatePickerModeDate;
}

#pragma mark - - - - UIEvent - - - -
- (void)showAnimated:(BOOL)animated{
    if (self.defaultDate) {
        self.datePicker.date = self.defaultDate;
    }
    self.datePicker.datePickerMode = self.datePickerModel;
    JKPopupActionView *popupView = [[JKPopupActionView alloc] initBottomViewWithContentView:self];
    self.popupView = popupView;
    [popupView showViewAnimated:animated];
}

- (void)cancelBtnClicked:(UIButton *)button{
    if (self.popupView) {
        [self.popupView dismissViewAnimated:YES];
    }
}

- (void)completeBtnClicked:(UIButton *)button{
    if (self.popupView) {
        [self.popupView dismissViewAnimated:YES];
    }
    if (self.selectedBlock) {
        
        self.selectedBlock(self.datePicker.date);
    }
}


@end
