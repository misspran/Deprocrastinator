//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Vi on 10/6/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property NSIndexPath *indexPath;
@property NSMutableArray *checkedIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray arrayWithObjects: @"something", @"something", @"mores stuff" , nil];

    self.checkedIndexPath = [NSMutableArray arrayWithCapacity:self.array.count];
    for (int i=0; i<self.array.count; i++) {
        [self.checkedIndexPath addObject:[NSNumber numberWithBool:NO]];
    }
}
- (IBAction)onAddButtonPressed:(id)sender {
    [self.array addObject:self.textField.text];
    self.textField.text = @" ";
    [self.tableView reloadData];
    [self.textField resignFirstResponder];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"toDo" forIndexPath:indexPath];
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
    if ([indexPath compare:self.indexPath] == NSOrderedSame)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ((cell.accessoryType = UITableViewCellAccessoryCheckmark))
    {
        [self.checkedIndexPath replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:YES]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.checkedIndexPath replaceObjectAtIndex:indexPath.row withObject: [NSNumber numberWithBool:NO]];
    }

}
- (IBAction)onEditButtonPressed:(UIButton *)button {
    if ([button.titleLabel.text isEqualToString: @"Edit"]) {
        [button setTitle:@"Done" forState:UIControlStateNormal];
    }
    else {
        [button setTitle:@"Edit" forState:UIControlStateNormal];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    [self.checkedIndexPath removeObjectAtIndex:indexPath.row];
}
- (IBAction)swipeRight:(UISwipeGestureRecognizer *) swipegesture {
    CGPoint point = [swipegesture locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            if (cell.textLabel.textColor == [UIColor blackColor]) {
                cell.textLabel.textColor = [UIColor greenColor];
            }else if(cell.textLabel.textColor == [UIColor greenColor]){
                cell.textLabel.textColor = [UIColor yellowColor];
            }else if(cell.textLabel.textColor == [UIColor yellowColor]){
                cell.textLabel.textColor = [UIColor redColor];
            }else if (cell.textLabel.textColor == [UIColor redColor]){
                cell.textLabel.textColor = [UIColor blackColor];
            }
}








@end
