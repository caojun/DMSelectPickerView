/**
 The MIT License (MIT)
 
 Copyright (c) 2016 DreamCao
 
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

NS_ASSUME_NONNULL_BEGIN

@class DMSelectPickerView;

@protocol DMSelectPickerViewDelegate <NSObject>

@optional
/// 点击完成按钮
- (void)selectPickerViewClickBtnFinish:(DMSelectPickerView *)view;

@end



@interface DMSelectPickerView : UIView

@property (nonatomic, weak) id<DMSelectPickerViewDelegate> delegate;

/// 当前选择的ID
@property (nonatomic, assign) NSInteger curSelID;

/// 标题数组
@property (nullable, nonatomic, strong) NSArray<NSString *> *m_titleArray;
/// 标题字体
@property (nullable, nonatomic, strong) UIFont *titleFont;
/// 标题颜色
@property (nullable, nonatomic, strong) UIColor *titleColor;

/// 顶部工具条字体颜色
@property (nullable, nonatomic, strong) UIColor *topBtnTextColor;
/// 顶部工具条字体点击颜色
@property (nullable, nonatomic, strong) UIColor *topBtnHighlightColor;
/// 顶部工具条背景颜色
@property (nullable, nonatomic, strong) UIView *topBackgroundView;

/// 选择器行高
@property (nonatomic, assign) CGFloat rowHeight;

/// 选择器背景颜色
@property (nonatomic, strong) UIColor *selectViewBackgroundColor;


+ (instancetype)selectPickerViewWithTitleArray:(nullable NSArray<NSString *> *)titleArray;
- (void)showInView:(UIView *)view;
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END

