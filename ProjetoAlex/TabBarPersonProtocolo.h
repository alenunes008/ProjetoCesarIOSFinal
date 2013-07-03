//
//  TabBarPersonProtocolo.h
//  ProjetoAlex
//
//  Created by AFLM on 28/05/13.
//  Copyright (c) 2013 Jalan Solutions. All rights reserved.
//

#define BARRA_PADRAO \
\
-(void)actionVoltar\
{\
    [self.navigationController popToRootViewControllerAnimated:YES];\
}\
\
\
-(void)actionVoltarRoot\
{\
    [self.navigationController popToRootViewControllerAnimated:YES];\
}\
\
\
-(void)actionReload\
{\
    [self performSelector:@selector(verifyConnectionAndPlacePresenceLoad)];\
}


