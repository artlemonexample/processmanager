//
//  LSProcessManagerModel.m
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/29/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSProcessManagerModel.h"

@interface LSProcessManagerModel ()

@property (nonatomic, strong) NSMutableArray *tasks;

@end

@implementation LSProcessManagerModel

+ (instancetype)sharedInstance {
    static LSProcessManagerModel *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [LSProcessManagerModel new];
    });
    return instance;
}


#pragma mark - Public

- (NSArray*)tasksList {
    NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
    NSMutableArray *taskLists = [NSMutableArray arrayWithArray:[dataBase objectForKey:@"taskLists"]];
    return [taskLists copy];
}

- (void)addTask:(LSTaskModel*)task {
    NSUserDefaults *dataBase = [NSUserDefaults standardUserDefaults];
    NSMutableArray *taskLists = [NSMutableArray arrayWithArray:[dataBase objectForKey:@"taskLists"]];
    if (!taskLists) {
        taskLists = [NSMutableArray new];
    }
    if (task.taskID.length == 0) {
        task.taskID = [NSString stringWithFormat:@"%@", @(taskLists.count)];
        [taskLists addObject:[NSKeyedArchiver archivedDataWithRootObject:task]];
    } else {
        int i;
        for (i = 0; i < taskLists.count; i++) {
            LSTaskModel *tmpTask = [self taskForData:taskLists[i]];
            if ([tmpTask.taskID isEqualToString:task.taskID]) {
                break;
            }
        }
        if (i < taskLists.count) {
            [taskLists replaceObjectAtIndex:i withObject:[NSKeyedArchiver archivedDataWithRootObject:task]];
        }
    }
    [dataBase setObject:taskLists forKey:@"taskLists"];
    [dataBase synchronize];
}

- (LSTaskModel*)taskForData:(NSData*)taskData {
    LSTaskModel *result = [NSKeyedUnarchiver unarchiveObjectWithData:taskData];
    return result;
}

@end
