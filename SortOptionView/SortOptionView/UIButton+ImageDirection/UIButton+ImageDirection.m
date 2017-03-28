//
//  UIButton+ImageDirection.m
//  SortOptionView
//
//  Created by Story5 on 3/28/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "UIButton+ImageDirection.h"

@implementation UIButton (ImageDirection)

- (void)imageDirection:(ImageDirection)direction
{
    if (direction == ImageRight) {
        
        //偶然间发现,只要在获取titleSize之前,使用一次button的titleLabel和imageView,就能获取到他的size了,设置一下titleLabel和imageView的任意属性都行,如果不需要设置这些属性,可以和我一样,设置一下它的背景色和button一致(只是为了提前使用一次)
        self.titleLabel.backgroundColor = self.backgroundColor;
        self.imageView.backgroundColor = self.backgroundColor;
        
        CGFloat titleWidth = self.titleLabel.bounds.size.width;
        CGFloat imageWidth = self.imageView.bounds.size.width;
    
        NSLog(@"imageWidth = %f",imageWidth);
        NSLog(@"titleWidth = %f",titleWidth);
        
        self.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth, 0, -titleWidth);
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageWidth, 0, imageWidth);
    }
}

@end
