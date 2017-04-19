//
//  LSStageDetailViewController.m
//  ProcessManager
//
//  Created by Artem Kravchenko on 4/5/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSStageDetailViewController.h"

@interface LSStageDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITextView *stageDescriptionTextView;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LSStageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stageDescriptionTextView.text = self.stageModel.stageDescription;
    self.timeLabel.text = self.stageModel.timeSpentFormatted;
    [self configureWebView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    CGSize size = self.scrollView.contentSize;
    size.width = self.scrollView.bounds.size.width * 2;
    self.scrollView.contentSize = size;
}

- (void)viewWillDisappear:(BOOL)animated {
    self.stageModel.stageDescription = self.stageDescriptionTextView.text;
    [super viewWillDisappear:animated];
}

- (void)configureWebView {
    self.webView = [UIWebView new];
    [self.scrollView addSubview:self.webView];
    CGRect frame = self.webView.frame;
    frame.origin.x = [UIScreen mainScreen].bounds.size.width;
    frame.size.height = self.webView.superview.bounds.size.height;
    frame.size.width = [UIScreen mainScreen].bounds.size.width;
    self.webView.frame = frame;
    // Add google request
    NSString *url = @"http://vk.com";
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:nsUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:30];
    [self.webView loadRequest:request];
}


#pragma mark - Private

- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.timeLabel.text = self.stageModel.timeSpentFormatted;
    }];
}

- (void)stopTimer {
    [self.timer invalidate];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
