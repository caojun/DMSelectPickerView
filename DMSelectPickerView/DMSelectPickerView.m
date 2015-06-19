//
//  DMSelectPickerView.m
//  DiscardGold
//
//  Created by Dream on 15/6/17.
//  Copyright (c) 2015年 GoSing. All rights reserved.
//

#import "DMSelectPickerView.h"

@interface DMSelectPickerView ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *m_btnFinish;
@property (weak, nonatomic) IBOutlet UIPickerView *m_dataPickerView;

@end

@implementation DMSelectPickerView

@synthesize titleFont = _titleFont;
@synthesize rowHeight = _rowHeight;
@synthesize curSelID = _curSelID;

+ (instancetype)selectPickerViewWithTitleArray:(NSArray *)titleArray;
{
    DMSelectPickerView *vc = [[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:nil options:nil] firstObject];
    
    vc.m_titleArray = titleArray;
    
    return vc;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
}

- (void)showInView:(UIView *)view
{
    [view addSubview:self];
    
    CGRect frame = self.frame;
    frame.size.width = view.frame.size.width;
    frame.origin.y = view.frame.origin.y + view.frame.size.height;
    self.frame = frame;
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect tempframe = self.frame;
        tempframe.origin.y = view.frame.origin.y + view.frame.size.height - tempframe.size.height;
        
        self.frame = tempframe;
        
        NSLog(@"frame : %@", NSStringFromCGRect(tempframe));
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.25 animations:^{
        UIView *superView = self.superview;
        CGRect tempframe = self.frame;
        tempframe.origin.y = superView.frame.origin.y + superView.frame.size.height;
        
        self.frame = tempframe;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setM_titleArray:(NSArray *)m_titleArray
{
    _m_titleArray = m_titleArray;
    
    [self.m_dataPickerView reloadAllComponents];
}

- (IBAction)btnFinishClick:(UIButton *)sender
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

- (NSInteger)curSelID
{
    _curSelID = [self.m_dataPickerView selectedRowInComponent:0];
    
    return _curSelID;
}


#pragma mark - UIPickerViewDataSource
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.m_titleArray.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return self.rowHeight;
}

#pragma mark - UIPickerViewDelegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] init];
    label.text = self.m_titleArray[row];
    label.font = self.titleFont;
    [label sizeToFit];
    
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

@end
