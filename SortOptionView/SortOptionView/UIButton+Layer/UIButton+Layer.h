//
//  UIButton+Layer.h
//  YDTX
//
//  Created by Story5 on 3/27/17.
//  Copyright © 2017 RookieHua. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Top,
    Left,
    Bottom,
    Right,
} LayerDirection;

@interface UIButton (Layer)

- (void)addLineOn:(LayerDirection)direction color:(UIColor *)color size:(CGSize)size;

@end
