//
//  UIImageView+Spin.m
//  ripplecharts
//
//  Created by Alexander Hramov on 15.10.14.
//  Copyright (c) 2014 Alexander Hramov. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIImageView+Spin.h"

@implementation UIImageView (Spin)

- (void)startSpin {
    [self startSpinWithDuration:0.8f];
}

- (void)startSpinWithDuration:(NSTimeInterval)duration {
    CABasicAnimation *spinAnimation;
    spinAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    spinAnimation.fromValue = [NSNumber numberWithFloat:0];
    spinAnimation.toValue = [NSNumber numberWithFloat:((360 * M_PI) / 180)];
    spinAnimation.duration = duration;
    spinAnimation.repeatCount = MAXFLOAT;

    [self.layer addAnimation:spinAnimation forKey:@"spinAnimation"];
}

- (void)stopSpin {
    [self.layer removeAnimationForKey:@"spinAnimation"];

}

@end
