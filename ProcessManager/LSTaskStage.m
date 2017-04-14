//
//  LSTaskStage.m
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/29/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSTaskStage.h"

@interface LSTaskStage ()

@property (nonatomic, strong) NSDate *startStageDate;
@property (nonatomic, strong) NSDate *stopStageDate;

@end

@implementation LSTaskStage

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.stageName = [aDecoder decodeObjectForKey:@"stageName"];
        self.stageType = [aDecoder decodeIntForKey:@"stageType"];
        self.stageDescription = [aDecoder decodeObjectForKey:@"stageDescription"];
        self.startStageDate = [aDecoder decodeObjectForKey:@"startStageDate"];
        self.stopStageDate = [aDecoder decodeObjectForKey:@"stopStageDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.stageName forKey:@"stageName"];
    [aCoder encodeInteger:self.stageType forKey:@"stageType"];
    [aCoder encodeObject:self.stageDescription forKey:@"stageDescription"];
    [aCoder encodeObject:self.startStageDate forKey:@"startStageDate"];
    [aCoder encodeObject:self.stopStageDate forKey:@"stopStageDate"];
}

- (void)startStage {
    if (self.startStageDate == nil) {
        self.startStageDate = [NSDate date];
    }
}

- (void)stopStage {
    if (self.stopStageDate == nil && self.startStageDate != nil) {
        self.stopStageDate = [NSDate date];
    }
}

- (UIColor*)stageColor {
    UIColor *result = [UIColor blackColor];
    if (self.stopStageDate == nil) {
        result = UIColor.brownColor;
    } else {
        result = UIColor.greenColor;
    }
    return result;
}

- (NSTimeInterval)timeSpent {
    if (self.startStageDate != nil) {
        NSDate *bound = [NSDate date];
        if (self.stopStageDate != nil) {
            bound = self.stopStageDate;
        }
        return [bound timeIntervalSinceDate:self.startStageDate];
    }
    return 0;
}

- (NSString*)timeSpentFormatted {
    NSString *result = nil;
    int seconds = 0, minutes = 0;
    NSTimeInterval timeInterval = self.timeSpent;
    minutes = timeInterval / 60;
    seconds = timeInterval - minutes*60;
    result = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
    return result;
}

@end
