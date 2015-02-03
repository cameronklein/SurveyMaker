//
//  NewSurveyItemViewController.h
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreviewViewController.h"

@interface NewSurveyItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (nonatomic, strong) PreviewViewController *delegate;

@end
