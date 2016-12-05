//
//  ViewController.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "ViewController.h"
#import "Utils.h"
#import "FileManager.h"
#import "DashBoardScreen.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [self initializeApplication];
    [self initializeSplashTimers];

}

- (void)initializeApplication{
    [self createAndInitializeFilesSystem];
    //[self createAndInitializeDataBaseSystem];
}

- (void) initializeSplashTimers{
    splashCounter=0;
    splashTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFunction:) userInfo:nil repeats:YES];
}

- (void) timerFunction :(NSTimer *) sender{
    splashCounter++;
    if (splashCounter==3){
        splashCounter=0;
        if (splashTimer){
            [splashTimer invalidate];
            splashTimer=nil;
        }
        [self showNextScreen];
    }
}
-(void)showNextScreen{
    NSLog(@"Show NextScreen");
    //[self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"DashBoardScreen"] animated:YES];
    DashBoardScreen *dashboardScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"DashBoardScreen"];
    [self.navigationController setViewControllers:[NSArray arrayWithObject:dashboardScreen] animated:YES];

}


- (void) createAndInitializeFilesSystem{
    FileManager *fileManager =[[FileManager alloc] init];
    [fileManager initializeFileSystem];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
