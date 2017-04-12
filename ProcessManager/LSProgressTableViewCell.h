//
//  LSProgressTableViewCell.h
//  ProcessManager
//
//  Created by Artem Kravchenko on 4/7/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSProgressTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTextLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end
