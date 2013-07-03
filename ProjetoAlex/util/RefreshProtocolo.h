//
//  RefreshProtocolo.h
//  ProjetoAlex
//
//  Created by AFLM on 28/05/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#define SYNTHESIZE_FETCHED_RESULTS_CONTROLLER \
\
- (UIRefreshControl *)refresh: (UITableView *)tabela\
{\
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];\
    refreshControl.tintColor = [UIColor redColor];\
    [refreshControl addTarget:self action:@selector(actionReloadTable) forControlEvents:UIControlEventValueChanged];\
    [self.tabela addSubview:refreshControl];\
    self.refreshControl = refreshControl;\
    return refreshControl;\
}\
\
\
-(void)actionReloadTable{\
    NSLog(@"TEXTO");\
    [_tabela reloadData];\
    [_refreshControl endRefreshing];\
}
