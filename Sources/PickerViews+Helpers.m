//
//  PickerViews+Helpers.m
//
//  Created by Ruslan Kavetsky.
//  Copyright (c) 2014 Ruslan Kavetsky. All rights reserved.
//

#import "PickerViews+Helpers.h"
#import <objc/runtime.h>
#import "UIView+Helpers.h"
#import "UIToolbar+AccessoryView.h"
#import "NSObject+AssociatedObjects.h"

static char TitlesKey, SelectBlockKey;

@implementation UIPickerView (Blocks)

- (void)setTitles:(NSArray *)titles {
	objc_setAssociatedObject(self, &TitlesKey, titles, OBJC_ASSOCIATION_COPY_NONATOMIC);
	[self setDataSource:self];
	[self setDelegate:self];
}

- (void)handleSelectionWithBlock:(SelectionBlock)block {
	objc_setAssociatedObject(self, &SelectBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
	[self setDelegate:self];
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	NSArray *ary = (NSArray *)objc_getAssociatedObject(self, &TitlesKey);
	return [ary count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSArray *ary = (NSArray *)objc_getAssociatedObject(self, &TitlesKey);
	return [ary[component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSArray *ary = (NSArray *)objc_getAssociatedObject(self, &TitlesKey);
	return ary[component][row];
}

#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	SelectionBlock block = (SelectionBlock)objc_getAssociatedObject(self, &SelectBlockKey);
	if (block) block(pickerView, row, component);
}

@end



@implementation UIView (Pickers)

#define ANIMATION_DURATION 0.27
#define CONTAINER_VIEW_KEY @"containerViewKey"
#define HIDE_ANIMATION_BLOCK @"hideAnimationBlock"
#define ANIMATED @"animated"

- (void)showInView:(UIView *)view
          animated:(BOOL)animated
           toolbar:(UIToolbar *)toolbar
    defaultToolbar:(BOOL)showDefaultToolbar
showAnimationBlock:(AnimationBlock)showAnimationBlock
hideAnimationBlock:(AnimationBlock)hideAnimationBlock {


    if (!toolbar && showDefaultToolbar) {
        toolbar = [UIToolbar accessoryViewWithDoneButtonWithTarget:self action:@selector(doneDidPress)];
    }

    UIView *containerView = [UIView new];
    containerView.backgroundColor = [UIColor colorWithWhite:0.831 alpha:1.000];
    containerView.$size = CGSizeMake(view.$width, self.$height + toolbar.$height);

    toolbar.$y = 0;
    [containerView addSubview:toolbar];

    self.$y = toolbar.$bottom;
    [containerView addSubview:self];

    [self setAssociatedObject:containerView forKey:CONTAINER_VIEW_KEY];
    [self setAssociatedObject:hideAnimationBlock forKey:HIDE_ANIMATION_BLOCK];
    [self setAssociatedObject:@(animated) forKey:ANIMATED];

    containerView.$y = view.$height;
    [view addSubview:containerView];

    AnimationBlock animationBlock = ^{
        containerView.$y = view.$height - containerView.$height;
        if (showAnimationBlock) showAnimationBlock();
    };

    [UIView animateWithDuration:ANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{

                         if (animated) {
                             animationBlock();
                         } else {
                             [UIView performWithoutAnimation:animationBlock];
                         }

                     } completion:nil];
}

- (void)doneDidPress {
    AnimationBlock hideAnimationBlock = [self associatedObjectForKey:HIDE_ANIMATION_BLOCK];
    BOOL animated = [[self associatedObjectForKey:ANIMATED] boolValue];

    [self hideViewAnimated:animated
        animationBlock:hideAnimationBlock];
}

- (void)hideViewAnimated:(BOOL)animated
      animationBlock:(AnimationBlock)animationBlock {

    UIView *containerView = [self associatedObjectForKey:CONTAINER_VIEW_KEY];

    AnimationBlock animationBlock_ = ^{
        containerView.$y += containerView.$height;
        if (animationBlock) animationBlock();
    };

    [UIView animateWithDuration:ANIMATION_DURATION
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{

                         if (animated) {
                             animationBlock_();
                         } else {
                             [UIView performWithoutAnimation:animationBlock_];
                         }

                     } completion:^(BOOL finished) {
                         [containerView removeFromSuperview];
                     }];
}

@end



@implementation UIPickerView (Helpers)

+ (UIPickerView *)showInView:(UIView *)view
                    animated:(BOOL)animated
                     toolbar:(UIToolbar *)toolbar
                      titles:(NSArray *)titles
              selectionBlock:(TitleSelectionBlock)block
              animationBlock:(AnimationBlock)animationBlock {

    UIPickerView *pickerView = [UIPickerView new];
    [pickerView setTitles:@[titles]];
    [pickerView handleSelectionWithBlock:^(UIPickerView *pickerView, NSInteger row, NSInteger component) {
        if (block) block(titles[row]);
    }];

    [pickerView showInView:view
                  animated:animated
                   toolbar:toolbar
            defaultToolbar:NO
        showAnimationBlock:animationBlock
        hideAnimationBlock:nil];

    return pickerView;
}

- (void)hideAnimated:(BOOL)animated
      animationBlock:(AnimationBlock)animationBlock {

    [self hideViewAnimated:animated
        animationBlock:animationBlock];
}

+ (UIPickerView *)showInView:(UIView *)view
                    animated:(BOOL)animated
                      titles:(NSArray *)titles
              selectionBlock:(TitleSelectionBlock)block
          showAnimationBlock:(AnimationBlock)showAnimationBlock
          hideAnimationBlock:(AnimationBlock)hideAnimationBlock {

    UIPickerView *pickerView = [UIPickerView new];
    [pickerView setTitles:@[titles]];
    [pickerView handleSelectionWithBlock:^(UIPickerView *pickerView, NSInteger row, NSInteger component) {
        if (block) block(titles[row]);
    }];

    [pickerView showInView:view
                  animated:animated
                   toolbar:nil
            defaultToolbar:YES
        showAnimationBlock:showAnimationBlock
        hideAnimationBlock:hideAnimationBlock];

    return pickerView;
}

@end



@implementation UIDatePicker (Helpers)

+ (UIDatePicker *)showInView:(UIView *)view
                    animated:(BOOL)animated
                     toolbar:(UIToolbar *)toolbar
              selectionBlock:(DateSelectionBlock)block
              animationBlock:(AnimationBlock)animationBlock {

    UIDatePicker *datePicker = [self datePickerWithSelectionBlock:block];
    [datePicker showInView:view
                  animated:animated
                   toolbar:toolbar
            defaultToolbar:NO
        showAnimationBlock:animationBlock
        hideAnimationBlock:nil];
    return datePicker;
}

- (void)dateValueDidChange {
    DateSelectionBlock block = [self associatedObjectForKey:@selector(dateValueDidChange)];
    if (block) block(self.date);
}

- (void)hideAnimated:(BOOL)animated
      animationBlock:(AnimationBlock)animationBlock {

    [self hideViewAnimated:animated animationBlock:animationBlock];
}

+ (UIDatePicker *)showInView:(UIView *)view
                    animated:(BOOL)animated
              selectionBlock:(DateSelectionBlock)block
          showAnimationBlock:(AnimationBlock)showAnimationBlock
          hideAnimationBlock:(AnimationBlock)hideAnimationBlock {

    UIDatePicker *datePicker = [self datePickerWithSelectionBlock:block];
    [datePicker showInView:view
                  animated:animated
                   toolbar:nil
            defaultToolbar:YES
        showAnimationBlock:showAnimationBlock
        hideAnimationBlock:hideAnimationBlock];

    return datePicker;
}

+ (UIDatePicker *)datePickerWithSelectionBlock:(DateSelectionBlock)selectionBlock {
    UIDatePicker *datePicker = [UIDatePicker new];
	[datePicker addTarget:datePicker action:@selector(dateValueDidChange) forControlEvents:UIControlEventValueChanged];
    [datePicker setAssociatedObject:selectionBlock forKey:@selector(dateValueDidChange)];
    return datePicker;
}

@end
