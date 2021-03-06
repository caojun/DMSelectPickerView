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

#import "DMSelectPickerView.h"

static const CGFloat kDMSelectPickerBottomViewHeight = 243;
static const CGFloat kDMSelectPickerBtnFinishViewH = 40;


@interface DMSelectPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *m_bottomView;
@property (nonatomic, weak) UIButton *m_btnFinish;
@property (nonatomic, weak) UIView *m_upSeperatorView;
@property (nonatomic, weak) UIView *m_downSeperatorView;
@property (nonatomic, weak) UIPickerView *m_dataPickerView;

@end

@implementation DMSelectPickerView

@synthesize titleFont = _titleFont;
@synthesize rowHeight = _rowHeight;
@synthesize curSelID = _curSelID;
@synthesize subSelID = _subSelID;

+ (instancetype)selectPickerViewWithTitleArray:(nullable NSArray<NSString *> *)titleArray
{
    CGRect frame = [UIScreen mainScreen].bounds;
    DMSelectPickerView *pickerView = [[self alloc] initWithFrame:frame];
    pickerView.m_titleArray = titleArray;
    
    return pickerView;
}

+ (instancetype)selectPickerViewWithTitleArray:(nullable NSArray<NSString *> *)titleArray
                             withSubTitleArray:(nullable NSArray<NSString *> *)subTitleArray
{
    CGRect frame = [UIScreen mainScreen].bounds;
    DMSelectPickerView *pickerView = [[self alloc] initWithFrame:frame];
    pickerView.m_titleArray = titleArray;
    pickerView.m_subTitleArray = subTitleArray;
    
    return pickerView;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self defaultSetting];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultSetting];
    }
    
    return self;
}

- (void)defaultSetting
{
    self.backgroundColor = [UIColor clearColor];
    
    [self bottomViewCreate];
}

#pragma mark - sub views

- (void)bottomViewAdjustFrame
{
    CGFloat bottomViewH = kDMSelectPickerBottomViewHeight;
    CGFloat bottomViewW = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat bottomViewX = 0;
    CGFloat bottomViewY = CGRectGetHeight(self.bounds) - bottomViewH;
    
    self.m_bottomView.frame = (CGRect){bottomViewX, bottomViewY, bottomViewW, bottomViewH};
    
    CGFloat upSeperatorViewX = 0;
    CGFloat upSeperatorViewY = 0;
    CGFloat upSeperatorViewW = bottomViewW;
    CGFloat upSeperatorViewH = 0.5;
    self.m_upSeperatorView.frame = (CGRect){upSeperatorViewX, upSeperatorViewY, upSeperatorViewW, upSeperatorViewH};
    
    CGFloat btnFinishViewH = kDMSelectPickerBtnFinishViewH;
    CGFloat btnFinishViewW = 60;
    CGFloat btnFinishViewX = bottomViewW - 8 - btnFinishViewW;
    CGFloat btnFinishViewY = upSeperatorViewY;
    self.m_btnFinish.frame = (CGRect){btnFinishViewX, btnFinishViewY, btnFinishViewW, btnFinishViewH};
    
    CGFloat downSeperatorViewX = 0;
    CGFloat downSeperatorViewY = btnFinishViewY + btnFinishViewH;
    CGFloat downSeperatorViewW = bottomViewW;
    CGFloat downSeperatorViewH = upSeperatorViewH;
    
    self.m_downSeperatorView.frame = (CGRect){downSeperatorViewX, downSeperatorViewY, downSeperatorViewW, downSeperatorViewH};
    
    //左右居中显示
    CGFloat pickerViewY = downSeperatorViewY + downSeperatorViewH;
    CGFloat pickerViewW = bottomViewW - 20 * 2;
    CGFloat pickerViewH = bottomViewH - pickerViewY;
    CGFloat pickerViewX = (bottomViewW - pickerViewW) / 2;
    self.m_dataPickerView.frame = (CGRect){pickerViewX, pickerViewY, pickerViewW, pickerViewH};
}

- (void)bottomViewCreate
{
    if (nil == self.m_bottomView)
    {
        UIView *bottomView = [[UIView alloc] init];
        bottomView.backgroundColor = [UIColor clearColor];
        [self addSubview:bottomView];
        self.m_bottomView = bottomView;
        
        [self btnFinishCreate];
        [self seperatorViewCreate];
        [self pickerViewCreate];
        
        [self addSubview:self.m_bottomView];
        
        [self bottomViewAdjustFrame];
    }
}

- (void)btnFinishCreate
{
    if (nil == self.m_btnFinish)
    {
        UIButton *btnFinish = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.m_bottomView addSubview:btnFinish];
        self.m_btnFinish = btnFinish;
        
        [btnFinish setTitle:@"完成" forState:UIControlStateNormal];
        [btnFinish setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnFinish setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btnFinish addTarget:self action:@selector(btnFinishClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)seperatorViewCreate
{
    if (nil == self.m_upSeperatorView)
    {
        UIView *upView = [[UIView alloc] init];
        [self.m_bottomView addSubview:upView];
        upView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.m_upSeperatorView = upView;
    }
    
    if (nil == self.m_downSeperatorView)
    {
        UIView *downView = [[UIView alloc] init];
        [self.m_bottomView addSubview:downView];
        downView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        self.m_downSeperatorView = downView;
    }
}

- (void)pickerViewCreate
{
    if (nil == self.m_dataPickerView)
    {
        UIPickerView *dataPickerView = [[UIPickerView alloc] init];
        [self.m_bottomView addSubview:dataPickerView];
        self.m_dataPickerView = dataPickerView;
        
        dataPickerView.delegate = self;
        dataPickerView.dataSource = self;
        dataPickerView.backgroundColor = [UIColor clearColor];
    }
}


#pragma mark -
- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    CGRect frame = self.m_bottomView.frame;
    frame.size.width = view.frame.size.width;
    frame.origin.y = view.frame.origin.y + view.frame.size.height;
    self.m_bottomView.frame = frame;
    
    self.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect tempframe = self.m_bottomView.frame;
        tempframe.origin.y = view.frame.origin.y + view.frame.size.height - tempframe.size.height;
        
        self.m_bottomView.frame = tempframe;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    } completion:nil];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        UIView *superView = self.superview;
        CGRect tempframe = self.m_bottomView.frame;
        tempframe.origin.y = superView.frame.origin.y + superView.frame.size.height;
        
        self.m_bottomView.frame = tempframe;
        self.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setM_titleArray:(NSArray<NSString *> *)m_titleArray
{
    _curSelID = -1;
    _m_titleArray = m_titleArray;
    
    [self.m_dataPickerView reloadAllComponents];
}

