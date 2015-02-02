//
//  NewItemViewController.m
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
//

#import "NewItemViewController.h"

@implementation NewItemViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(didPressCancel)];
  self.navigationItem.leftBarButtonItem = cancelButton;
  
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(didPressDone)];
  self.navigationItem.rightBarButtonItem = doneButton;
  
}

- (void) didPressCancel {
  
  [self dismissViewControllerAnimated:true completion:nil];
  
}

- (void) didPressDone {
  
  self.delegate
  
}

@end
