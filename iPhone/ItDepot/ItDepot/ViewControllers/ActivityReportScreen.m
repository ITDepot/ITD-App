//
//  ActivityReportScreen.m
//  ItDepot
//
//  Created by iroid on 9/17/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "ActivityReportScreen.h"
#import "QoutesScreen.h"
#import "InstallPendingScreen.h"
#import "NonRecurIncomeScreen.h"
#import "MonthlyIncomeScreen.h"
#import "FileManager.h"
#import "EditProfileScreen.h"
#import "Utils.h"
#import "RequestManager.h"

#define TAB_QUOTES                           11
#define TAB_INSTALL_PENDING                  12
#define TAB_NR_INCOM                         13
#define TAB_MR_INCOME                      14


@interface ActivityReportScreen ()<RequestManagerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *qoutesButton;
@property (weak, nonatomic) IBOutlet UIButton *installPendingButton;
@property (weak, nonatomic) IBOutlet UIButton *nrIncomeButton;
@property (weak, nonatomic) IBOutlet UIButton *mrIncomeButton;
@property (weak, nonatomic) IBOutlet UILabel *accountTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userEmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;
@property (weak, nonatomic) IBOutlet UIView *registrationPopView;

@end

@implementation ActivityReportScreen
@synthesize navigationInstallPendingList,navigationMrIncomeList,navigationNrIncomeList,navigationQuotesList,isFromLogin;
int currentTab;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkValidityOfUser];
    [self initializeTabs];
    [self initializeViews];
    _registrationPopView.hidden=YES;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showRegistrationView:) name:NOTIFICATION_SHOW_REGISTRATION_VIEW object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshView:) name:REFRESH_PROFILE_SCREEN object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)refreshView:(NSNotification *)notification{
    [self initialDetails];
}

-(void)showRegistrationView:(NSNotification *)notification{
    _registrationPopView.hidden=NO;
}

-(void)initialDetails{
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    if(otherDetails==nil){
        otherDetails=[[NSMutableDictionary alloc]init];
    }
  //  _userNameLabel.text=[NSString stringWithFormat:@"%@ %@",[otherDetails objectForKey:FIRST_NAME],[otherDetails objectForKey:LAST_NAME]];
    _userNameLabel.text=[otherDetails objectForKey:FIRST_NAME];
    _userEmailLabel.text=[otherDetails objectForKey:EMAIL_ID];
    _userPhoneLabel.text=[otherDetails objectForKey:PHONE];
    
}

- (void)initializeTabs{
    QoutesScreen *quotesListScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"QoutesScreen"];
    navigationQuotesList = [[UINavigationController alloc]initWithRootViewController:quotesListScreen];
    
    InstallPendingScreen *installPendingListScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"InstallPendingScreen"];
    navigationInstallPendingList = [[UINavigationController alloc]initWithRootViewController:installPendingListScreen];
    
    NonRecurIncomeScreen *nrIncomeListScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"NonRecurIncomeScreen"];
    navigationNrIncomeList = [[UINavigationController alloc]initWithRootViewController:nrIncomeListScreen];
    
    MonthlyIncomeScreen *mRIncomeListScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"MonthlyIncomeScreen"];
    navigationMrIncomeList = [[UINavigationController alloc]initWithRootViewController:mRIncomeListScreen];
}

- (void)initializeViews{
    
    //    if([Utils isUserAlreadyloggedIn]){
    _accountTypeLabel.text=@"Quotes";
    [self showQoutes];
    //    }else{
    //        [self showLoginOptionsView];
    //    }
}
- (IBAction)onCancle:(id)sender {
    _registrationPopView.hidden=YES;
}
- (IBAction)onRegister:(id)sender {
    _registrationPopView.hidden=YES;
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationScreen"] animated:YES];
}

