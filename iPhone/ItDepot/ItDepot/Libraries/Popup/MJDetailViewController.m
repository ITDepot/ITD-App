//
//  MJDetailViewController.m
//  MJPopupViewControllerDemo
//
//  Created by Martin Juhasz on 24.06.12.
//  Copyright (c) 2012 martinjuhasz.de. All rights reserved.
//

#import "MJDetailViewController.h"
#import "Utils.h"

@implementation MJDetailViewController
@synthesize delegate;
@synthesize imgE,imgH,imgM;

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[Utils stringRetrieveFromUserDefaults:KeyE]isEqualToString:@"YES"])
    {
        [imgE setImage:[UIImage imageNamed:@"check-1"]];
    }
    else
    {
        [imgE setImage:[UIImage imageNamed:@"unchecked"]];
    }
    
    if([[Utils stringRetrieveFromUserDefaults:KeyM]isEqualToString:@"YES"])
    {
        [imgM setImage:[UIImage imageNamed:@"check-1"]];
    }
    else
    {
        [imgM setImage:[UIImage imageNamed:@"unchecked"]];
    }
    
    if([[Utils stringRetrieveFromUserDefaults:KeyH]isEqualToString:@"YES"])
    {
        
        [imgH setImage:[UIImage imageNamed:@"check-1"]];
    }
    else
    {
        
        [imgH setImage:[UIImage imageNamed:@"unchecked"]];
    }

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

-(IBAction)btnEnglishTapped:(id)sender
{
    if(delegate != nil)
    {
        [delegate buttontapped:@"En"];
    }
}
-(IBAction)btnSpanishTapped:(id)sender
{
    if(delegate != nil)
    {
        [delegate buttontapped:@"Sp"];
    }
}

-(IBAction)btnSnscTapped:(id)sender
{
    if(delegate != nil)
    {
        [delegate buttontapped:@"Sync"];
    }
}

-(IBAction)btnTapped:(id)sender
{
    switch ([sender tag]) {
        case 1:
            if([[Utils stringRetrieveFromUserDefaults:KeyE]isEqualToString:@"YES"])
            {
                [Utils stringSaveToUserDefaults:@"NO" withKey:KeyE];
                [imgE setImage:[UIImage imageNamed:@"unchecked"]];
            }
            else
            {
                [Utils stringSaveToUserDefaults:@"YES" withKey:KeyE];
                [imgE setImage:[UIImage imageNamed:@"check-1"]];
            }
            break;
        case 2:
            if([[Utils stringRetrieveFromUserDefaults:KeyM]isEqualToString:@"YES"])
            {
                [Utils stringSaveToUserDefaults:@"NO" withKey:KeyM];
                [imgM setImage:[UIImage imageNamed:@"unchecked"]];
            }
            else
            {
                [Utils stringSaveToUserDefaults:@"YES" withKey:KeyM];
                [imgM setImage:[UIImage imageNamed:@"check-1"]];
            }

            break;
        case 3:
            if([[Utils stringRetrieveFromUserDefaults:KeyH]isEqualToString:@"YES"])
            {
                [Utils stringSaveToUserDefaults:@"NO" withKey:KeyH];
                [imgH setImage:[UIImage imageNamed:@"unchecked"]];
            }
            else
            {
                [Utils stringSaveToUserDefaults:@"YES" withKey:KeyH];
                [imgH setImage:[UIImage imageNamed:@"check-1"]];
            }

            break;
        default:
            break;
    }
}
@end
