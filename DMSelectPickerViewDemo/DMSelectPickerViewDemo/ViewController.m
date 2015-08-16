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
    NSArray *array = @[@"男", @"女"];
    DMSelectPickerView *pickerView = [DMSelectPickerView selectPickerViewWithTitleArray:array];
    pickerView.delegate = self;
    pickerView.titleColor = [UIColor blueColor];
    pickerView.topBtnTextColor = [UIColor redColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    view.backgroundColor = [UIColor orangeColor];
    pickerView.topBackgroundView = view;
    
    [pickerView showInView:self.view];
}

#pragma mark - DMSelectPickerViewDelegate
- (void)selectPickerViewClickBtnFinish:(DMSelectPickerView *)view
{
    NSLog(@"select id = %@", @(view.curSelID));
}

@end
