//
//  UIImageView+ESExtension.m
//  ESFramework
//
//  Created by Elf Sundae on 5/22/14.
//  Copyright © 2014-2020 https://0x123.com All rights reserved.
//

#import "UIImageView+ESExtension.h"
#if TARGET_OS_IOS || TARGET_OS_TV

@implementation UIImageView (ESExtension)

- (void)setImageAnimated:(UIImage *)image
{
    [self setImageAnimated:image duration:0.25];
}

- (void)setImageAnimated:(UIImage *)image duration:(NSTimeInterval)duration
{
    if (duration > 0) {
        CATransition *transition = [CATransition animation];
        transition.duration = duration;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionFade;
        [self.layer addAnimation:transition forKey:nil];
    }
    self.image = image;
}

@end

#endif
