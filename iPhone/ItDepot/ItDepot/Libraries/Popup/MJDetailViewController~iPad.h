//
//  MJDetailViewController~iPad.h
//  Brazil
//
//  Created by Priyank Gandhi on 08/08/14.
//  Copyright (c) 2014 Estuardo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol btnTappedDelegate

-(void)buttontapped:(NSString *)action;

@end

@interface MJDetailViewController_iPad : UIViewController

@property (nonatomic,strong)id<btnTappedDelegate> delegate;

@property (nonatomic,strong)IBOutlet UIImageView *imgE,*imgM,*imgH;

@end
