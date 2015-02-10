//
//  PreviewViewController.m
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

#import "PreviewViewController.h"
#import "NewSurveyItemViewController.h"
#import "SurveyItemCell.h"

@interface PreviewViewController ()

@property (nonatomic, strong) NSMutableArray *items;

@end

@implementation PreviewViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  self.navigationItem.leftBarButtonItem = self.editButtonItem;
  
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                             target:self
                                                                             action:@selector(didPressDoneButton)];
  
  self.navigationItem.rightBarButtonItem = addButton;
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 100;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.items.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  SurveyItemCell *cell;
  
  if (indexPath.row >= self.items.count) {
    
    cell = [tableView dequeueReusableCellWithIdentifier:@"BOOLEAN_CELL" forIndexPath:indexPath];
    cell.titleLabel.text = @"\n\nNew Question";
    cell.titleLabel.textColor = [UIColor blueColor];
    cell.subContentView.alpha = 0;
    
  } else {
  
    cell = [self setupCellForIndexPath:indexPath];
    
  }
  
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row >= self.items.count) {
    return NO;
  } else {
    return YES;
  }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row >= self.items.count || self.items.count == 1) {
    return NO;
  } else {
    return YES;
  }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 100;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [self.items removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  } else if (editingStyle == UITableViewCellEditingStyleInsert) {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
  }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
  if (indexPath.row >= self.items.count) {
    [self didPressNewQuestion];
  }
  
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
  [self.items insertObject: [self.items objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row];
  [self.items removeObjectAtIndex:(sourceIndexPath.row + 1)];
}

- (SurveyItemCell *) setupCellForIndexPath:(NSIndexPath *)indexPath {
  
  SurveyItemCell *cell;
  SurveyItem *item = self.items[indexPath.row];
  
  if ([item isKindOfClass: [BooleanItem class]]) {
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"BOOLEAN_CELL" forIndexPath:indexPath];
    cell.subContentView.alpha = 1;
  } else if ([item isKindOfClass:[TextItem class]]) {
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"TEXT_CELL" forIndexPath:indexPath];
    cell.subContentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell.subContentView.layer.borderWidth = 1;
  } else if ([item isKindOfClass:[MultipleChoiceItem class]]) {
    cell = [self.tableView dequeueReusableCellWithIdentifier:@"MULTIPLE_CHOICE_CELL" forIndexPath:indexPath];
  }
  
  cell.titleLabel.textColor = [UIColor blackColor];
  cell.titleLabel.text = item.title;
  
  return cell;
  
}

- (void) didPressNewQuestion {
  
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
  UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"NEW_ITEM"];
  NewSurveyItemViewController *newVC = nav.childViewControllers[0];
  [self presentViewController:nav animated:true completion:nil];
  newVC.delegate = self;
  
}

- (void) addObject: (SurveyItem *) item {
  
  if (!self.items) {
    self.items = [[NSMutableArray alloc] init];
  }
  
  [self.items addObject:item];
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.items.count - 1 inSection:0];
  
  [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
  
}

- (void) didPressDoneButton {
  
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Save?" message:@"Do you want to save this survey" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
  
  [alert show];
  
  
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex {
  
  NSMutableArray *items = [NSMutableArray new];
  
  for (SurveyItem *item in self.items) {
    [items addObject:[item dictionaryWithValuesForKeys:@[@"title", ]]];
  }
  
  if (buttonIndex == 1) {
    NSError *error;
    NSDictionary *dictionary = @{@"title" : @"New Survey", @"questions" : self.items};
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
    
    /* send data off */
    
  }
  
}


@end

