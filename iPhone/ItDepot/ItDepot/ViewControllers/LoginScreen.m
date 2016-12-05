//
//  LoginScreen.m
//  ItDepot
//
//  Created by iroid on 9/17/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "LoginScreen.h"
#import "BSKeyboardControls.h"
#import "Utils.h"
#import "RequestManager.h"
#import "FileManager.h"
#import "ActivityReportScreen.h"

//@implementation UITextField (custom)
//- (CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectMake(bounds.origin.x + 15, bounds.origin.y,
//                      bounds.size.width, bounds.size.height);
//}
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    return [self textRectForBounds:bounds];
//}
//@end

@interface LoginScreen ()<BSKeyboardControlsDelegate,RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (weak, nonatomic) IBOutlet UIScrollView *loginScrollView;
@end

@implementation LoginScreen
int scrollViewHeight;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self assignKeyBoard];
    scrollViewHeight=518;
    [self initialDetails];
}

-(void)initialDetails{
    _emailTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _emailTextField.layer.borderWidth=1.0;
    _emailTextField.layer.cornerRadius=5;
    _emailTextField.layer.masksToBounds=YES;
    _phoneNumberTextField.layer.borderWidth=1.0;
    _phoneNumberTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _phoneNumberTextField.layer.cornerRadius=6;
    _phoneNumberTextField.layer.masksToBounds=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)assignKeyBoard{
    self.keyboardControls = [[BSKeyboardControls alloc] init];
    self.keyboardControls.delegate = self;
    self.keyboardControls.textFields = [NSArray arrayWithObjects:_emailTextField ,_phoneNumberTextField, nil];
    [self.keyboardControls reloadTextFields];
}


- (IBAction)onService:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)onLogin:(id)sender {
    if([_emailTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter email"];
        return;
    }
    
    if([_phoneNumberTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter Phone Number"];
        return;
    }
    
    
    [self hideKeyboard];
    [self doLogin];

}

-(void)doLogin{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
        [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_LOGIN];
        
        NSMutableDictionary *parametersDictionary=[[NSMutableDictionary alloc]init];
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if(otherDetails==nil){
            otherDetails=[[NSMutableDictionary alloc]init];
        }
        [parametersDictionary setObject:_emailTextField.text forKey:EMAIL_ID];
        [parametersDictionary setObject:_phoneNumberTextField.text forKey:PHONE];
             
        requestManager.commandName=REQUEST_LOGIN;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_LOGIN];
        
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
    [_loginScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight+250)];
    if ([self.keyboardControls.textFields containsObject:textField])
        self.keyboardControls.activeTextField = textField;
    [self arrangeKeyboardForMainScreenTextFields:textField];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [_loginScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight+250)];
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
    [_loginScrollView setContentOffset:CGPointMake(0, textField.superview.frame.origin.y+textField.frame.origin.y-30) animated:YES];
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


- (void)textViewDidChangeSelection:(UITextView *)textView{
    NSLog(@"textViewDidChangeSelection:");
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
    [_loginScrollView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight)];
    [_keyboardControls.activeTextField resignFirstResponder];
    [UIView commitAnimations];
}


- (void)saveUserDetails:(NSMutableDictionary *)userDictionary{
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    if(otherDetails==nil){
        otherDetails=[[NSMutableDictionary alloc]init];
    }
    [otherDetails setObject:[userDictionary objectForKey:USER_IDD] forKey:USER_IDD];
    [otherDetails setObject:[userDictionary objectForKey:FIRST_NAME] forKey:FIRST_NAME];
    [otherDetails setObject:[userDictionary objectForKey:LAST_NAME] forKey:LAST_NAME];
    [otherDetails setObject:[userDictionary objectForKey:EMAIL_ID] forKey:EMAIL_ID];
    [otherDetails setObject:[userDictionary objectForKey:PHONE] forKey:PHONE];
    [otherDetails setObject:[userDictionary objectForKey:COMPANY] forKey:COMPANY];
    [otherDetails setObject:[userDictionary objectForKey:STREET] forKey:STREET];
    [otherDetails setObject:[userDictionary objectForKey:SUITE] forKey:SUITE];
    [otherDetails setObject:[userDictionary objectForKey:CITY_NAME] forKey:CITY_NAME];
    [otherDetails setObject:[userDictionary objectForKey:STATE_NAME] forKey:STATE_NAME];
    [otherDetails setObject:[userDictionary objectForKey:ZIP] forKey:ZIP];
    
    [otherDetails setObject:@"1" forKey:IS_LOGGED_IN];
    
    
    NSLog(@"otherDetails %@",otherDetails);
    [fileManager writeOtherSettingsData:otherDetails];
}


- (void) onResult:(NSDictionary *)result{
    NSLog(@"Result %@",result);
    [Utils hideIndicator];
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_LOGIN]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            NSMutableDictionary *userDictionary=[result objectForKey:DATA];
            [self saveUserDetails:userDictionary];

            ActivityReportScreen *controller=[self.storyboard instantiateViewControllerWithIdentifier:@"ActivityReportScreen"];
            controller.isFromLogin=YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
        else{
            NSString *message=[result objectForKey:MESSAGE];
            if(message==nil || [message isEqualToString:@""]){
                message=ALERT_MESSAGE_SOMETHING_WENT_WRONG;
            }
            [Utils showAlertMessage:message];
        }
    }
}

- (void)onFault:(NSError *)error{
    NSLog(@"errorrr %@",error);
    [Utils hideIndicator];
    [Utils showAlertMessage:error.localizedDescription];
}

@end
