//
//  MJDetailViewController~iPad.m
//  Brazil
//
//  Created by Priyank Gandhi on 08/08/14.
//  Copyright (c) 2014 Estuardo. All rights reserved.
//

#import "MJDetailViewController~iPad.h"
#import "Utils.h"

@interface MJDetailViewController_iPad ()

@end

@implementation MJDetailViewController_iPad
@synthesize delegate;
@synthesize imgE,imgH,imgM;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
