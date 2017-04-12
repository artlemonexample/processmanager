//
//  LSTaskDetailViewController.m
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/31/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSTaskDetailViewController.h"

#import "LSStageDetailViewController.h"
#import "LSProcessManagerModel.h"

@interface LSTaskDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITableView *stagesTableView;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LSTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stagesTableView.delegate = self;
    self.stagesTableView.dataSource = self;
    self.taskDescriptionTextView.text = self.taskModel.taskDescription;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startTimer];
    [self updateActionButton];
    self.taskModel.taskDescription = self.taskDescriptionTextView.text;
    [[LSProcessManagerModel sharedInstance] addTask:self.taskModel];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.taskModel.taskDescription = self.taskDescriptionTextView.text;
    [[LSProcessManagerModel sharedInstance] addTask:self.taskModel];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Private

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self.stagesTableView reloadData];
    }];
}

- (void)stopTimer {
    [self.timer invalidate];
}


#pragma mark - Table View data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taskModel.stages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"stage" forIndexPath:indexPath];
    LSTaskStage *stage = self.taskModel.stages[indexPath.row];
    LSTaskStage *currentStage = self.taskModel.currentStage;
    cell.textLabel.text = [NSString stringWithFormat:@"%@.) %@", @(indexPath.row+1),stage.stageName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", stage.timeSpentFormatted];
    if (currentStage == stage || currentStage.stageType > stage.stageType) {
        cell.detailTextLabel.textColor = stage.stageColor;
    } else {
        if (stage.startStageDate != nil && stage.stopStageDate != nil) {
            cell.detailTextLabel.textColor = UIColor.greenColor;
        } else {
            cell.detailTextLabel.textColor = UIColor.redColor;
        }
    }
    return cell;
}


#pragma mark - Private

- (void)updateActionButton {
    LSTaskStage *firstStage = self.taskModel.stages.firstObject;
    LSTaskStage *lastStage = self.taskModel.stages.lastObject;
    LSTaskStage *currentStage = self.taskModel.currentStage;
    if (firstStage == currentStage && currentStage.startStageDate == nil) {
        [self makeButtonStart];
    } else if (lastStage == currentStage && currentStage.stopStageDate == nil) {
        [self makeButtonStop];
    } else if (currentStage.startStageDate != nil && currentStage.stopStageDate == nil) {
        [self makeButtonStopStage];
    } else {
        [self makeButtonInvisible];
    }
}

- (void)makeButtonStart {
    [self.actionButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.actionButton setTintColor:UIColor.greenColor];
}

- (void)makeButtonStopStage {
    [self.actionButton setTitle:@"Stop Stage" forState:UIControlStateNormal];
    [self.actionButton setTintColor:UIColor.yellowColor];
}

- (void)makeButtonStop {
    [self.actionButton setTitle:@"Stop" forState:UIControlStateNormal];
    [self.actionButton setTintColor:UIColor.redColor];
}

- (void)makeButtonInvisible {
    [self.actionButton setTitle:@"" forState:UIControlStateNormal];
    [self.actionButton setTintColor:UIColor.clearColor];
}


#pragma mark - Actions

- (IBAction)actionButtonDidTap:(UIButton*)sender {
    LSTaskStage *currentStage = self.taskModel.currentStage;
    if (currentStage.startStageDate == nil) {
        [currentStage startStage];
    } else if (currentStage.startStageDate != nil &&
               currentStage.stopStageDate == nil) {
        [currentStage stopStage];
        currentStage = self.taskModel.currentStage;
        [currentStage startStage];
    }
    [self updateActionButton];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.stagesTableView indexPathForCell:sender];
        LSStageDetailViewController *detailVC = segue.destinationViewController;
        detailVC.stageModel = self.taskModel.stages[indexPath.row];
    }
}


@end
