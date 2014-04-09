//
//  PickerViews+Helpers.h
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2014 Ruslan Kavetsky. All rights reserved.
//

typedef void (^SelectionBlock)(UIPickerView *pickerView, NSInteger row, NSInteger component);
typedef void (^TitleSelectionBlock)(NSString *title);
typedef void (^DateSelectionBlock)(NSDate *date);
typedef void (^AnimationBlock)(void);

@interface UIPickerView (Blocks) <UIPickerViewDataSource, UIPickerViewDelegate>

- (void)setTitles:(NSArray *)titles;
- (void)handleSelectionWithBlock:(SelectionBlock)block;

@end


@interface UIPickerView (Helpers)

+ (UIPickerView *)showInView:(UIView *)view
                    animated:(BOOL)animated
                     toolbar:(UIToolbar *)toolbar
                      titles:(NSArray *)titles
              selectionBlock:(TitleSelectionBlock)block
              animationBlock:(AnimationBlock)animationBlock;

- (void)hideAnimated:(BOOL)animated
      animationBlock:(AnimationBlock)animationBlock;

+ (UIPickerView *)showInView:(UIView *)view
                    animated:(BOOL)animated
                      titles:(NSArray *)titles
              selectionBlock:(TitleSelectionBlock)block
          showAnimationBlock:(AnimationBlock)showAnimationBlock
          hideAnimationBlock:(AnimationBlock)hideAnimationBlock;

@end


@interface UIDatePicker (Helpers)

+ (UIDatePicker *)showInView:(UIView *)view
                    animated:(BOOL)animated
                     toolbar:(UIToolbar *)toolbar
              selectionBlock:(DateSelectionBlock)block
              animationBlock:(AnimationBlock)animationBlock;

- (void)hideAnimated:(BOOL)animated
      animationBlock:(AnimationBlock)animationBlock;

+ (UIDatePicker *)showInView:(UIView *)view
                    animated:(BOOL)animated
              selectionBlock:(DateSelectionBlock)block
          showAnimationBlock:(AnimationBlock)showAnimationBlock
          hideAnimationBlock:(AnimationBlock)hideAnimationBlock;

@end