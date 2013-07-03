//
//  Dadosfeeds.m
//  Exercicio01
//
//  Created by Jalan Solutions on 01/06/12.
//  Copyright (c) 2012 Jalan Solutions. All rights reserved.
//

#import "Dadosfeeds.h"
//Componentes
#import "NSString+HTML.h"
//Model
#import "Flickr.h"

#define url_json @"http://api.flickr.com/services/feeds/photos_public.gne?format=json&format=json&nojsoncallback=1"

@implementation Dadosfeeds{
    NSError __autoreleasing* *theError ;
       id _jsonResponse;



}
@synthesize dados = _dados;
@synthesize currentIndex = _currentIndex;


-(void)conexao{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_json]];
    NSData *contentData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error: theError];
    
    NSMutableString *temp = [[NSMutableString alloc]initWithData:contentData encoding:NSUTF8StringEncoding];
    
    
    temp = [[temp stringByReplacingOccurrencesOfString:@"\t" withString:@"  "] mutableCopy];
    temp = [[temp stringByReplacingOccurrencesOfString:@"\b" withString:@" "] mutableCopy];
    temp = [[temp stringByReplacingOccurrencesOfString:@"\n" withString:@""] mutableCopy];
    temp = [[temp stringByReplacingOccurrencesOfString:@"\r" withString:@""] mutableCopy];
    temp = [[temp stringByReplacingOccurrencesOfString:@"\f" withString:@""] mutableCopy];
    temp = [[temp stringByReplacingOccurrencesOfString:@"\'" withString:@"'"] mutableCopy];
    temp = [[temp stringByReplacingOccurrencesOfString:@"\\\"" withString:@""] mutableCopy];
    temp = [[temp stringByReplacingOccurrencesOfString:@"\\" withString:@" "] mutableCopy];
   

    
    NSData* jsonData = [temp dataUsingEncoding:NSUTF8StringEncoding];
        
    _jsonResponse = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:theError];
           
}

- (NSArray*)reloadDados{
    
    [self conexao];
    
    if (!theError) {
        
        if ([_jsonResponse isKindOfClass:[NSDictionary class]]) {
            
            NSArray  * items = [_jsonResponse objectForKey:@"items"];
            for (NSDictionary *dictionary in items) {
                Flickr *oFlickr = [[Flickr alloc]init];
               NSMutableArray  *_media       = [[NSMutableArray alloc]init];

                [_media addObject:[dictionary objectForKey:@"media"]];
                [oFlickr setMedia:[dictionary objectForKey:@"media"]];                  
                [oFlickr setTitle:[dictionary objectForKey:@"title"]];                    
                NSString *_descricao = [[dictionary objectForKey:@"description"]stringByConvertingHTMLToPlainText ];
                [oFlickr setDescription:_descricao];
                [oFlickr setAuthor:[dictionary objectForKey:@"author"]];
                //link da imagens
                for (NSDictionary *dic in _media) {
                    [oFlickr setM:[dic objectForKey:@"m"]];
                }
                [_dados addObject:oFlickr];
                
            }
           
        }
    }
    return _dados;
}

-(id)init{
    self = [super init];
    _dados       = [[NSMutableArray alloc]init];

    if (self) {
           }
    return self;
}
+ (id) defaultHandler {
    static dispatch_once_t pred = 0;
    __strong static id defaultHandler = nil;
    dispatch_once(&pred, ^{
        defaultHandler = [[self alloc] init];
    });
    
    [defaultHandler loadDados];
    [defaultHandler loadPag];
    
    return defaultHandler;
}

#pragma mark metodos do auxiliares singloton
-(NSArray *)loadDados
{
    return _dados;
}
//METODO PARA FAZER LOAD DA PAG NO SWIPE
-(NSInteger)loadPag
{
    return _currentIndex;
}
-(void)addDadosRand:(NSInteger)rand
{
    _currentIndex = rand;
}


@end
