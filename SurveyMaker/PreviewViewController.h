//
//  PreviewViewController.h
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SurveyItem.h"

@interface PreviewViewController : UITableViewController

- (void) addObject: (SurveyItem *) item;

@end
