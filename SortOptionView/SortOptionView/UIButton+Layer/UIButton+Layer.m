//
//  UIButton+Layer.m
//  YDTX
//
//  Created by Story5 on 3/27/17.
//  Copyright © 2017 RookieHua. All rights reserved.
//

#import "UIButton+Layer.h"

@implementation UIButton (Layer)

- (void)addLineOn:(LayerDirection)direction color:(UIColor *)color size:(CGSize)size
{
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    CGFloat originX = 0;
    CGFloat originY = 0;
    switch (direction) {
        case Top:
            originX = (self.bounds.size.width - size.width) / 2;
            originY = 0;
            break;
        case Left:
            originX = 0;
            originY = (self.bounds.size.height - size.height) / 2;
            break;
        case Bottom:
            originX = (self.bounds.size.width - size.width) / 2;
            originY = self.bounds.size.height - size.height;
            break;
        case Right:
            originX = self.bounds.size.width - size.width;
            originY = (self.bounds.size.height - size.height) / 2;
            break;
        default:
            break;
    }
    
    layer.frame = CGRectMake(originX, originY, size.width, size.height);
    [self.layer addSublayer:layer];
}

@end
