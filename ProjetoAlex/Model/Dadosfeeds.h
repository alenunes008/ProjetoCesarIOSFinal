//
//  Dadosfeeds.h
//  Exercicio01
//
//  Created by Jalan Solutions on 01/06/12.
//  Copyright (c) 2012 Jalan Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Flickr;
@interface Dadosfeeds : NSObject
{
        

}
@property(nonatomic,retain)NSMutableArray *dados;
@property(nonatomic)NSUInteger currentIndex;

-(id)init;
+ (id) defaultHandler;
-(NSArray *)loadDados;
- (NSArray*)reloadDados;


-(void)addDadosRand:(NSInteger)rand;
-(NSInteger)loadPag;


@end