- (IBAction)onBack:(id)sender {
    if(isFromLogin){
        NSArray *array = [self.navigationController viewControllers];
        [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)onEditProfile:(id)sender {
    EditProfileScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"EditProfileScreen"];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (IBAction)onService:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
- (IBAction)onQoutes:(id)sender {
     _accountTypeLabel.text=@"Requests";
    [self showQoutes];
}
- (IBAction)onInstallPending:(id)sender {
     _accountTypeLabel.text=@"Pending";
    [self showInstallPending];
}
- (IBAction)onNrIncome:(id)sender {
    _accountTypeLabel.text=@"Non-Recurring Income";
    [self showNrIncome];
}
- (IBAction)onMrIncome:(id)sender {
    _accountTypeLabel.text=@"Monthly Recurring Income";

    [self showMrIncome];
}

-(void)showQoutes{
    _qoutesButton.userInteractionEnabled=NO;
    _installPendingButton.userInteractionEnabled=YES;
    _nrIncomeButton.userInteractionEnabled=YES;
    _mrIncomeButton.userInteractionEnabled=YES;
    
    if(currentTab!=TAB_QUOTES){
        currentTab = TAB_QUOTES;
    }
    
    [_qoutesButton setBackgroundImage:[UIImage imageNamed:@"tab_selected.png"] forState:UIControlStateNormal];
    [_installPendingButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_nrIncomeButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_mrIncomeButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    
    [_qoutesButton setTitleColor:[Utils getUIColorFromHexColor:@"ffffff" withAlphaValue:1] forState:UIControlStateNormal];
    [_installPendingButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_nrIncomeButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_mrIncomeButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    
    for(UIView *view in [_containerView subviews]){
        [view removeFromSuperview];
    }
    navigationQuotesList.navigationBar.translucent = NO;
    navigationQuotesList.navigationBar.opaque = YES;
    navigationQuotesList.navigationBar.tintColor = [UIColor blackColor];
    navigationQuotesList.navigationBar.hidden=YES;
    
    navigationQuotesList.view.frame = _containerView.bounds;
    
    NSLog(@"COntainerView2 Frame %@",NSStringFromCGRect(_containerView.frame));
    NSLog(@"Navigation1 Frame %@",NSStringFromCGRect(navigationQuotesList.view.frame));
    NSLog(@"Navigation2 Frame %@",NSStringFromCGRect(navigationQuotesList.view.frame));
    [_containerView addSubview:navigationQuotesList.view];

}

-(void)showInstallPending{
    _qoutesButton.userInteractionEnabled=YES;
    _installPendingButton.userInteractionEnabled=NO;
    _nrIncomeButton.userInteractionEnabled=YES;
    _mrIncomeButton.userInteractionEnabled=YES;
    
    if(currentTab!=TAB_INSTALL_PENDING){
        currentTab = TAB_INSTALL_PENDING;
    }
    
    [_qoutesButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_installPendingButton setBackgroundImage:[UIImage imageNamed:@"tab_selected.png"] forState:UIControlStateNormal];
    [_nrIncomeButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_mrIncomeButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    
    [_qoutesButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_installPendingButton setTitleColor:[Utils getUIColorFromHexColor:@"ffffff" withAlphaValue:1] forState:UIControlStateNormal];
    [_nrIncomeButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_mrIncomeButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];

    
    for(UIView *view in [_containerView subviews]){
        [view removeFromSuperview];
    }
    navigationInstallPendingList.navigationBar.translucent = NO;
    navigationInstallPendingList.navigationBar.opaque = YES;
    navigationInstallPendingList.navigationBar.tintColor = [UIColor blackColor];
    navigationInstallPendingList.navigationBar.hidden=YES;
    
    navigationInstallPendingList.view.frame = _containerView.bounds;
    
    NSLog(@"COntainerView2 Frame %@",NSStringFromCGRect(_containerView.frame));
    NSLog(@"Navigation1 Frame %@",NSStringFromCGRect(navigationInstallPendingList.view.frame));
    NSLog(@"Navigation2 Frame %@",NSStringFromCGRect(navigationInstallPendingList.view.frame));
    [_containerView addSubview:navigationInstallPendingList.view];
    
}

-(void)showNrIncome{
    _qoutesButton.userInteractionEnabled=YES;
    _installPendingButton.userInteractionEnabled=YES;
    _nrIncomeButton.userInteractionEnabled=NO;
    _mrIncomeButton.userInteractionEnabled=YES;
    
    if(currentTab!=TAB_NR_INCOM){
        currentTab = TAB_NR_INCOM;
    }
    
    [_qoutesButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_installPendingButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_nrIncomeButton setBackgroundImage:[UIImage imageNamed:@"tab_selected.png"] forState:UIControlStateNormal];
    [_mrIncomeButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    
    [_qoutesButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_installPendingButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_nrIncomeButton setTitleColor:[Utils getUIColorFromHexColor:@"ffffff" withAlphaValue:1] forState:UIControlStateNormal];
    [_mrIncomeButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    
    for(UIView *view in [_containerView subviews]){
        [view removeFromSuperview];
    }
    navigationNrIncomeList.navigationBar.translucent = NO;
    navigationNrIncomeList.navigationBar.opaque = YES;
    navigationNrIncomeList.navigationBar.tintColor = [UIColor blackColor];
    navigationNrIncomeList.navigationBar.hidden=YES;
    
    navigationNrIncomeList.view.frame = _containerView.bounds;
    
    NSLog(@"COntainerView2 Frame %@",NSStringFromCGRect(_containerView.frame));
    NSLog(@"Navigation1 Frame %@",NSStringFromCGRect(navigationNrIncomeList.view.frame));
    NSLog(@"Navigation2 Frame %@",NSStringFromCGRect(navigationNrIncomeList.view.frame));
    [_containerView addSubview:navigationNrIncomeList.view];

}

-(void)showMrIncome{
    _qoutesButton.userInteractionEnabled=YES;
    _installPendingButton.userInteractionEnabled=YES;
    _nrIncomeButton.userInteractionEnabled=YES;
    _mrIncomeButton.userInteractionEnabled=NO;

    
    if(currentTab!=TAB_MR_INCOME){
        currentTab = TAB_MR_INCOME;
    }
    
    [_qoutesButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_installPendingButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_nrIncomeButton setBackgroundImage:[UIImage imageNamed:@"tab_unselected.png"] forState:UIControlStateNormal];
    [_mrIncomeButton setBackgroundImage:[UIImage imageNamed:@"tab_selected.png"] forState:UIControlStateNormal];
    
    [_qoutesButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_installPendingButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_nrIncomeButton setTitleColor:[Utils getUIColorFromHexColor:@"36474f" withAlphaValue:1] forState:UIControlStateNormal];
    [_mrIncomeButton setTitleColor:[Utils getUIColorFromHexColor:@"ffffff" withAlphaValue:1] forState:UIControlStateNormal];
    
    for(UIView *view in [_containerView subviews]){
        [view removeFromSuperview];
    }
    navigationMrIncomeList.navigationBar.translucent = NO;
    navigationMrIncomeList.navigationBar.opaque = YES;
    navigationMrIncomeList.navigationBar.tintColor = [UIColor blackColor];
    navigationMrIncomeList.navigationBar.hidden=YES;
    
    navigationMrIncomeList.view.frame = _containerView.bounds;
    
    NSLog(@"COntainerView2 Frame %@",NSStringFromCGRect(_containerView.frame));
    NSLog(@"Navigation1 Frame %@",NSStringFromCGRect(navigationMrIncomeList.view.frame));
    NSLog(@"Navigation2 Frame %@",NSStringFromCGRect(navigationMrIncomeList.view.frame));
    [_containerView addSubview:navigationMrIncomeList.view];
    
}

-(void)checkValidityOfUser{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
//        [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_IS_USER_VALID];
        
        NSMutableDictionary *parametersDictionary=[[NSMutableDictionary alloc]init];
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if(otherDetails==nil){
            otherDetails=[[NSMutableDictionary alloc]init];
        }
        if([Utils isUserAlreadyloggedIn]){
            
            [parametersDictionary setObject:[otherDetails objectForKey:USER_IDD] forKey:USER_IDD];
        }else{
            [parametersDictionary setObject:@"-1" forKey:USER_IDD];
        }
        requestManager.commandName=REQUEST_IS_USER_VALID;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_IS_USER_VALID];
        
    }else{
        [Utils hideIndicator];
        [Utils showNoInternetConnectionAlertDialog];
    }
    
    
}

- (void) onResult:(NSDictionary *)result{
    NSLog(@"Result %@",result);
    [Utils hideIndicator];
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_IS_USER_VALID]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            [self initialDetails];
        }
        else{
          //  int error_code = [[result objectForKey:CODE] intValue];
           // if(error_code == 99){
         //       _registrationPopView.hidden=NO;
                FileManager *fileManager=[[FileManager alloc]init];
                NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
                [otherDetails removeAllObjects];
                [fileManager writeOtherSettingsData:otherDetails];
         //   }else{
                NSString *message=[result objectForKey:MESSAGE];
                if(message==nil || [message isEqualToString:@""]){
                    message=ALERT_MESSAGE_SOMETHING_WENT_WRONG;
                }
           //     [Utils showAlertMessage:message];
           // }
        }
        
    }
}

- (void)onFault:(NSError *)error{
    NSLog(@"errorrr %@",error);
    [Utils hideIndicator];
    [Utils showAlertMessage:error.localizedDescription];
}


@end
