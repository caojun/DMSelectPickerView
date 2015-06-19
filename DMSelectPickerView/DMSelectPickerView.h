//
//  DMSelectPickerView.h
//  DiscardGold
//
//  Created by Dream on 15/6/17.
//  Copyright (c) 2015年 GoSing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DMSelectPickerView;

@protocol DMSelectPickerViewDelegate <NSObject>

@optional
/**
 *  点击完成按钮
 *
 *  @param view
 */
- (void)selectPickerViewClickBtnFinish:(DMSelectPickerView *)view;

@end

@interface DMSelectPickerView : UIView



/**
 *  代理
 */
@property (nonatomic, weak) id<DMSelectPickerViewDelegate> delegate;

/**
 *  当前选择的ID
 */
@property (nonatomic, assign, readonly) NSInteger curSelID;

/**
 *  选择数据源, 里面存放 NSString
 */
@property (nonatomic, strong) NSArray *m_titleArray;

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) CGFloat rowHeight;


+ (instancetype)selectPickerViewWithTitleArray:(NSArray *)titleArray;

/**
 *  显示view
 *
 *  @param view
 */
- (void)showInView:(UIView *)view;

/**
 *  消失,带有动画
 */
- (void)dismiss;

@end
