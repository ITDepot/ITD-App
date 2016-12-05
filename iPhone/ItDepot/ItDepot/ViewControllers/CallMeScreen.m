//
//  CallMeScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "CallMeScreen.h"
#import "Utils.h"
#import <QuartzCore/QuartzCore.h>
#import "BSKeyboardControls.h"
#import "FileManager.h"
#import "RequestManager.h"
#import "InternetScreen.h"
#import "ServiceMainScreen.h"
#import "AppDelegate.h"
#import "DashBoardScreen.h"

@interface CallMeScreen ()<BSKeyboardControlsDelegate,RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cellNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *otherNumberTextField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextField;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (weak, nonatomic) IBOutlet UIScrollView *callMeScrollView;
@property (weak, nonatomic) IBOutlet UIButton *internetSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneServiceSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *cableSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *cellNumberSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *otherNumberSelectionButton;
@property (weak, nonatomic) IBOutlet UIView *registrationPopUpView;

@end

@implementation CallMeScreen
int scrollViewHeight;
@synthesize serviceName;
@synthesize isFromCabling,isFromInternet,isFromPhoneService,delegate;
NSString *serviceName;
int cellNumber,isInternet,isPhone,isCable;
- (void)viewDidLoad {
    [super viewDidLoad];
    _registrationPopUpView.hidden=YES;
    _messageTextField.delegate=self;
    scrollViewHeight=572;
    cellNumber=1;
    isInternet=0;
    isPhone=0;
    isCable=0;
//    _otherNumberTextField.enabled=NO;
//    _cellNumberTextField.enabled=NO;
    [self checkValidityOfUser];
    [self initialDetails];
    [self assignKeyBoard];
    [self updateButtonStyle];
    [self updateCellNumberButton];
    
     
}

-(void)initialDetails{
    _messageTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _messageTextField.layer.borderWidth=1.0;
    _messageTextField.layer.cornerRadius=5;
    _messageTextField.layer.masksToBounds=YES;
    _cellNumberTextField.layer.borderWidth=1.0;
    _cellNumberTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _cellNumberTextField.layer.cornerRadius=6;
    _cellNumberTextField.layer.masksToBounds=YES;
    _otherNumberTextField.layer.borderWidth=1.0;
    _otherNumberTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _otherNumberTextField.layer.cornerRadius=6;
    _otherNumberTextField.layer.masksToBounds=YES;
}

