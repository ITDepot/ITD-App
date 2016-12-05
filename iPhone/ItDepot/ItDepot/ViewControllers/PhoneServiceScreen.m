//
//  PhoneServiceScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "PhoneServiceScreen.h"
#import "Utils.h"
#import "CallMeScreen.h"
#import "ContactClientScreen.h"
#import "AppDelegate.h"


@interface PhoneServiceScreen ()
@property (weak, nonatomic) IBOutlet UIView *cosiderationView;

@end

@implementation PhoneServiceScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)initialDetails{
    _cosiderationView.layer.borderColor=[[Utils getUIColorFromHexColor:@"d8d8d8" withAlphaValue:1]CGColor];
    _cosiderationView.layer.borderWidth=1.0f;
}
- (IBAction)onService:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onCallMe:(id)sender {
    CallMeScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"CallMeScreen"];
    controller.serviceName=SERVICES_PHONE;
    controller.isFromPhoneService=YES;
//    [self.navigationController presentViewController:controller animated:YES completion:nil];
    //[self.navigationController pushViewController:controller animated:YES];
    
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
- (IBAction)onContactClient:(id)sender {
    ContactClientScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ContactClientScreen"];
    controller.serviceName=SERVICES_PHONE;
    controller.isFromPhoneService=YES;
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
