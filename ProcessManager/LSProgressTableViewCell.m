//
//  LSProgressTableViewCell.m
//  ProcessManager
//
//  Created by Artem Kravchenko on 4/7/17.
//  Copyright © 2017 LemonSchool. All rights reserved.
//

#import "LSProgressTableViewCell.h"

#import <ChameleonFramework/Chameleon.h>

@interface LSProgressTableViewCell ()

@end

@implementation LSProgressTableViewCell

@synthesize detailTextLabel;
@synthesize textLabel;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColor.flatSkyBlueColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
