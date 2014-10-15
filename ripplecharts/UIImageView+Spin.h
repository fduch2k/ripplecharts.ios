//
//  UIImageView+Spin.h
//  ripplecharts
//
//  Created by Alexander Hramov on 15.10.14.
//  Copyright (c) 2014 Alexander Hramov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Spin)

- (void)startSpin;
- (void)startSpinWithDuration:(NSTimeInterval)duration;
- (void)stopSpin;

@end
