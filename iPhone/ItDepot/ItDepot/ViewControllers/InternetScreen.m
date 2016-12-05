//
//  InternetScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "InternetScreen.h"
#import "Utils.h"
#import "SendQuoteScreen.h"
#import "ContactClientScreen.h"
#import "CallMeScreen.h"
#import "ServiceMainScreen.h"
#import "AppDelegate.h"
#import "DashBoardScreen.h"

@interface InternetScreen ()
@property (weak, nonatomic) IBOutlet UIView *cosiderationView;

@end

@implementation InternetScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialDetails];
}

-(void)initialDetails{
    _cosiderationView.layer.borderColor=[[Utils getUIColorFromHexColor:@"d8d8d8" withAlphaValue:1]CGColor];
    _cosiderationView.layer.borderWidth=1.0f;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"in ViewWillAppear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissTheModal{
    NSLog(@"self.navigationController %@",self.navigationController);
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onService:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onCallMe:(id)sender {
    CallMeScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"CallMeScreen"];
    controller.serviceName=SERVICE_INTERNET;
    controller.isFromInternet=YES;
    controller.delegate=self;
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    CGRect tempFrame=self.view.frame;
    tempFrame.origin.y=tempFrame.size.height+125;
    controller.view.frame = tempFrame;
    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         CGRect tempFrame2=appDelegate.window.frame;
                         controller.view.frame = tempFrame2;
                     }
                     completion:^(BOOL finished){
                     }];
    [appDelegate.window addSubview:controller.view];
    
 
//    ServiceMainScreen *serviceScreen=[self.storyboard instantiateViewControllerWithIdentifier:@"CallMeScreen"];
//    CGRect finalFrame = controller.view.frame;
//    [controller.view setFrame:CGRectMake(0, 0, serviceScreen.view.frame.size.width, self.view.frame.size.height)];
//    
//    [UIView animateWithDuration:1.0 animations:^{
//        [self.navigationController setNavigationBarHidden:YES];
//        [self.view addSubview:controller.view];
//        [self.navigationController.view setFrame:finalFrame];
//    }];
//    
//   [self.navigationController presentViewController:controller animated:YES completion:nil];
}

- (IBAction)onSendQuote:(id)sender {
    SendQuoteScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"SendQuoteScreen"];
    controller.serviceName=SERVICE_INTERNET;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)onContactClient:(id)sender {
    ContactClientScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ContactClientScreen"];
    controller.serviceName=SERVICE_INTERNET;
    controller.isFromInternet=YES;
    controller.delegate=self;
//    [self.navigationController presentViewController:controller animated:YES completion:nil];
  //  [self.navigationController pushViewController:controller animated:YES];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    CGRect tempFrame=self.view.frame;
    tempFrame.origin.y=tempFrame.size.height+125;
    controller.view.frame = tempFrame;
    
    [UIView animateWithDuration:0.3
                          delay:0.1
                        options: UIViewAnimationCurveEaseIn
                     animations:^{
                         CGRect tempFrame2=appDelegate.window.frame;
                         controller.view.frame = tempFrame2;
                     }
                     completion:^(BOOL finished){
                     }];
    [appDelegate.window addSubview:controller.view];

}

@end
