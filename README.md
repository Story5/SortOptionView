# SortOptionView

|Version:|1.0|
|---|---| 

## Usage

### 1.Init and Show
```
SortOptionView  *sortOptionView = [[SortOptionView alloc] init];
sortOptionView.dataSource = self;
sortOptionView.delegate = self;
[aSuperView addSubview: sortOptionView];
[sortOptionView show];
```
### 2. Implement the method of 'SortOptionViewDataSource' protocol

```
- (NSArray *)titleArrayForSortOptionView:(SortOptionView *)sortOptionView
{
    return @[@"SortTitle1",@"SortTitle2",@"SortTitle3"];
}

```

### 3.Implement the method of 'SortOptionViewDelegate' protocol
```
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
    
    // do something by judge the index and sortOption
}
```

## Installation
1.**Run 'git clone'**

```
git clone https://github.com/GGSDU/SortOptionView
```

2.**Import the `SortOptionView` folder to your project.**
