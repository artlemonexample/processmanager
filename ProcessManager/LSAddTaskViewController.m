//
//  LSAddTaskViewController.m
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/29/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSAddTaskViewController.h"

#import "LSProcessManagerModel.h"

@interface LSAddTaskViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *taskDescriptionTextView;

@end

@implementation LSAddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskDescriptionTextView.delegate = self;
    self.taskModel = [LSTaskModel new];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.taskModel.taskDescription.length > 0) {
        [[LSProcessManagerModel sharedInstance] addTask:self.taskModel];
    }
}


- (void)textViewDidChange:(UITextView *)textView {
    self.taskModel.taskDescription = textView.text;
}



@end
