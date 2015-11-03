//
//  TestCell.m
//  TestEditableTableView
//
//  Created by Gonzalo Castro on 11/2/15.
//  Copyright © 2015 Gonzalo Castro. All rights reserved.
//

#import "TestCell.h"

@interface TestCell ()
@property (nonatomic, weak) IBOutlet UILabel *middleLabel;
@end

@implementation TestCell

- (id)initWithStyle:(UITableViewCellStyle)style  reuseIdentifier:(nullable NSString *)ident
{
    self = [super initWithStyle:style reuseIdentifier:ident];
    if (self)
    {
    }

    return self;
}

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateMiddleLabelWithString:(NSString *)text
{
    self.middleLabel.text = text;
}

@end