-(void)updateButtonStyle{
    if(isFromInternet){
        isInternet=1;
        serviceName=SERVICE_INTERNET;
        [_internetSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
        [_phoneServiceSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_cableSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
    }
    if(isFromPhoneService){
        serviceName=SERVICES_PHONE;
        isPhone=1;
        [_internetSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_phoneServiceSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
        [_cableSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
    }
    if(isFromCabling){
        serviceName=SERVICE_CABLLING;
        isCable=1;
        [_internetSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_phoneServiceSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_cableSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
    }
    
}

-(void)updateCellNumberButton{
    if(cellNumber==1){
        [_cellNumberSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
        [_otherNumberSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
    }
    if(cellNumber==0){
        [_cellNumberSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_otherNumberSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
    }
}

-(void)updateInternetButton{
    if(isInternet==1){
        [_internetSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];

    }else{
         [_internetSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
    }
}

-(void)updatePhoneButton{
    if(isPhone==1){
        [_phoneServiceSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
        
    }else{
        [_phoneServiceSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
    }
}

-(void)updateCableButton{
    if(isCable==1){
        [_cableSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
        
    }else{
        [_cableSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
    }
}

- (void)assignKeyBoard{
    self.keyboardControls = [[BSKeyboardControls alloc] init];
    self.keyboardControls.delegate = self;
    self.keyboardControls.textFields = [NSArray arrayWithObjects:_cellNumberTextField ,_otherNumberTextField,_messageTextField, nil];
    [self.keyboardControls reloadTextFields];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onCancle:(id)sender {
    _registrationPopUpView.hidden=YES;
}
- (IBAction)onRegister:(id)sender {
    _registrationPopUpView.hidden=YES;
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationScreen"] animated:YES];
    
}
- (IBAction)onAppLogo:(id)sender {
       [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)onInternet:(id)sender {
    serviceName=SERVICE_INTERNET;
    if(isInternet==0){
        isInternet=1;
    }else{
        isInternet=0;
    }
    [self updateInternetButton];
}
- (IBAction)onPhoneservice:(id)sender {
    serviceName=SERVICES_PHONE;
    if(isPhone==0){
        isPhone=1;
    }else{
        isPhone=0;
    }
    [self updatePhoneButton];
}
- (IBAction)onService:(id)sender {
//    [self.view removeFromSuperview];
//      [self.delegate dismissTheModal];
     [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ActivityReportScreen"] animated:YES];
 //  [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)onCabling:(id)sender {
    serviceName=SERVICE_CABLLING;
    if(isCable==0){
        isCable=1;
    }else{
        isCable=0;
    }
    [self updateCableButton];
}
- (IBAction)onCellNumber:(id)sender {
    cellNumber=1;
    _otherNumberTextField.enabled=NO;
    _cellNumberTextField.enabled=YES;
    [self updateCellNumberButton];
}
- (IBAction)onOtherNumber:(id)sender {
    cellNumber=0;
    _cellNumberTextField.enabled=NO;
    _otherNumberTextField.enabled=YES;
    [self updateCellNumberButton];
}
- (IBAction)onBack:(id)sender {
//    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
//    
//    CGRect tempFrame2=appDelegate.window.frame;
//    self.view.frame = tempFrame2;
//    
//    [UIView animateWithDuration:0.3
//                          delay:0.1
//                        options: UIViewAnimationCurveEaseIn
//                     animations:^{
//                         CGRect tempFrame=self.view.frame;
//                         tempFrame.origin.y=tempFrame.size.height+125;
//                         self.view.frame = tempFrame;
//                        
//                     }
//                     completion:^(BOOL finished){
//                        [self.view removeFromSuperview];
//
//                     }];
//   

    
   [self.navigationController popViewControllerAnimated:YES];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
//    [self.delegate dismissTheModal];
//   // [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_UPDATE_SCREEN object:self];
    
//    [self dismissViewControllerAnimated:YES completion:^{
//        UIViewController *serviceMainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ServiceMainScreen"];
//        [refNavigationController pushViewController:serviceMainVC animated:YES];
//    }];
//    UINavigationController *navigationController = (UINavigationController *)[UIApplication.sharedApplication.keyWindow rootViewController];
//    [navigationController pushViewController:[[ServiceMainScreen alloc] init] animated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onCallMe:(id)sender {
    
    if([_messageTextField.text isEqualToString:@""] || ([_messageTextField.text isEqualToString:@"Message"])){
        [Utils showToastMessage:@"Please enter message"];
        return;
    }
    
    if([_cellNumberTextField.text isEqualToString:@""] && [_otherNumberTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter cell number or Email"];
        return;
    }
    if(isInternet==1 && isPhone==1){
        serviceName=[NSString stringWithFormat:@"%@,%@",SERVICE_INTERNET,SERVICES_PHONE];
    }
    if(isPhone==1 && isCable==1){
        serviceName=[NSString stringWithFormat:@"%@,%@",SERVICES_PHONE,SERVICE_CABLLING];
    }
    if(isInternet==1 && isCable==1){
        serviceName=[NSString stringWithFormat:@"%@,%@",SERVICE_INTERNET,SERVICE_CABLLING];
    }
    if(isInternet==1 && isPhone==1 && isCable==1){
        serviceName=[NSString stringWithFormat:@"%@,%@,%@",SERVICE_INTERNET,SERVICES_PHONE,SERVICE_CABLLING];
    }

    
    [self hideKeyboard];
    [self callMe];

}

-(void)callMe{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
        [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_CALL_ME];
        
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
        [parametersDictionary setObject:serviceName forKey:SERVICE];
        [parametersDictionary setObject:_cellNumberTextField.text forKey:CELL_NUMBER];
        [parametersDictionary setObject:_otherNumberTextField.text forKey:OTHER_NUMBER];
        [parametersDictionary setObject:_messageTextField.text forKey:CALL_MESSAGE];
        
        requestManager.commandName=REQUEST_CALL_ME;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_CALL_ME];
        
    }else{
        [Utils hideIndicator];
        [Utils showNoInternetConnectionAlertDialog];
    }


}

-(void)checkValidityOfUser{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
  //      [Utils showIndicatorwithDelegate:nil];
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
#pragma mark Text Field Delegate
#pragma mark -

- (void)keyboardControlsPreviousNextPressed:(BSKeyboardControls *)controls withDirection:(KeyboardControlsDirection)direction andActiveTextField:(id)textField
{
    [self arrangeKeyboardForMainScreenTextFields:textField];
}

#pragma mark -
#pragma mark Text Field Delegate
#pragma mark -


/* Editing began */
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_callMeScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight+250)];
    if ([self.keyboardControls.textFields containsObject:textField])
        self.keyboardControls.activeTextField = textField;
    [self arrangeKeyboardForMainScreenTextFields:textField];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [_callMeScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight+250)];
    if ([self.keyboardControls.textFields containsObject:textView])
        self.keyboardControls.activeTextField = textView;
    [self arrangeKeyboardForMainScreenTextFields:(UITextField *)textView];
    if ([textView.text isEqualToString:@"Message"]) {
        textView.text = @"";
        //        textView.textColor = [UIColor blackColor]; //optional
    }
    
}

- (void)arrangeKeyboardForMainScreenTextFields:(UITextField *)textField{
    [UIView beginAnimations:nil context:NULL];
    [_callMeScrollView setContentOffset:CGPointMake(0, textField.superview.frame.origin.y+textField.frame.origin.y-30) animated:YES];
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}

#pragma mark -
#pragma mark Text View Delegate
#pragma mark -
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing:");
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSCharacterSet *doneButtonCharacterSet = [NSCharacterSet newlineCharacterSet];
    NSRange replacementTextRange = [text rangeOfCharacterFromSet:doneButtonCharacterSet];
    NSUInteger location = replacementTextRange.location;
    
    if (textView.text.length + text.length > 140){
        if (location != NSNotFound){
           // [_messageTextField resignFirstResponder];
            [self hideKeyboard];
        }
        return NO;
    }
    else if (location != NSNotFound){
       // [_messageTextField resignFirstResponder];
        [self hideKeyboard];
        return NO;
    }
    return YES;
    
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    NSLog(@"textViewDidChangeSelection:");
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Message";
    }
    // [textView resignFirstResponder];
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

- (BOOL) textViewShouldReturn:(UITextView *)textView{
    [self hideKeyboard];
    return YES;
}


- (void)hideKeyboard{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    [_callMeScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight)];
    [_keyboardControls.activeTextField resignFirstResponder];
    [UIView commitAnimations];
}

- (void) onResult:(NSDictionary *)result{
    NSLog(@"Result %@",result);
    [Utils hideIndicator];
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_CALL_ME]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            [Utils showAlertMessage:@"Mail Send Successfully"];
        }
        else{
            int error_code = [[result objectForKey:CODE] intValue];
            if(error_code == 99){
                _registrationPopUpView.hidden=NO;
            }else{
                NSString *message=[result objectForKey:MESSAGE];
                if(message==nil || [message isEqualToString:@""]){
                    message=ALERT_MESSAGE_SOMETHING_WENT_WRONG;
                }
                [Utils showAlertMessage:message];
            }
        }
    }else if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_IS_USER_VALID]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            FileManager *fileManager=[[FileManager alloc]init];
            NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
            NSString *contactNo=[otherDetails objectForKey:PHONE];
            NSString *email=[otherDetails objectForKey:EMAIL_ID];
            _cellNumberTextField.text=contactNo;
            _otherNumberTextField.text=email;

        }
        else{
            int error_code = [[result objectForKey:CODE] intValue];
           // if(error_code == 99){
         //       _registrationPopUpView.hidden=NO;
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
          //  }
        }

    }
}

- (void)onFault:(NSError *)error{
    NSLog(@"errorrr %@",error);
    [Utils hideIndicator];
    [Utils showAlertMessage:error.localizedDescription];
}

@end
