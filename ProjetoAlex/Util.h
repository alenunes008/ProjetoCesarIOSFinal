//
//  Util.h
//  Exercicio01
//
//  Created by Jalan Solutions on 04/06/12.
//  Copyright (c) 2012 Jalan Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dadosfeeds;
typedef enum{
    tpMenu,
    tpLista,
    tpDetalhes
}IconesBarra;


@interface Util : NSObject{


}

+(UIImage*) getImage:(NSString*) fileName ;
+(void) ScvroviewProx:(UIView *)view1 v:(UIView*)view2;
+(void)layout:(UIViewController *)view1 titulobar:(NSString *)bar tipoIconeBarra :(IconesBarra )iconeBarra;
+(void)dicDetalheFickr:(int)indexPath dic:(NSMutableDictionary *)dic objDados:(Dadosfeeds *)dados;


@end
