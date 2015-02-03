//
//  SurveyItem.h
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyItem : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIView  *subView;

@end

@interface BooleanItem : SurveyItem

@end

@interface TextItem : SurveyItem

@end

@interface MultipleChoiceItem : SurveyItem

@end