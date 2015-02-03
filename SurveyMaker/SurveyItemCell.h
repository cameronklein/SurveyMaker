//
//  SurveyItemCell.h
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyItemCell : UITableViewCell

- (CGFloat) getHeight;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *subContentView;


@end
