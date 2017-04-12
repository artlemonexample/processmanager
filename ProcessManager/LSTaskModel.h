//
//  LSTaskModel.h
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/29/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LSTaskStage.h"

typedef NS_ENUM(NSUInteger, LSTaskStatus) {
    LSTaskStatusOpen,
    LSTaskStatusInProgress,
    LSTaskStatusClosed
};

@interface LSTaskModel : NSObject <NSCoding>

@property (nonatomic, strong) NSString *taskID;
@property (nonatomic, strong) NSArray *stages;
@property (nonatomic, assign) LSTaskStatus status;
@property (nonatomic, strong) NSString *taskDescription;

- (UIColor*)statusColor;
- (NSString*)statusValue;
- (LSTaskStage*)currentStage;

@end
