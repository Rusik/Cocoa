//
//  ViewController.m
//  Sample
//
//  Created by Ruslan Kavetsky on 8/21/13.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "ViewController.h"
#import "UIActionSheet+Blocks.h"
#import "PickerViews+Helpers.h"
#import "RKDescriptionView.h"
#import "UIView+Helpers.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//  обычный размер
//    RKDescriptionView *dv = [[RKDescriptionView alloc] initWithProperty:@{@"Вес": @"1.2кг"} forWidth:300];
//  длинное значение
//    RKDescriptionView *dv = [[RKDescriptionView alloc] initWithProperty:@{@"Фотокамера": @"8 млн пикс., 3264x2448, светодиодная вспышка"} forWidth:300];
//  длинный ключ
    RKDescriptionView *dv = [[RKDescriptionView alloc] initWithProperty:@{@"Время работы в режиме прослушивания музыки": @"40 ч"} forWidth:300];
    dv.$y = self.view.$bottom - 40;
    dv.$x = 10;
    [self.view addSubview:dv];
}

- (IBAction)showActionSheet {
    UIActionSheet *sheet = [UIActionSheet actionSheetWithTitle:@"Action sheet"];
    [sheet addButtonWithTitle:@"One" action:^{
        NSLog(@"One");
    }];
    [sheet addButtonWithTitle:@"Two" action:^{
        NSLog(@"Two");
    }];
    [sheet addDestructiveButtonWithTitle:@"Delete" action:^{
        NSLog(@"Delete");
    }];
    [sheet addCancelButtonWithTitle:@"Cancel" action:nil];

    [sheet setDismissAction:^{
        NSLog(@"Dismiss");
    }];
    [sheet showInView:self.view];
}

- (IBAction)showPickerView {
    [UIPickerView showInView:self.view
               animated:YES
                      titles:@[@"asdsa", @"dsad", @"asdasda"]
              selectionBlock:^(NSString *selectedString) {
                  NSLog(@"%@", selectedString);
              }
          showAnimationBlock:nil
          hideAnimationBlock:nil];
    /*
    UIPickerView *p =[UIPickerView showInView:self.view
                    animated:YES
                     toolbar:nil
                      titles:@[@"asdsa", @"sadas"]
              selectionBlock:nil
              animationBlock:nil];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [p hideAnimated:YES animationBlock:nil];
    });
     */
}

- (IBAction)showDatePicker {

    UIDatePicker *datePicker = [UIDatePicker showInView:self.view
                                               animated:YES
                                         selectionBlock:^(NSDate *date) {
                                             NSLog(@"%@", date);
                                         }
                                     showAnimationBlock:nil
                                     hideAnimationBlock:nil];


    datePicker.datePickerMode = UIDatePickerModeDate;
}

@end
