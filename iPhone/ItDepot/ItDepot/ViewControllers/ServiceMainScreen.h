//
//  ServiceMainScreen.h
//  ItDepot
//
//  Created by iroid on 9/26/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ServiceMainScreen : UIViewController
@property(nonatomic) int selectedTab;
@property(nonatomic, strong) NSString *momentId;
@property(nonatomic)BOOL isFromInternet;
@property(nonatomic)BOOL isFromPhoneService;
@property(nonatomic)BOOL isFromCabling;
@property(nonatomic,retain) UINavigationController *navigationInternet, *navigationPhone,*navigationCable;
@property (weak, nonatomic) IBOutlet UIView *containerView;


@end
