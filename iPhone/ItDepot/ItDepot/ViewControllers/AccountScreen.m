//
//  AccountScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "AccountScreen.h"
#import "LoginScreen.h"
#import "RegistrationScreen.h"

@interface AccountScreen ()
@property (weak, nonatomic) IBOutlet UIButton *qoutesButton;
@property (weak, nonatomic) IBOutlet UIButton *installButton;
@property (weak, nonatomic) IBOutlet UIButton *nonRecureButton;
@property (weak, nonatomic) IBOutlet UIButton *monthlyRecureButton;

@end

@implementation AccountScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialDetails];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialDetails{
    _qoutesButton.layer.cornerRadius=6;
    _qoutesButton.layer.masksToBounds=YES;
    _installButton.layer.cornerRadius=6;
    _installButton.layer.masksToBounds=YES;
    _nonRecureButton.layer.cornerRadius=6;
    _nonRecureButton.layer.masksToBounds=YES;
    _monthlyRecureButton.layer.cornerRadius=6;
    _monthlyRecureButton.layer.masksToBounds=YES;
}
- (IBAction)onService:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onLogin:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"] animated:YES];
}
- (IBAction)onRegister:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationScreen"] animated:YES];
}
- (IBAction)onActivityReport:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ActivityReportScreen"] animated:YES];

}
- (IBAction)onQoutes:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"QoutesScreen"] animated:YES];
}
- (IBAction)onInstallPending:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"InstallPendingScreen"] animated:YES];
}
- (IBAction)onNonRecurringIncome:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"NonRecurIncomeScreen"] animated:YES];
}

- (IBAction)onMonthlyRecurringIncome:(id)sender {
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"MonthlyIncomeScreen"] animated:YES];
}

@end
