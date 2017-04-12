//
//  LSProcessManagerModel.h
//  ProcessManager
//
//  Created by Artem Kravchenko on 3/29/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LSTaskModel.h"

@interface LSProcessManagerModel : NSObject

+ (instancetype)sharedInstance;

- (NSArray*)tasksList;
- (void)addTask:(LSTaskModel*)task;
- (LSTaskModel*)taskForData:(NSData*)taskData;

@end
