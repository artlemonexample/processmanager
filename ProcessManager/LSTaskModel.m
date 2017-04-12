//
//  LSTaskModel.m
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/29/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSTaskModel.h"

@implementation LSTaskModel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.stages = [aDecoder decodeObjectForKey:@"stages"];
        self.status = [aDecoder decodeInt64ForKey:@"status"];
        self.taskID = [aDecoder decodeObjectForKey:@"taskID"];
        self.taskDescription = [aDecoder decodeObjectForKey:@"taskDescription"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.taskID forKey:@"taskID"];
    [aCoder encodeObject:self.stages forKey:@"stages"];
    [aCoder encodeInteger:self.status forKey:@"status"];
    [aCoder encodeObject:self.taskDescription forKey:@"taskDescription"];
}

- (NSArray *)stages {
    if (!_stages) {
        _stages = self.defaultStages;
    }
    return _stages;
}

- (LSTaskStatus)status {
    LSTaskStage *firstStage = self.stages.firstObject;
    LSTaskStage *currentStage = self.currentStage;
    if (firstStage == currentStage && currentStage.startStageDate == nil) {
        _status = LSTaskStatusOpen;
    } else if (nil == currentStage) {
        _status = LSTaskStatusClosed;
    } else {
        _status = LSTaskStatusInProgress;
    }
    return _status;
}

- (NSArray *)defaultStages {
    LSTaskStage *stage1 = [LSTaskStage new];
    stage1.stageName = @"Road";
    stage1.stageType = LSTaskStageTypeRoad;
    LSTaskStage *stage2 = [LSTaskStage new];
    stage2.stageName = @"Investigation";
    stage2.stageType = LSTaskStageTypeInvestigation;
    LSTaskStage *stage3 = [LSTaskStage new];
    stage3.stageName = @"Fixing";
    stage3.stageType = LSTaskStageTypeFixing;
    LSTaskStage *stage4 = [LSTaskStage new];
    stage4.stageName = @"Complete";
    stage4.stageType = LSTaskStageTypeComplinting;
    return @[stage1, stage2, stage3, stage4];
}

- (NSString*)statusValue {
    switch (self.status) {
        case LSTaskStatusOpen:
            return @"OPEN";
            break;
        case LSTaskStatusInProgress:
            return @"IN PROGRESS";
            break;
        case LSTaskStatusClosed:
            return @"CLOSED";
            break;
        default:
            return @"Undefiend";
            break;
    }
}

- (UIColor *)statusColor {
    
    switch (self.status) {
        case LSTaskStatusOpen:
            return [UIColor redColor];
            break;
        case LSTaskStatusInProgress:
            return [UIColor yellowColor];
            break;
        case LSTaskStatusClosed:
            return [UIColor greenColor];
            break;
        default:
            return [UIColor purpleColor];
            break;
    }
}

- (LSTaskStage*)currentStage{
    __block LSTaskStage *result = self.stages.lastObject;
    if (result.stopStageDate != nil) {
        return nil;
    }
    result = self.stages.firstObject;
    if (result.startStageDate == nil) {
        return result;
    }
    __block NSInteger currentStageIndex = -1;
    [self.stages enumerateObjectsUsingBlock:^(LSTaskStage *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.startStageDate != nil && obj.stopStageDate == nil) {
            *stop = YES;
            result = obj;
        } else if (obj.startStageDate != nil && obj.stopStageDate != nil) {
            currentStageIndex = idx + 1;
        }
    }];
    if (currentStageIndex != -1 && currentStageIndex < self.stages.count) {
        result = self.stages[currentStageIndex];
    }
    return result;
}


@end
