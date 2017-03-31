//
//  SortOptionView.h
//  SortOptionView
//
//  Created by Story5 on 3/28/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SortOptionNormal,
    SortOptionUp,
    SortOptionDown,
} SortOptionType;

@class SortOptionView;

@protocol SortOptionViewDataSource <NSObject>

- (NSArray *)titleArrayForSortOptionView:(SortOptionView *)sortOptionView;
- (NSArray *)imageShowStatusArrayForSortOptionView:(SortOptionView *)sortOptionView;

@end

@protocol SortOptionViewDelegate <NSObject>

- (void)sortOptionView:(SortOptionView *)sortOptionView didClickedItemAtIndex:(NSUInteger)index sortOption:(SortOptionType)sortOption;

@end

@interface SortOptionView : UIView

@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,strong) UIColor *titleNormalColor;
@property (nonatomic,strong) UIColor *titleSelectedColor;

@property (nonatomic,strong) UIColor *seperateLineColor;

@property (nonatomic,strong) UIImage *normalImage;
@property (nonatomic,strong) UIImage *upImage;
@property (nonatomic,strong) UIImage *downImage;

@property (nonatomic,assign) id<SortOptionViewDataSource>dataSource;
@property (nonatomic,assign) id<SortOptionViewDelegate>delegate;

- (void)show;

@end
