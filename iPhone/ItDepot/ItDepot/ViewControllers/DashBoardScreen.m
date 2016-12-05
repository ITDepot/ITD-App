//
//  DashBoardScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "DashBoardScreen.h"
#import "FileManager.h"
#import "Utils.h"
#import "BSKeyboardControls.h"
#import "RequestManager.h"
#import "ServiceMainScreen.h"
#import "RegistrationScreen.h"
#import "ActivityReportScreen.h"

@interface DashBoardScreen ()<BSKeyboardControlsDelegate,UITextFieldDelegate,RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *incomeView;
@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;
@property (weak, nonatomic) IBOutlet UIView *agentPopUpView;
@property (weak, nonatomic) IBOutlet UITextField *agentIdTextField;
@property (weak, nonatomic) IBOutlet UIButton *okButton;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (weak, nonatomic) IBOutlet UIView *monthlyRecurrureView;
@property (weak, nonatomic) IBOutlet UILabel *monthlyRecurreLabel;
@property (weak, nonatomic) IBOutlet UIView *registrationConfirmationView;
@property (weak, nonatomic) IBOutlet UILabel *YourIncomeHeaderLabel;
@property (weak, nonatomic) IBOutlet UIView *incomeListView;
@property (weak, nonatomic) IBOutlet UILabel *servixeHelpText;
@property (weak, nonatomic) IBOutlet UIView *accountHelpView;
@property (weak, nonatomic) IBOutlet UIButton *AccountHeaderButton;
@property (weak, nonatomic) IBOutlet UIView *welocomePopUpView;

@end

@implementation DashBoardScreen
bool isBackFromRegistration;
bool isGotoServiceScreen;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateWorldHadBeenCountry:) name:NOTIFICATION_UPDATE_DASHBOARD_VIEW object:nil];
//    [self initialDetails];
//    [self assignKeyBoard];
//     self.navigationController.navigationBarHidden=YES;
//    _registrationConfirmationView.hidden=YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self checkValidityOfUser];
    [self initialDetails];
    [self assignKeyBoard];
    self.navigationController.navigationBarHidden=YES;
    _registrationConfirmationView.hidden=YES;
    
}

-(void)updateWorldHadBeenCountry:(NSNotification *)notification{
    isGotoServiceScreen=YES;
    isBackFromRegistration=YES;
    [self initialDetails];

}


-(void)initialDetails{
     _registrationConfirmationView.hidden=YES;
    _incomeView.layer.cornerRadius=8;
    _incomeView.layer.masksToBounds=YES;
    _monthlyRecurrureView.layer.cornerRadius=8;
    _monthlyRecurrureView.layer.masksToBounds=YES;
//    if(isBackFromRegistration){
//        _AccountHeaderButton.hidden=YES;
//        _YourIncomeHeaderLabel.text=@"Your registration is confirmed...";
//        _incomeListView.hidden=YES;
//        _accountHelpView.hidden=NO;
//        _servixeHelpText.hidden=NO;
 //   }else{
        _AccountHeaderButton.hidden=NO;
        _YourIncomeHeaderLabel.text=@"Your Income";
        _incomeListView.hidden=NO;
        _accountHelpView.hidden=YES;
        _servixeHelpText.hidden=YES;

 //   }
    if(isBackFromRegistration){
        _welocomePopUpView.hidden=NO;
    }else{
        _welocomePopUpView.hidden=YES;
    }
    
    if([Utils isUserAlreadyloggedIn]){
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if([otherDetails objectForKey:NR_INCOME_TOTAL]){
            _incomeLabel.text=[NSString stringWithFormat:@"%@ $",[otherDetails objectForKey:NR_INCOME_TOTAL]];
        }else{
            _incomeLabel.text=@"0.00$";
        }if([otherDetails objectForKey:MR_INCOME_TOTAL]){
            _monthlyRecurreLabel.text=[NSString stringWithFormat:@"%@ $",[otherDetails objectForKey:MR_INCOME_TOTAL]];
        }else{
            _monthlyRecurreLabel.text=@"0.00$";
        }
    }else{
        _incomeLabel.text=@"0.00$";
        _monthlyRecurreLabel.text=@"0.00$";
    }
}

- (void)assignKeyBoard{
    self.keyboardControls = [[BSKeyboardControls alloc] init];
    self.keyboardControls.delegate = self;
    self.keyboardControls.textFields = [NSArray arrayWithObjects:_agentIdTextField, nil];
    [self.keyboardControls reloadTextFields];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    isBackFromRegistration=NO;
}

-(void)sendDataToA
{
    isBackFromRegistration=YES;
    [self initialDetails];
    
}

- (IBAction)onCancle:(id)sender {
    _registrationConfirmationView.hidden=YES;
}
- (IBAction)onContinue:(id)sender {
     _registrationConfirmationView.hidden=YES;
    RegistrationScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationScreen"];
    controller.delegate=self;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)onService:(id)sender {
}

