//
//  NewSurveyItemViewController.m
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
//

#import "NewSurveyItemViewController.h"
#import "SurveyItem.h"

@interface NewSurveyItemViewController ()

@end

@implementation NewSurveyItemViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(didPressCancel)];
  
  
  UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                              target:self
                                                                              action:@selector(didPressDone)];
  
  self.navigationItem.leftBarButtonItem = cancelButton;
  self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];

}

- (void) didPressCancel {
  
  [self dismissViewControllerAnimated:true completion:nil];
  
}


- (void) didPressDone {
  
  SurveyItem *item;
  
  switch (self.segmentControl.selectedSegmentIndex) {
    case 0:
      item = [BooleanItem new];
      break;
    case 1:
      item = [TextItem new];
      break;
    case 2:
      item = [MultipleChoiceItem new];
    default:
      break;
  }
  
  item.title = self.textField.text;
  
  [self dismissViewControllerAnimated:true completion:^{
    [self.delegate addObject:item];
  }];
  
  
}

@end