- (void)setM_subTitleArray:(NSArray<NSString *> *)m_subTitleArray
{
    _subSelID = -1;
    _m_subTitleArray = m_subTitleArray;
    
    [self.m_dataPickerView reloadAllComponents];
}

- (void)btnFinishClick:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(selectPickerViewClickBtnFinish:)])
    {
        [self.delegate selectPickerViewClickBtnFinish:self];
    }
    
    [self dismiss];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

- (void)setCurSelID:(NSInteger)curSelID
{
    _curSelID = curSelID;
    
    if (curSelID < self.m_titleArray.count)
    {
        [self.m_dataPickerView selectRow:curSelID inComponent:0 animated:NO];
    }
}

- (NSInteger)curSelID
{
    _curSelID = [self.m_dataPickerView selectedRowInComponent:0];
    
    return _curSelID;
}

- (void)setSubSelID:(NSInteger)subSelID
{
    _subSelID = subSelID;
    
    if (subSelID < self.m_subTitleArray.count)
    {
        [self.m_dataPickerView selectRow:subSelID inComponent:1 animated:NO];
    }
}

- (NSInteger)subSelID
{
    if (self.m_subTitleArray.count > 0)
    {
        _subSelID = [self.m_dataPickerView selectedRowInComponent:1];
        
        return _subSelID;
    }
    
    return -1;
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    NSInteger number = 1;
    
    if (self.m_subTitleArray.count > 0)
    {
        number++;
    }
    
    return number;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (0 == component)
    {
        return self.m_titleArray.count;
    }
    
    return self.m_subTitleArray.count;
}

#pragma mark - UIPickerViewDelegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    NSInteger count = [self numberOfComponentsInPickerView:pickerView];
    
    CGFloat width = CGRectGetWidth(self.m_dataPickerView.frame);
    
    CGFloat itemWidth = floorf(width / count) - 70;
    
    return itemWidth;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.rowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView
            viewForRow:(NSInteger)row
          forComponent:(NSInteger)component
           reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    if (nil == view)
    {
        label = [[UILabel alloc] init];
    }
    else
    {
        label = (UILabel *)view;
    }
    
    if (0 == component)
    {
        label.text = self.m_titleArray[row];
    }
    else
    {
        label.text = self.m_subTitleArray[row];
    }
    
    label.textAlignment = NSTextAlignmentCenter;
    label.font = self.titleFont;
    CGRect frame = CGRectZero;
    frame.size.height = self.rowHeight;
    frame.size.width = [self pickerView:pickerView widthForComponent:component];
    label.frame = frame;
    label.textColor = _titleColor;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}

- (UIFont *)titleFont
{
    if (nil == _titleFont)
    {
        _titleFont = [UIFont systemFontOfSize:17];
    }
    
    return _titleFont;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    [self.m_dataPickerView reloadAllComponents];
}

- (CGFloat)rowHeight
{
    if (_rowHeight < 0.001)
    {
        _rowHeight = 30;
    }
    
    return _rowHeight;
}

- (void)setRowHeight:(CGFloat)rowHeight
{
    _rowHeight = rowHeight;
    
    [self.m_dataPickerView reloadAllComponents];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    [self.m_dataPickerView reloadAllComponents];
}

- (void)setTopBtnTextColor:(UIColor *)topBtnTextColor
{
    _topBtnTextColor = topBtnTextColor;
    
    [self.m_btnFinish setTitleColor:topBtnTextColor forState:UIControlStateNormal];
}

- (void)setTopBtnHighlightColor:(UIColor *)topBtnHighlightColor
{
    _topBtnHighlightColor = topBtnHighlightColor;
    
    [self.m_btnFinish setTitleColor:topBtnHighlightColor forState:UIControlStateHighlighted];
}

- (void)setTopBackgroundView:(UIView *)topBackgroundView
{
    _topBackgroundView = topBackgroundView;
    
    CGFloat bottomViewH = kDMSelectPickerBtnFinishViewH;
    CGFloat bottomViewW = CGRectGetWidth(self.m_bottomView.bounds);
    CGFloat bottomViewX = 0;
    CGFloat bottomViewY = 0;
    topBackgroundView.frame = (CGRect){bottomViewX, bottomViewY, bottomViewW, bottomViewH};
    
    [self.m_bottomView insertSubview:topBackgroundView atIndex:0];
}

- (void)setSelectViewBackgroundColor:(UIColor *)selectViewBackgroundColor
{
    _selectViewBackgroundColor = selectViewBackgroundColor;
    
    self.m_bottomView.backgroundColor = selectViewBackgroundColor;
}

@end
