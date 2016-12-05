//
//  MJDetailViewController.h
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol btnTappedDelegate

-(void)buttontapped:(NSString *)action;

@end

@interface MJDetailViewController : UIViewController

@property (nonatomic,strong)id<btnTappedDelegate> delegate;

@property (nonatomic,strong)IBOutlet UIImageView *imgE,*imgM,*imgH;

@end
