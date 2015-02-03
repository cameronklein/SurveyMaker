//
//  SurveyItem.m
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
//

#import "SurveyItem.h"

@implementation SurveyItem

@end

@implementation BooleanItem

- (UIView *)subView {
  
  return [[UISegmentedControl alloc] initWithItems:@[@"Yes", @"No"]];
  
}

@end

@implementation MultipleChoiceItem



@end

@implementation TextItem

- (UIView *)subView {
  
  UITextView *textView = [UITextView new];
  textView.text = @"Hello!";
  return textView;
  
}
@end