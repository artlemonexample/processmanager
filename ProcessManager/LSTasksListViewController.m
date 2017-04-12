//
//  LSTasksListViewController.m
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/29/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSTasksListViewController.h"

#import "LSTaskDetailViewController.h"
#import "LSProgressTableViewCell.h"
#import "LSProcessManagerModel.h"

@interface LSTasksListViewController ()

@end

@implementation LSTasksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [LSProcessManagerModel sharedInstance].tasksList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSProgressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tmp" forIndexPath:indexPath];
    NSArray *taskList = [LSProcessManagerModel sharedInstance].tasksList;
    LSTaskModel *taskModel = [[LSProcessManagerModel sharedInstance] taskForData:taskList[indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@.) %@", @(indexPath.row+1),taskModel.taskDescription];
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    cell.detailTextLabel.textColor = taskModel.statusColor;
    cell.detailTextLabel.text = taskModel.statusValue;
    LSTaskStage *currentStage = taskModel.currentStage;
    float progressValue = 0;
    if (currentStage) {
        progressValue = ((float)currentStage.stageType) / ((float)taskModel.stages.count);
    } else {
        progressValue = 1.0;
    }
    cell.progressView.progress = progressValue;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSArray *taskList = [LSProcessManagerModel sharedInstance].tasksList;
        LSTaskDetailViewController *detailVC = segue.destinationViewController;
        detailVC.taskModel = [[LSProcessManagerModel sharedInstance] taskForData:taskList[indexPath.row]];
    }
}

@end
