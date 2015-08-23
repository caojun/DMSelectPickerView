/**
 The MIT License (MIT)
 
 Copyright (c) 2015 DreamCao
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 */

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

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *topBtnTextColor;
@property (nonatomic, strong) UIColor *topBtnHighlightColor;
@property (nonatomic, strong) UIView *topBackgroundView;

@property (nonatomic, assign) CGFloat rowHeight;

/**
 *  选择器的背景
 */
@property (nonatomic, strong) UIColor *selectViewBackgroundColor;


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
