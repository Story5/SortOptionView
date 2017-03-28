//
//  SortOptionView.m
//  SortOptionView
//
//  Created by Story5 on 3/28/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "SortOptionView.h"
#import "UIButton+Layer.h"
#import "UIButton+ImageDirection.h"
#define BUTTON_BASE_TAG 100

@interface SortOptionView ()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,assign) NSUInteger itemDisplayCountMax;
@property (nonatomic,assign) CGFloat buttonWidth;

@property (nonatomic,assign) NSUInteger currentItemIndex;
@property (nonatomic,assign) SortOptionType sortOption;

@property (nonatomic,assign) BOOL shown;


@end

@implementation SortOptionView
- (instancetype)init
{
    self = [super init];
    if (self) {
        _itemDisplayCountMax = 4;
        _currentItemIndex = 0;
        _sortOption = SortOptionNormal;
    }
    return self;
}

#pragma mark - event
- (void)buttonClicked:(UIButton *)aSender
{
    UIButton *preButton = [self.scrollView viewWithTag:self.currentItemIndex + BUTTON_BASE_TAG];
    if (preButton) {
        if (preButton != aSender) {
            preButton.selected = false;
            self.sortOption = SortOptionNormal;
        }
    }
    
    aSender.selected = true;
    self.currentItemIndex = aSender.tag - BUTTON_BASE_TAG;
    switch (self.sortOption) {
        case SortOptionUp:
            self.sortOption = SortOptionDown;
            [aSender setImage:self.downImage forState:UIControlStateSelected];
            break;
        case SortOptionDown:
        case SortOptionNormal:
            self.sortOption = SortOptionUp;
            [aSender setImage:self.upImage forState:UIControlStateSelected];
            break;
        default:
            break;
    }
    
    
    if ([self.delegate respondsToSelector:@selector(sortOptionView:didClickedItemAtIndex:sortOption:)]) {
        [self.delegate sortOptionView:self didClickedItemAtIndex:self.currentItemIndex sortOption:self.sortOption];
    }
}

- (void)show
{
    if (_shown) {
        return;
    }
    _shown = true;
    
    
    [self initData];
    
    [self initButtonItem];
}

- (void)initButtonItem
{
    NSInteger displayCount = self.titleArray.count;
    if (displayCount > _itemDisplayCountMax) {
        displayCount = _itemDisplayCountMax;
    }
    
    self.buttonWidth = self.scrollView.bounds.size.width / displayCount;
    for (int i = 0; i < self.titleArray.count; i++) {
        id value = self.titleArray[i];
        if ([value isKindOfClass:[NSString class]]) {
            NSString *title = (NSString *)value;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(self.buttonWidth * i, 0, self.buttonWidth, self.scrollView.bounds.size.height);
            button.titleLabel.font = self.titleFont;
            [button setImage:self.normalImage forState:UIControlStateNormal];
            [button setTitleColor:self.titleNormalColor forState:UIControlStateNormal];
            [button setTitleColor:self.titleSelectedColor forState:UIControlStateSelected];
            
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = BUTTON_BASE_TAG + i;
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
            
            
            // 图文混排
            [button imageDirection:ImageRight];
            
            if (i == 0) {
                continue;
            }
            // 加下边线
            UIColor *lineColor = self.seperateLineColor;
            [button addLineOn:Left color:lineColor size:CGSizeMake(1, button.bounds.size.height - 2)];
        }
    }
    self.scrollView.contentSize = CGSizeMake(self.buttonWidth * self.titleArray.count, self.scrollView.bounds.size.height);
}

- (void)initData
{
    if ([self.dataSource respondsToSelector:@selector(titleArrayForSortOptionView:)]) {
        NSArray *array = [self.dataSource titleArrayForSortOptionView:self];
        if (array.count > 0) {
            [self.titleArray addObjectsFromArray:array];
        }
    }
}

#pragma mark - getter
- (UIColor *)titleNormalColor
{
    if (_titleNormalColor == nil) {
        _titleNormalColor = [UIColor blackColor];
    }
    return _titleNormalColor;
}

- (UIColor *)seperateLineColor
{
    if (_seperateLineColor == nil) {
        _seperateLineColor = [UIColor lightGrayColor];
    }
    return _seperateLineColor;
}

- (UIImage *)normalImage
{
    if (_normalImage == nil) {
        _normalImage = [UIImage imageNamed:@"Sort_Normal"];
    }
    return _normalImage;
}

- (UIImage *)upImage
{
    if (_upImage == nil) {
        _upImage = [UIImage imageNamed:@"Sort_Up"];
    }
    return _upImage;
}

- (UIImage *)downImage
{
    if (_downImage == nil) {
        _downImage = [UIImage imageNamed:@"Sort_Down"];
    }
    return _downImage;
}



- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.bounces = false;
        _scrollView.pagingEnabled = true;
        _scrollView.showsHorizontalScrollIndicator = false;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

- (NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _titleArray;
}

@end
