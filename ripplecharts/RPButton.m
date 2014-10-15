//
//  RPButton.m
//  ripplecharts
//
//  Created by Alexander Hramov on 15.10.14.
//  Copyright (c) 2014 Alexander Hramov. All rights reserved.
//

#import "RPButton.h"

@implementation RPButton

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize {
    self.layer.cornerRadius = 4;
}

@end
