//
//  ViewController.m
//  SortOptionView
//
//  Created by Story5 on 3/28/17.
//  Copyright © 2017 Story5. All rights reserved.
//

#import "ViewController.h"
#import "SortOptionView.h"

@interface ViewController ()<SortOptionViewDataSource,SortOptionViewDelegate>

@property (nonatomic,strong) SortOptionView *sortOptionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"item1";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.sortOptionView.frame = CGRectMake(20, 100, 300, 40);
    [self.sortOptionView show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getter
- (SortOptionView *)sortOptionView
{
    if (_sortOptionView == nil) {
        _sortOptionView = [[SortOptionView alloc] init];
        _sortOptionView.backgroundColor = [UIColor whiteColor];
        _sortOptionView.dataSource = self;
        _sortOptionView.delegate = self;
        [self.view addSubview:_sortOptionView];
        
        _sortOptionView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _sortOptionView.layer.borderWidth = 1;
        _sortOptionView.layer.cornerRadius = 5;
    }
    return _sortOptionView;
}

#pragma mark - delegate && datasource
- (NSArray *)titleArrayForSortOptionView:(SortOptionView *)sortOptionView
{
    return @[@"价格",@"权益伙伴",@"销量"];
}

- (NSArray *)imageShowStatusArrayForSortOptionView:(SortOptionView *)sortOptionView
{
    return @[@"0",@"1",@"1"];
}

- (void)sortOptionView:(SortOptionView *)sortOptionView didClickedItemAtIndex:(NSUInteger)index sortOption:(SortOptionType)sortOption
{
    switch (sortOption) {
        case SortOptionNormal:
            NSLog(@"SortOptionNormal");
            break;
        case SortOptionUp:
            NSLog(@"SortOptionUp");
            break;
        case SortOptionDown:
            NSLog(@"SortOptionDown");
            break;
        default:
            break;
    }
    
    NSLog(@"index : %lu",index);
}

@end
