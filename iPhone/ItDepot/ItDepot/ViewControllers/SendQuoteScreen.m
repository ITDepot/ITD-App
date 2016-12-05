//
//  SendQuoteScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "SendQuoteScreen.h"
#import "BSKeyboardControls.h"
#import "Utils.h"
#import "FileManager.h"
#import "RequestManager.h"


@interface SendQuoteScreen ()<BSKeyboardControlsDelegate,RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *businessNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *streetAddressTextField;
@property (weak, nonatomic) IBOutlet UITextField *zipTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UITextField *stateTextField;
@property (nonatomic, strong) BSKeyboardControls *keyboardControls;
@property (weak, nonatomic) IBOutlet UIScrollView *sendQuoteScrolllView;

@end

@implementation SendQuoteScreen
int scrollViewHeight;
@synthesize serviceName;

- (void)viewDidLoad {
    [super viewDidLoad];
    scrollViewHeight=469;
    [self initialDetails];
    [self assignKeyBoard];
}

-(void)initialDetails{
    _businessNameTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _businessNameTextField.layer.borderWidth=1.0;
    _businessNameTextField.layer.cornerRadius=5;
    _businessNameTextField.layer.masksToBounds=YES;
    
    _streetAddressTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _streetAddressTextField.layer.borderWidth=1.0;
    _streetAddressTextField.layer.cornerRadius=6;
    _streetAddressTextField.layer.masksToBounds=YES;
    
    _zipTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _zipTextField.layer.borderWidth=1.0;
    _zipTextField.layer.cornerRadius=6;
    _zipTextField.layer.masksToBounds=YES;
    
    _cityTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _cityTextField.layer.borderWidth=1.0;
    _cityTextField.layer.cornerRadius=6;
    _cityTextField.layer.masksToBounds=YES;
    
    _messageTextView.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _messageTextView.layer.borderWidth=1.0;
    _messageTextView.layer.cornerRadius=6;
    _messageTextView.layer.masksToBounds=YES;
    
    _stateTextField.layer.borderColor=[[Utils getUIColorFromHexColor:@"bebebe" withAlphaValue:1]CGColor];
    _stateTextField.layer.borderWidth=1.0;
    _stateTextField.layer.cornerRadius=6;
    _stateTextField.layer.masksToBounds=YES;
}

- (void)assignKeyBoard{
    self.keyboardControls = [[BSKeyboardControls alloc] init];
    self.keyboardControls.delegate = self;
    self.keyboardControls.textFields = [NSArray arrayWithObjects:_businessNameTextField ,_streetAddressTextField,_cityTextField,_stateTextField,_zipTextField,_messageTextView, nil];
    [self.keyboardControls reloadTextFields];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onSendQuote:(id)sender {
    if([_businessNameTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter Business Name"];
        return;
    }
    if([_streetAddressTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter Street Address"];
        return;
    }
    if([_cityTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter City"];
        return;
    }
    if([_stateTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter State"];
        return;
    }
    if([_zipTextField.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter Zip"];
        return;
    }
    if([_messageTextView.text isEqualToString:@""]){
        [Utils showToastMessage:@"Please enter Message"];
        return;
    }
    
    [self hideKeyboard];
    [self sendQuotes];

    
}

-(void)sendQuotes{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
        [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_SEND_QUOTES];
        
        NSMutableDictionary *parametersDictionary=[[NSMutableDictionary alloc]init];
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if(otherDetails==nil){
            otherDetails=[[NSMutableDictionary alloc]init];
        }
        [parametersDictionary setObject:[otherDetails objectForKey:AGENT_ID] forKey:AGENT_ID];
        [parametersDictionary setObject:[otherDetails objectForKey:AGENT_UNIQUE_ID] forKey:AGENT_UNIQUE_ID];
        [parametersDictionary setObject:serviceName forKey:SERVICE];
        [parametersDictionary setObject:_businessNameTextField.text forKey:BUSINESS_NAME];
        [parametersDictionary setObject:_streetAddressTextField.text forKey:STREET_ADDRESS];
        [parametersDictionary setObject:_cityTextField.text forKey:CITY_NAME];
        [parametersDictionary setObject:_stateTextField.text forKey:STATE_NAME];
        [parametersDictionary setObject:_zipTextField.text forKey:ZIP];
        [parametersDictionary setObject:_messageTextView.text forKey:CALL_MESSAGE];
        
        requestManager.commandName=REQUEST_SEND_QUOTES;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_SEND_QUOTES];
        
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
    [_sendQuoteScrolllView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight+250)];
    if ([self.keyboardControls.textFields containsObject:textField])
        self.keyboardControls.activeTextField = textField;
    [self arrangeKeyboardForMainScreenTextFields:textField];
}

-(void)textViewDidBeginEditing:(UITextView *)textView {
    [_sendQuoteScrolllView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight+250)];
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
    [_sendQuoteScrolllView setContentOffset:CGPointMake(0, textField.superview.frame.origin.y+textField.frame.origin.y-30) animated:YES];
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
            [_messageTextView resignFirstResponder];
        }
        return NO;
    }
    else if (location != NSNotFound){
        [_messageTextView resignFirstResponder];
        return NO;
    }
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
    [_sendQuoteScrolllView setContentSize:CGSizeMake(self.view.frame.size.width, scrollViewHeight)];
    [_keyboardControls.activeTextField resignFirstResponder];
    [UIView commitAnimations];
}

- (void) onResult:(NSDictionary *)result{
    NSLog(@"Result %@",result);
    [Utils hideIndicator];
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_SEND_QUOTES]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            
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
