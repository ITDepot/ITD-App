//
//  SendQuoteScreen.h
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendQuoteScreen : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property(strong,nonatomic) NSString *serviceName;

@end