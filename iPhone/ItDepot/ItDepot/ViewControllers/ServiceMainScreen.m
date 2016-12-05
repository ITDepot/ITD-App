//
//  ServiceMainScreen.m
//  ItDepot
//
//  Created by iroid on 9/26/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "ServiceMainScreen.h"
#import "CarbonKit.h"
#import "InternetScreen.h"
#import "PhoneServiceScreen.h"
#import "CablingScreen.h"
#import "Utils.h"
#import "CallMeScreen.h"
#import "ContactClientScreen.h"
#import "RegistrationScreen.h"
#import "FileManager.h"

#define TAB_INTERNET               11
#define TAB_PHONE                  12
#define TAB_CABLE                  13


@interface ServiceMainScreen ()
{
    NSArray *items;
    CarbonTabSwipeNavigation *carbonTabSwipeNavigation;
    InternetScreen *internetViewController;
    PhoneServiceScreen *phoneServiceViewController;
    CablingScreen *cablingViewController;
    NSString *title;
}
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UIButton *phoneServiceButton;
@property (weak, nonatomic) IBOutlet UIButton *internetButton;
@property (weak, nonatomic) IBOutlet UIButton *cabllingButton;
@property (weak, nonatomic) IBOutlet UIView *internetContainerView;
@property (weak, nonatomic) IBOutlet UIView *cabllingContainerView;
@property (weak, nonatomic) IBOutlet UIView *phoneContainerView;

@property (weak, nonatomic) IBOutlet UIView *internetConsiderationView;
@property (weak, nonatomic) IBOutlet UIView *cabllingConsiderationView;
@property (weak, nonatomic) IBOutlet UIView *phoneConsiderationView;
@property (weak, nonatomic) IBOutlet UIView *registrationConfirmationView;

@end

@implementation ServiceMainScreen
@synthesize isFromCabling,isFromInternet,isFromPhoneService,navigationCable,navigationInternet,navigationPhone;
int currentTab;
int indexx,isPhoneShown,isInternetShown,isCableShown;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeTabs];
    [self initializeViews];
    _registrationConfirmationView.hidden=YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateScreen:) name:NOTIFICATION_UPDATE_SCREEN object:nil];
    
    _internetConsiderationView.layer.borderColor=[[Utils getUIColorFromHexColor:@"d8d8d8" withAlphaValue:1]CGColor];
    _internetConsiderationView.layer.borderWidth=1.0f;
    
    _cabllingConsiderationView.layer.borderColor=[[Utils getUIColorFromHexColor:@"d8d8d8" withAlphaValue:1]CGColor];
    _cabllingConsiderationView.layer.borderWidth=1.0f;

    _phoneConsiderationView.layer.borderColor=[[Utils getUIColorFromHexColor:@"d8d8d8" withAlphaValue:1]CGColor];
    _phoneConsiderationView.layer.borderWidth=1.0f;


//    indexx=0;
//   //    items = @[[UIImage imageNamed:@"temp_image.png"], [UIImage imageNamed:@"temp_image.png"],
////                       [UIImage imageNamed:@"temp_image.png"]];
//    items = @[@"", @"",@""];
//    
//    carbonTabSwipeNavigation = [[CarbonTabSwipeNavigation alloc] initWithItems:items delegate:self];
//    [carbonTabSwipeNavigation setTabBarHeight:0];
//    [carbonTabSwipeNavigation insertIntoRootViewController:self];
//    
//    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
//                                                           NSFontAttributeName:[UIFont fontWithName:@"Avenir-Medium" size:17]} forState:UIControlStateNormal];
//    [self style];
//    //    if (self.selectedTab != 0) {
//    [carbonTabSwipeNavigation setCurrentTabIndex:self.selectedTab];
//   // [self setTitleText:self.selectedTab];
//    //    }else if(momentId != nil){
//    ////        momentsViewController.momentId = momentId;
//    //    }
  
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    
//    [self.view bringSubviewToFront:_headerView];
//    [self.view bringSubviewToFront:_tabView];

}

