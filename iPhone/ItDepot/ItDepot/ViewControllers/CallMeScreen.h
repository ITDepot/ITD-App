//
//  CallMeScreen.h
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ModalViewControllerDelegate <NSObject>

-(void)dismissTheModal;

@end

@interface CallMeScreen : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
 UINavigationController *refNavigationController;
}

@property(strong,nonatomic)NSString *serviceName;
@property(nonatomic)BOOL isFromPhoneService;
@property(nonatomic)BOOL isFromCabling;
@property(nonatomic)BOOL isFromInternet;

@property (nonatomic, assign) id delegate;
- (void) setReferencedNavigation:(UINavigationController *)refNavCon;
@end
