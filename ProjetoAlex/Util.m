//
//  Util.m
//  Exercicio01
//
//  Created by Jalan Solutions on 04/06/12.
//  Copyright (c) 2012 Jalan Solutions. All rights reserved.
//

#import "Util.h"
#import "Dadosfeeds.h"
#import "Flickr.h"

@implementation Util

+ (UIImage*) getImage:(NSString*) fileName {
        UIImage* image = nil;
        if (fileName) {
            NSString* urlImg = [NSString stringWithFormat:@"%@", fileName];
            NSURL *url = [[NSURL alloc]initWithString:urlImg];
            NSData* data = [[NSData alloc]initWithContentsOfURL:url];
            if (data) {
                image = [UIImage imageWithData:data];
            }
        }
        return image;
    }
//



//Metodo para empilhar no scrool

+(void) ScvroviewProx:(UIView *)view1 v:(UIView*)view2{
    CGRect frame;
    frame= view1.frame;
    frame.origin.y =view2.frame.origin.y+view2.frame.size.height;
    view1.frame = frame;
}



+(void)layout:(UIViewController *)view1 titulobar:(NSString *)bar tipoIconeBarra :(IconesBarra )iconeBarra{

    
    UIView *viewBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    [viewBar setBackgroundColor:[UIColor colorWithRed:(24/255.f) green:(122/255.f) blue:(159/255.f) alpha:1.0f]];
    
    UIImage *img = [UIImage imageNamed:@"btVoltar.png"];
    UIButton *btnBack = [[UIButton alloc]initWithFrame:CGRectMake(6, 3, 37, 37)];
    [btnBack setImage:img forState:UIControlStateNormal];
    [btnBack addTarget:view1 action:@selector(actionVoltar) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImage *img2 = [UIImage imageNamed:@"btOpcoesTransp.png"];
    UIButton *btnShared = [[UIButton alloc]initWithFrame:CGRectMake(279, 3, 37, 37)];
    [btnShared setImage:img2 forState:UIControlStateNormal];
    [btnShared addTarget:view1 action:@selector(actionShared) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *img3 = [UIImage imageNamed:@"olho.png"];
    UIButton *btnReload = [[UIButton alloc]initWithFrame:CGRectMake(279, 3, 37, 37)];
    [btnReload setImage:img3 forState:UIControlStateNormal];
    [btnReload addTarget:view1 action:@selector(actionReload) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(50, 11, 221, 21)];
    lb.text = bar;
    lb.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:12];
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor  = [UIColor whiteColor];
    lb.adjustsFontSizeToFitWidth = YES;
    lb.textAlignment = NSTextAlignmentCenter;
    
    
    switch (iconeBarra){
            
       case tpMenu :
         [viewBar addSubview:btnReload];
        break;
       case tpLista:
         [viewBar addSubview:btnBack];
        break;
       case tpDetalhes:  
            [viewBar addSubview:btnShared];
            [viewBar addSubview:btnBack];
          break;

       default:
            break;
    }
    
    
    
    [viewBar addSubview:lb];
    [view1.self.view addSubview:viewBar];
    
    
}


+(void)dicDetalheFickr:(int)indexPath dic:(NSMutableDictionary *)dic objDados:(Flickr *)dados{
    [dic setObject:dados.title forKey:@"titulo"];
   // [dic setObject:dados.media.m forKey:@"img"];
    [dic setObject:dados.description forKey:@"descricao"];
    [dic setObject:dados.author forKey:@"autor"];
}


@end
