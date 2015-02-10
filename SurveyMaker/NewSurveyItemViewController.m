//
//  NewSurveyItemViewController.m
//  SurveyMaker
//
//  This is free and unencumbered software released into the public domain.
//
//  Anyone is free to copy, modify, publish, use, compile, sell, or distribute this software,
//  either in source code form or as a compiled binary, for any purpose, commercial or non-commercial,
//  and by any means.
//
//  In jurisdictions that recognize copyright laws, the author or authors of this software dedicate
//  any and all copyright interest in the software to the public domain. We make this dedication for
//  the benefit of the public at large and to the detriment of our heirs and successors. We intend
//  this dedication to be an overt act of relinquishment in perpetuity of all present and future
//  rights to this software under copyright law.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
//  BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
//  SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
//  For more information, please refer to http://unlicense.org
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
