//
//  RegistrationScreen.h
//  ItDepot
//
//  Created by iroid on 9/17/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

@protocol senddataProtocol <NSObject>

-(void)sendDataToA; //I am thinking my data is NSArray , you can use another object for store your information.

@end


#import <UIKit/UIKit.h>

@interface RegistrationScreen : UIViewController
@property(nonatomic,assign)id delegate;
@property(nonatomic)bool isFromServiceMainScreen;
@end
