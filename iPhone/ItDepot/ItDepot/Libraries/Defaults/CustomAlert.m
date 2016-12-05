//
//  CustomAlert.m
//  InGollow
//
//  Created by c58 on 11/12/13.
//  Copyright (c) 2013 c58. All rights reserved.
//

#import "CustomAlert.h"

@implementation CustomAlert

+(void)showAlert:(NSString *)title message:(NSString *)msg canBtntitle:(NSString *)CancelbtnTitle otherBtnTitle:(NSString *)otherBtnTitle
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:CancelbtnTitle otherButtonTitles:otherBtnTitle, nil];
    
    [alert show];
}
@end
