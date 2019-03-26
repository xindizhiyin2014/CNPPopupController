//
//  JKDatePickerView.h
//  JKPopupController
//
//  Created by JackLee on 2019/3/26.
//

#import <UIKit/UIKit.h>

typedef void(^JKDatePickerSelectedBlock)(NSDate *date);
@interface JKDatePickerView : UIView
@property (nonatomic,strong) NSDate *defaultDate;     ///< 初始的date
@property (nonatomic,assign) UIDatePickerMode datePickerModel; ///< 日期模型
@property (nonatomic,copy) JKDatePickerSelectedBlock selectedBlock;

- (void)showAnimated:(BOOL)animated;

@end
