//
//  ViewController.m
//  DMSelectPickerViewDemo
//
//  Created by Dream on 15/6/19.
//  Copyright (c) 2015年 GoSing. All rights reserved.
//

#import "ViewController.h"
#import "DMSelectPickerView.h"

@interface ViewController () <DMSelectPickerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnSelect:(UIButton *)sender
{
    NSArray *array = @[@"男1", @"女1", @"男2", @"女2", @"男3", @"女3"];
    NSArray *subArray = @[@"male1", @"female2", @"male2", @"female2", @"male3", @"female3"];
    DMSelectPickerView *pickerView = [DMSelectPickerView selectPickerViewWithTitleArray:array withSubTitleArray:subArray];
    pickerView.delegate = self;
    pickerView.titleColor = [UIColor blueColor];
    pickerView.topBtnTextColor = [UIColor redColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    view.backgroundColor = [UIColor orangeColor];
    pickerView.topBackgroundView = view;
    pickerView.selectViewBackgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
    pickerView.curSelID = 5;
    pickerView.subSelID = 3;
    
    [pickerView showInView:self.view];
}

#pragma mark - DMSelectPickerViewDelegate
- (void)selectPickerViewClickBtnFinish:(DMSelectPickerView *)view
{
    NSLog(@"select id = %@, subId = %@", @(view.curSelID), @(view.subSelID));
}

@end
