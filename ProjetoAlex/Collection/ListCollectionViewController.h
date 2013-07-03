//
//  ViewController.h
//  CollectionViewExample
//
//  Created by Tim on 9/5/12.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Dadosfeeds;
@interface ListCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)Dadosfeeds *dados;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property(nonatomic,retain)NSArray *flickrs;
@property(nonatomic)BOOL flagFavorito;

@end
