//
//  LSTaskStage.h
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/29/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LSTaskStageType) {
    LSTaskStageTypeRoad,
    LSTaskStageTypeInvestigation,
    LSTaskStageTypeFixing,
    LSTaskStageTypeComplinting
};

@interface LSTaskStage : NSObject <NSCoding>

@property (nonatomic, strong) NSString *stageName;
@property (nonatomic, assign) LSTaskStageType stageType;
@property (nonatomic, strong) NSString *stageDescription;

- (UIColor*)stageColor;

- (void)startStage;
- (void)stopStage;

- (NSTimeInterval)timeSpent;
- (NSString*)timeSpentFormatted;

- (NSDate *)startStageDate;
- (NSDate *)stopStageDate;

@end
