//
//  ViewController.m
//  Sample
//
//  Created by Ruslan Kavetsky on 8/21/13.
//  Copyright (c) 2013 Ruslan Kavetsky. All rights reserved.
//

#import "ViewController.h"
#import "UIActionSheet+Blocks.h"

@interface ViewController ()

@end

@implementation ViewController

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

@end