- (IBAction)onAccount:(id)sender {
    if([Utils isUserAlreadyloggedIn]){
       // [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"AccountScreen"] animated:YES];
        [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ActivityReportScreen"] animated:YES];
    }else{
        _registrationConfirmationView.hidden=NO;
    }
}

- (IBAction)onInternet:(id)sender {
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    [otherDetails setObject:@"1" forKey:CLICKE_SERVICE];
    [fileManager writeOtherSettingsData:otherDetails];
    
    ServiceMainScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ServiceMainScreen"];
    controller.isFromInternet=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)onPhoneservice:(id)sender {
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    [otherDetails setObject:@"2" forKey:CLICKE_SERVICE];
    [fileManager writeOtherSettingsData:otherDetails];
    ServiceMainScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ServiceMainScreen"];
    controller.isFromPhoneService=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)onCabeling:(id)sender {
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    [otherDetails setObject:@"3" forKey:CLICKE_SERVICE];
    [fileManager writeOtherSettingsData:otherDetails];
    ServiceMainScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ServiceMainScreen"];
    controller.isFromCabling=YES;
    [self.navigationController pushViewController:controller animated:YES];
}
- (IBAction)onOk:(id)sender {
    [self hideKeyboard];
    _agentPopUpView.hidden=YES;
    
    [self loginAgent];
}
- (IBAction)onContinueFromPopUp:(id)sender {
  //  _welocomePopUpView.hidden=YES;
    [self.navigationController popViewControllerAnimated:YES];
    if(isGotoServiceScreen){
        ServiceMainScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ServiceMainScreen"];
         [self.navigationController pushViewController:controller animated:YES];
    }else{
        ActivityReportScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ActivityReportScreen"];
        controller.isFromLogin=YES;
        [self.navigationController pushViewController:controller animated:YES];

    }
}

-(void)loginAgent{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
        [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_LOGIN_AGENT];
        
        NSMutableDictionary *parametersDictionary=[[NSMutableDictionary alloc]init];
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if(otherDetails==nil){
            otherDetails=[[NSMutableDictionary alloc]init];
        }
        [parametersDictionary setObject:_agentIdTextField.text forKey:AGENT_UNIQUE_ID];
        
        requestManager.commandName=REQUEST_LOGIN_AGENT;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_LOGIN_AGENT];
        
    }else{
        [Utils hideIndicator];
        [Utils showNoInternetConnectionAlertDialog];
    }
}

-(void)checkValidityOfUser{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
        [Utils showIndicatorwithDelegate:nil];
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


#pragma mark -
#pragma mark BSKeyboardControls Delegate
#pragma mark -

- (void)keyboardControlsPreviousNextPressed:(BSKeyboardControls *)controls withDirection:(KeyboardControlsDirection)direction andActiveTextField:(id)textField
{
    [textField becomeFirstResponder];
    //[self scrollViewToTextField:textField];
    [self arrangeKeyboardForMainScreenTextFields:textField];
    //[self arrangeKeyboardForAdditionalScreenTextFields:textField];
}

#pragma mark -
#pragma mark Text Field Delegate
#pragma mark -

-(void)textFieldDidChange :(UITextField *)theTextField{
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([self.keyboardControls.textFields containsObject:textField])
        self.keyboardControls.activeTextField = textField;
    [self arrangeKeyboardForMainScreenTextFields:textField];
}

- (void)arrangeKeyboardForMainScreenTextFields:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    
    [UIView commitAnimations];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

#pragma mark -
#pragma mark BSKeyboardControls Delegate
#pragma mark -
/*
 * The "Done" button was pressed
 * We want to close the keyboard
 */
- (void)keyboardControlsDonePressed:(BSKeyboardControls *)controls
{
    [self hideKeyboard];
    
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self hideKeyboard];
    return YES;
}

- (void)hideKeyboard{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [_keyboardControls.activeTextField resignFirstResponder];
    
}

- (void) onResult:(NSDictionary *)result{
    NSLog(@"Result %@",result);
    [Utils hideIndicator];
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_LOGIN_AGENT]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            NSMutableDictionary *loginDetails=[[NSMutableDictionary alloc]init];
            loginDetails =[result objectForKey:DATA];
            FileManager *fileManager=[[FileManager alloc]init];
            NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
            [otherDetails setObject:[loginDetails objectForKey:AGENT_UNIQUE_ID] forKey:AGENT_UNIQUE_ID];
            [otherDetails setObject:[loginDetails objectForKey:AGENT_ID] forKey:AGENT_ID];
            [fileManager writeOtherSettingsData:otherDetails];
            
        }
        else{
            NSString *message=[result objectForKey:MESSAGE];
            if(message==nil || [message isEqualToString:@""]){
                message=ALERT_MESSAGE_SOMETHING_WENT_WRONG;
            }
            [Utils showAlertMessage:message];
        }
    }else if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_IS_USER_VALID]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
           
        }
        else{
            //  int error_code = [[result objectForKey:CODE] intValue];
            // if(error_code == 99){
            //       _registrationPopView.hidden=NO;
            FileManager *fileManager=[[FileManager alloc]init];
            NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
            [otherDetails removeAllObjects];
            [fileManager writeOtherSettingsData:otherDetails];
            [[NSNotificationCenter defaultCenter]postNotificationName:REFRESH_PROFILE_SCREEN object:self];
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_SHOW_REGISTRATION_VIEW object:self];
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
