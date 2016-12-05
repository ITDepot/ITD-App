//
//  ContactClientScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "ContactClientScreen.h"
#import "Utils.h"
#import "BSKeyboardControls.h"
#import "RequestManager.h"
#import "FileManager.h"
#import "AppDelegate.h"

@interface ContactClientScreen ()<BSKeyboardControlsDelegate,RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *businessNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *contactEmailTextField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIScrollView *contactScrollView;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (weak, nonatomic) IBOutlet UIButton *internetSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneServiceSelectionButton;
@property (weak, nonatomic) IBOutlet UIButton *cablingSelectionButton;
@property (weak, nonatomic) IBOutlet UIView *registrationConfirmationView;

@end

@implementation ContactClientScreen
int scrollViewHeight;
@synthesize serviceName,isFromPhoneService,isFromCablling,isFromInternet;
int isInternet,isPhone,isCable;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollViewHeight=620;
    _registrationConfirmationView.hidden=YES;
    [self initialDetails];
    [self assignKeyBoard];
    [self updateButtonStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initialDetails{
    _businessNameTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _businessNameTextField.layer.borderWidth=1.0;
    _businessNameTextField.layer.cornerRadius=5;
    _businessNameTextField.layer.masksToBounds=YES;
    
    _contactEmailTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _contactEmailTextField.layer.borderWidth=1.0;
    _contactEmailTextField.layer.cornerRadius=6;
    _contactEmailTextField.layer.masksToBounds=YES;
    
    _contactNameTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _contactNameTextField.layer.borderWidth=1.0;
    _contactNameTextField.layer.cornerRadius=6;
    _contactNameTextField.layer.masksToBounds=YES;
    
    _contactNumberTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _contactNumberTextField.layer.borderWidth=1.0;
    _contactNumberTextField.layer.cornerRadius=6;
    _contactNumberTextField.layer.masksToBounds=YES;
    
    _messageTextView.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _messageTextView.layer.borderWidth=1.0;
    _messageTextView.layer.cornerRadius=6;
    _messageTextView.layer.masksToBounds=YES;
    
}

- (void)assignKeyBoard{
    self.keyboardControls = [[BSKeyboardControls alloc] init];
    self.keyboardControls.delegate = self;
    self.keyboardControls.textFields = [NSArray arrayWithObjects:_businessNameTextField ,_contactNameTextField,_contactNumberTextField,_contactEmailTextField,_messageTextView, nil];
    [self.keyboardControls reloadTextFields];
}

-(void)updateButtonStyle{
    if(isFromInternet){
        isInternet=1;
        serviceName=SERVICE_INTERNET;
        [_internetSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
        [_phoneServiceSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_cablingSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
    }
    if(isFromPhoneService){
        serviceName=SERVICES_PHONE;
        isPhone=1;
        [_internetSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_phoneServiceSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
        [_cablingSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
    }
    if(isFromCablling){
        serviceName=SERVICE_CABLLING;
        isCable=1;
        [_internetSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_phoneServiceSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
        [_cablingSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)onCancle:(id)sender {
    _registrationConfirmationView.hidden=YES;
}
- (IBAction)onRegister:(id)sender {
    _registrationConfirmationView.hidden=YES;
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"RegistrationScreen"] animated:YES];
}
- (IBAction)onAppLogo:(id)sender {
     [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onService:(id)sender {
 //   [self.view removeFromSuperview];
//    [self.delegate dismissTheModal];
     [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"ActivityReportScreen"] animated:YES];
   // [self.navigationController popToRootViewControllerAnimated:YES];
    
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
- (IBAction)onPhoneService:(id)sender {
    serviceName=SERVICES_PHONE;
    if(isPhone==0){
        isPhone=1;
    }else{
        isPhone=0;
    }
    [self updatePhoneButton];

}
- (IBAction)onCablling:(id)sender {
    serviceName=SERVICE_CABLLING;
    if(isCable==0){
        isCable=1;
    }else{
        isCable=0;
    }
    [self updateCableButton];

}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
//                         
//                        [self.view removeFromSuperview];
//                         
//                     }];

}
- (IBAction)onContactClient:(id)sender {
    if([_businessNameTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter Business Name"];
        return;
    }
    if([_contactNameTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter Contact Name"];
        return;
    }
    if([_contactNumberTextField.text isEqualToString:@""] && [_contactEmailTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter Contact Number or Email"];
        return;
    }
    if([_messageTextView.text isEqualToString:@""] || ([_messageTextView.text isEqualToString:@"Message"])){
        [Utils showToastMessage:@"Please enter Message"];
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
    [self contactClient];

}

-(void)contactClient{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
        [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_CONTACT_CLIENT];
        
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
        [parametersDictionary setObject:_businessNameTextField.text forKey:BUSINESS_NAME];
        [parametersDictionary setObject:_contactNameTextField.text forKey:CONTACT_NAME];
        [parametersDictionary setObject:_contactNumberTextField.text forKey:CONTACT_PHONE];
        [parametersDictionary setObject:_contactEmailTextField.text forKey:CONTACT_EMAIL];
        [parametersDictionary setObject:_messageTextView.text forKey:CALL_MESSAGE];
        
        requestManager.commandName=REQUEST_CONTACT_CLIENT;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_CONTACT_CLIENT];
        
    }else{
        [Utils hideIndicator];
        [Utils showNoInternetConnectionAlertDialog];
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
        [_cablingSelectionButton setBackgroundImage:[UIImage imageNamed:@"selected_icon.png"] forState:UIControlStateNormal];
        
    }else{
        [_cablingSelectionButton setBackgroundImage:[UIImage imageNamed:@"unselected_icon.png"] forState:UIControlStateNormal];
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
    [_contactScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight+250)];
    if ([self.keyboardControls.textFields containsObject:textField])
        self.keyboardControls.activeTextField = textField;
    [self arrangeKeyboardForMainScreenTextFields:textField];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [_contactScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight+250)];
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
    [_contactScrollView setContentOffset:CGPointMake(0, textField.superview.frame.origin.y+textField.frame.origin.y-30) animated:YES];
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
           // [_messageTextView resignFirstResponder];
            [self hideKeyboard];
        }
        return NO;
    }
    else if (location != NSNotFound){
      //  [_messageTextView resignFirstResponder];
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
    [_contactScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight)];
    [_keyboardControls.activeTextField resignFirstResponder];
    [UIView commitAnimations];
}

- (void) onResult:(NSDictionary *)result{
    NSLog(@"Result %@",result);
    [Utils hideIndicator];
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_CONTACT_CLIENT]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            [Utils showAlertMessage:@"Client will be contacted"];
        }
        else{
            int error_code = [[result objectForKey:CODE] intValue];
            if(error_code == 99){
                _registrationConfirmationView.hidden=NO;
            }else{
                
                NSString *message=[result objectForKey:MESSAGE];
                if(message==nil || [message isEqualToString:@""]){
                    message=ALERT_MESSAGE_SOMETHING_WENT_WRONG;
                }
                [Utils showAlertMessage:message];
            }
        }
    }
}

- (void)onFault:(NSError *)error{
    NSLog(@"errorrr %@",error);
    [Utils hideIndicator];
    [Utils showAlertMessage:error.localizedDescription];
}


@end
