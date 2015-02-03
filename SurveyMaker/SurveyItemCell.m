//
//  SurveyItemCell.m
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
//

#import "SurveyItemCell.h"

@implementation SurveyItemCell

- (CGFloat) getHeight {
  
  [self layoutSubviews];
  CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
  CGFloat subViewHeight = self.subContentView.intrinsicContentSize.height;
  
  return labelHeight + subViewHeight + 8 + 8 + 8;
  
}

@end
