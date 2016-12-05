//
//  ContactClientScreen.h
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ModalViewControllerDelegate <NSObject>

-(void)dismissTheModal;

@end
@interface ContactClientScreen : UIViewController<UITextViewDelegate,UITextFieldDelegate>

@property(strong,nonatomic)NSString *serviceName;
@property(nonatomic)BOOL isFromInternet;
@property(nonatomic)BOOL isFromPhoneService;
@property(nonatomic)bool isFromCablling;
@property (nonatomic, assign) id delegate;
@end
