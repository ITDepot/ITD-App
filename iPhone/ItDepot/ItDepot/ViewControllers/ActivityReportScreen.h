//
//  ActivityReportScreen.h
//  ItDepot
//
//  Created by iroid on 9/17/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityReportScreen : UIViewController{
}

@property(nonatomic,retain) UINavigationController *navigationQuotesList, *navigationInstallPendingList,*navigationNrIncomeList, *navigationMrIncomeList;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property(nonatomic)BOOL isFromLogin;


@end
