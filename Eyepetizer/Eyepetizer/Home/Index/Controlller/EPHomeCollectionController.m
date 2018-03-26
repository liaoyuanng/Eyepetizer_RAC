//
//  EPHomeCollectionController.m
//  Eyepetizer
//
//  Created by Ju Liaoyuan on 2018/3/21.
//  Copyright © 2018年 StayTrue( https://www.imliaoyuan.com ). All rights reserved.
//

#import "EPHomeCollectionController.h"
#import "EPHomeCollectionViewModel.h"
#import "EPScrollCell.h"
#import "EPTextOnlyCell.h"
#import "EPNormalCell.h"

@interface EPHomeCollectionController ()

@property (nonatomic, copy) NSArray<EPHomeCollectionViewModel *> *dataSource;

@end

@implementation EPHomeCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.collectionView.backgroundColor = UIColor.whiteColor;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0.f;
    layout.minimumInteritemSpacing = 0;
    self.collectionView.collectionViewLayout = layout;
    // regist all style cell
    [self.collectionView registerClass:[EPTextOnlyCell class] forCellWithReuseIdentifier:EPCellTypeTextCard];
    [self.collectionView registerClass:[EPScrollCell class] forCellWithReuseIdentifier:EPCellTypeSquareCard];
    [self.collectionView registerClass:[EPNormalCell class] forCellWithReuseIdentifier:EPCellTypeFollowCard];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:EPCellTypeBanner];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:EPCellTypeVideoSmallCard];
    
    [self configData];
}

- (void)configData {
    if (self.apiUrl) {
        
        __block NSMutableArray *tmpArray = [NSMutableArray new];
        @weakify(self);
        EPHomeCollectionViewModel *viewModel = [[EPHomeCollectionViewModel alloc] init];
        [[viewModel.requestCommand execute:self.apiUrl] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            NSArray *models = x[@"itemList"];
            [models enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                EPHomeCollectionViewModel *model = [EPHomeCollectionViewModel yy_modelWithDictionary:obj];
                [tmpArray addObject:model];
            }];
            self.dataSource = tmpArray.copy;
            // release memory
            tmpArray = nil;
            [self.collectionView reloadData];
        }];
    } else {
        [self.view makeToast:@"获取 URL 地址失败" duration:[CSToastManager defaultDuration] position:CSToastPositionCenter];
    }
}

#pragma mark - collection view delegate && datasource
#pragma mark -

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth, [[EPConfigurationManager manager] cellHeightByType:self.dataSource[indexPath.row].type]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EPScrollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.dataSource[indexPath.row].type forIndexPath:indexPath];
    NSLog(@"%@",self.dataSource[indexPath.row].type);
    [cell bindModel:self.dataSource[indexPath.row]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end