-(void)updateScreen:(NSNotification *)notification{
    [self initializeTabs];
    [self initializeViews];
    [self.view bringSubviewToFront:_headerView];
    [self.view bringSubviewToFront:_tabView];
}

- (void)initializeTabs{
   //    InternetScreen *internetScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"InternetScreen"];
//    navigationInternet = [[UINavigationController alloc]initWithRootViewController:internetScreen];
//    
//    PhoneServiceScreen *phoneServiceScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"PhoneServiceScreen"];
//    navigationPhone = [[UINavigationController alloc]initWithRootViewController:phoneServiceScreen];
//    
//    CablingScreen *cableScreen = [self.storyboard instantiateViewControllerWithIdentifier:@"CablingScreen"];
//    navigationCable = [[UINavigationController alloc]initWithRootViewController:cableScreen];
//    
}

- (void)initializeViews{
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    NSString *clickedService=[otherDetails objectForKey:CLICKE_SERVICE];
    if([clickedService isEqualToString:@"1"]){
        isFromInternet=YES;
    }else if ([clickedService isEqualToString:@"2"]){
        isFromPhoneService=YES;
    }else{
        isFromCabling=YES;
    }
    
    
    if(isFromInternet){
        [self showInternet];
        isInternetShown=1;
        isPhoneShown=0;
        isCableShown=0;
    }
    if(isFromPhoneService){
        [self showPhone];
        isPhoneShown=1;
        isInternetShown=0;
        isCableShown=0;
    }
    if(isFromCabling){
        [self showCable];
        isCableShown=1;
        isPhoneShown=0;
        isInternetShown=0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onAppLogo:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)onCancle:(id)sender {
    _registrationConfirmationView.hidden=YES;
}
- (IBAction)onContinue:(id)sender {
    _registrationConfirmationView.hidden=YES;
    RegistrationScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationScreen"];
    controller.isFromServiceMainScreen=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onService:(id)sender {
   // [self.navigationController popToRootViewControllerAnimated:YES];
    if(![Utils isUserAlreadyloggedIn]){
        _registrationConfirmationView.hidden=NO;
    }else{
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ActivityReportScreen"] animated:YES];
    }
}
- (IBAction)onPhoneService:(id)sender {
    if(isPhoneShown==0 && isInternetShown==1){
        [self showPhone];
        isPhoneShown=1;
        isInternetShown=0;
        isCableShown=0;
    }
    else if(isInternetShown==0){
        [self showInternet];
        isInternetShown=1;
        isPhoneShown=0;
        isCableShown=0;
    }else{
        [self showCable];
        isCableShown=1;
        isPhoneShown=0;
        isInternetShown=0;
    }
}
- (IBAction)onCablling:(id)sender {
    if(isCableShown==0){
         [self showCable];
        isCableShown=1;
        isPhoneShown=0;
        isInternetShown=0;
    }else if(isPhoneShown==0){
        [self showPhone];
        isPhoneShown=1;
        isCableShown=0;
        isInternetShown=0;
    }else{
        [self showInternet];
        isInternetShown=1;
        isPhoneShown=0;
        isCableShown=0;
    }
   
}
- (IBAction)onInternet:(id)sender {
    [self showInternet];
}

- (IBAction)onContactMe:(id)sender {
    if(![Utils isUserAlreadyloggedIn]){
        _registrationConfirmationView.hidden=NO;
        return;
    }
    int tag=(int)[sender tag];
    CallMeScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"CallMeScreen"];
    if (tag==101) {
        controller.serviceName=SERVICE_INTERNET;
        controller.isFromInternet=YES;
        
    }else if (tag==102) {
        controller.serviceName=SERVICE_CABLLING;
        controller.isFromCabling=YES;
        
    }else if (tag==103) {
        controller.serviceName=SERVICES_PHONE;
        controller.isFromPhoneService=YES;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

- (IBAction)onContactClient:(id)sender {
    if(![Utils isUserAlreadyloggedIn]){
        _registrationConfirmationView.hidden=NO;
        return;
    }
    int tag=(int)[sender tag];
    ContactClientScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ContactClientScreen"];
    if (tag==201) {
        controller.serviceName=SERVICE_INTERNET;
        controller.isFromInternet=YES;
        
    }else if (tag==202) {
        controller.serviceName=SERVICE_CABLLING;
        controller.isFromCablling=YES;

        
    }else if (tag==203) {
        controller.serviceName=SERVICES_PHONE;
        controller.isFromPhoneService=YES;

    }
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)showInternet{
    _internetContainerView.hidden=NO;
    _phoneContainerView.hidden=YES;
    _cabllingContainerView.hidden=YES;

//    _phoneServiceButton.userInteractionEnabled=YES;
//    _cabllingButton.userInteractionEnabled=YES;
//    _internetButton.userInteractionEnabled=NO;
//  
//    if(currentTab!=TAB_INTERNET){
//        currentTab = TAB_INTERNET;
//    }
//    
    [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
    [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
    [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
//
//    
//    
//    for(UIView *view in [_containerView subviews]){
//        [view removeFromSuperview];
//    }
//    navigationInternet.navigationBar.translucent = NO;
//    navigationInternet.navigationBar.opaque = YES;
//    navigationInternet.navigationBar.tintColor = [UIColor blackColor];
//    navigationInternet.navigationBar.hidden=YES;
//    
//    navigationInternet.view.frame = _containerView.bounds;
//    
//    NSLog(@"COntainerView2 Frame %@",NSStringFromCGRect(_containerView.frame));
//    NSLog(@"Navigation1 Frame %@",NSStringFromCGRect(navigationInternet.view.frame));
//    NSLog(@"Navigation2 Frame %@",NSStringFromCGRect(navigationInternet.view.frame));
//    [_containerView addSubview:navigationInternet.view];
    
}

-(void)showPhone{
    _internetContainerView.hidden=YES;
    _phoneContainerView.hidden=NO;
    _cabllingContainerView.hidden=YES;
    
//    _phoneServiceButton.userInteractionEnabled=YES;
//    _cabllingButton.userInteractionEnabled=YES;
//    _internetButton.userInteractionEnabled=NO;
//    
//    if(currentTab!=TAB_PHONE){
//        currentTab = TAB_PHONE;
//    }
//    
    [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
    [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
    [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
//
//    
//    
//    for(UIView *view in [_containerView subviews]){
//        [view removeFromSuperview];
//    }
//    navigationPhone.navigationBar.translucent = NO;
//    navigationPhone.navigationBar.opaque = YES;
//    navigationPhone.navigationBar.tintColor = [UIColor blackColor];
//    navigationPhone.navigationBar.hidden=YES;
//    
//    navigationPhone.view.frame = _containerView.bounds;
//    
//    NSLog(@"COntainerView2 Frame %@",NSStringFromCGRect(_containerView.frame));
//    NSLog(@"Navigation1 Frame %@",NSStringFromCGRect(navigationPhone.view.frame));
//    NSLog(@"Navigation2 Frame %@",NSStringFromCGRect(navigationPhone.view.frame));
//    [_containerView addSubview:navigationPhone.view];
    
}

-(void)showCable{
    _internetContainerView.hidden=YES;
    _phoneContainerView.hidden=YES;
    _cabllingContainerView.hidden=NO;
//    
//    _phoneServiceButton.userInteractionEnabled=YES;
//    _cabllingButton.userInteractionEnabled=YES;
//    _internetButton.userInteractionEnabled=NO;
//    
//    if(currentTab!=TAB_CABLE){
//        currentTab = TAB_CABLE;
//    }
//    
    [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
    [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
    [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
//
//    
//    for(UIView *view in [_containerView subviews]){
//        [view removeFromSuperview];
//    }
//    navigationCable.navigationBar.translucent = NO;
//    navigationCable.navigationBar.opaque = YES;
//    navigationCable.navigationBar.tintColor = [UIColor blackColor];
//    navigationCable.navigationBar.hidden=YES;
//    
//    navigationCable.view.frame = _containerView.bounds;
//    
//    NSLog(@"COntainerView2 Frame %@",NSStringFromCGRect(_containerView.frame));
//    NSLog(@"Navigation1 Frame %@",NSStringFromCGRect(navigationCable.view.frame));
//    NSLog(@"Navigation2 Frame %@",NSStringFromCGRect(navigationCable.view.frame));
//    [_containerView addSubview:navigationCable.view];
//    
}


- (void)style {
    
    
//    UIColor *color = [UIColor colorWithRed:24.0/255 green:75.0/255 blue:152.0/255 alpha:1];
    //    if (![Utils isTeacher]) {
    //       color = [UIColor colorWithRed:204.0/255 green:65.0/255 blue:37.0/255 alpha:1];
    //    }
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = color;
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    carbonTabSwipeNavigation.toolbar.translucent = NO;
//    [carbonTabSwipeNavigation setIndicatorColor:color];
    [carbonTabSwipeNavigation setIndicatorHeight:2.2];
    CGFloat width = [UIScreen mainScreen].bounds.size.width/3.0f;
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:width forSegmentAtIndex:0];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:width forSegmentAtIndex:1];
    [carbonTabSwipeNavigation.carbonSegmentedControl setWidth:width forSegmentAtIndex:2];
   
//    [carbonTabSwipeNavigation setNormalColor:[color colorWithAlphaComponent:0.6]
//                                        font:[UIFont fontWithName:@"Avenir-Book" size:15]];
//    [carbonTabSwipeNavigation setSelectedColor:color
//                                          font:[UIFont fontWithName:@"Avenir-Book" size:15]];
    carbonTabSwipeNavigation.carbonTabSwipeScrollView.scrollEnabled = NO;
    //    [carbonTabSwipeNavigation.carbonSegmentedControl ]
}

# pragma mark - CarbonTabSwipeNavigation Delegate
// required
- (nonnull UIViewController *)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbontTabSwipeNavigation
                                 viewControllerAtIndex:(NSUInteger)index {
    indexx=(int)index;
    switch (index) {
        case 0:
            if (internetViewController == nil) {
                internetViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"InternetScreen"];
            }
            
            return internetViewController;
            
        case 1:
            if (phoneServiceViewController == nil) {
                phoneServiceViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PhoneServiceScreen"];
            }
            return phoneServiceViewController;
            
        case 2:
            if (cablingViewController == nil) {
                cablingViewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"CablingScreen"];
            }
            
            return cablingViewController;
            
        default:
            return [[UIViewController alloc] init];
    }
    
}

// optional
- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                 willMoveAtIndex:(NSUInteger)index {
    indexx=(int)index;
    //[self setTitleText:index];
    if(index==0){
        [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
        [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
        [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
    }else if(index==1){
        [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
        [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
        [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
        
    }else{
        [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
        [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
        [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
        
    }

}

- (void)carbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation
                  didMoveAtIndex:(NSUInteger)index {
    indexx=(int)index;
    if(index==0){
        [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
        [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
        [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
    }else if(index==1){
        [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
        [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
        [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
        
    }else{
        [_phoneServiceButton setBackgroundImage:[UIImage imageNamed:@"rect_internet.png"] forState:UIControlStateNormal];
        [_internetButton setBackgroundImage:[UIImage imageNamed:@"rect_cablling.png"] forState:UIControlStateNormal];
        [_cabllingButton setBackgroundImage:[UIImage imageNamed:@"rect_phone_service.png"] forState:UIControlStateNormal];
        
    }
    NSLog(@"Did move at index: %ld", index);
}

- (UIBarPosition)barPositionForCarbonTabSwipeNavigation:(nonnull CarbonTabSwipeNavigation *)carbonTabSwipeNavigation {
    return UIBarPositionTop; // default UIBarPositionTop
}

-(void) setTitleText:(NSUInteger) index{
    indexx=(int)index;
    switch(index) {
        case 0:
            self.title = @"Moments";
            break;
        case 1:
            [self setTitle:@"Parent Updates"];
            break;
        case 2:
            self.title = @"Class Annoucements";
            break;
        case 3:
            self.title = @"Profile";
            break;
        default:
            self.title = items[index];
            break;
    }
    title = self.title;
}


@end
