//
//  UIButton+ImageDirection.h
//  SortOptionView
//
//  Created by Story5 on 3/28/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ImageLeft,
    ImageRight,
} ImageDirection;

@interface UIButton (ImageDirection)

- (void)imageDirection:(ImageDirection)direction;

@end
