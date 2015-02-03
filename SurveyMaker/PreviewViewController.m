//
//  PreviewViewController.m
//  SurveyMaker
//
//  Created by Cameron Klein on 2/2/15.
//  Copyright (c) 2015 Cameron Klein. All rights reserved.
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
  
  UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                             target:self
                                                                             action:@selector(didPressAddButton:)];
  
  self.navigationItem.rightBarButtonItem = addButton;
  
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  self.tableView.estimatedRowHeight = 100;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}

- (void)didPressAddButton:(id)sender {
  
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

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  SurveyItemCell *cell;
  SurveyItem *item = self.items[indexPath.row];
  
  if ([item isKindOfClass: [BooleanItem class]]) {
    cell = [tableView dequeueReusableCellWithIdentifier:@"BOOLEAN_CELL" forIndexPath:indexPath];
  } else if ([item isKindOfClass:[TextItem class]]) {
    cell = [tableView dequeueReusableCellWithIdentifier:@"TEXT_CELL" forIndexPath:indexPath];
    cell.subContentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    cell.subContentView.layer.borderWidth = 1;
  } else if ([item isKindOfClass:[MultipleChoiceItem class]]) {
    cell = [tableView dequeueReusableCellWithIdentifier:@"MULTIPLE_CHOICE_CELL" forIndexPath:indexPath];
  }

  cell.titleLabel.text = item.title;
  
  return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
  // Return NO if you do not want the specified item to be editable.
  return YES;
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


@end

