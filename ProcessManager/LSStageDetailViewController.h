//
//  LSStageDetailViewController.h
//  ProcessManager
//
//  Created by Artem Kravchenko on 4/5/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSTaskStage.h"

@interface LSStageDetailViewController : UIViewController

@property (nonatomic, strong) LSTaskStage *stageModel;
@property (nonatomic, strong) LSTaskStage *nextStageModel;

@end
