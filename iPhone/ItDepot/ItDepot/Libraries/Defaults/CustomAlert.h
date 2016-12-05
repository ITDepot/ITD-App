//
//  CustomAlert.h
//  InGollow
//
//  Created by c58 on 11/12/13.
//  Copyright (c) 2013 c58. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppName @"Plaza Fontabella"

#define CheckInternetConnection @"Please check your Internet connection."
#define RegistrationMandatoryField @"Please fill out all mandatory fields."
#define RegistrationMandatoryEmail @"Please complete Email."
#define RegistrationMandatoryRetypeEmail @"Please confirm your Retype Email."
#define RegistrationMandatoryPassword @"Please complete Password."
#define RegistrationMandatoryRetypePassword @"Please complete Reptype Password."
#define RegistrationVerifyEmailMatch @"Your email and retype email field do not match."
#define RegistrationValidateEmail @"Please check your Email Address."
#define RegistrationValidatePassword @"Sorry, your password and password confirmation do not match."
#define RegistrationPasswordLength @"Sorry, your password must be 8 characters long."
#define ALERT_MESSAGE_SOMETHING_WENT_WRONG                  @"Oops! Something went wrong. Kindly try again later"
#define RegistrationemailExist @"Sorry, this email address is already Registered."
#define SuccessfullyRegistration @"You are successfully registered."
#define SuccessfullyLogin @"You are successfully logged in."
#define LoginMandatoryField @"Please check your username and password."
#define ALERT_MESSAGE_ENTER_BID_COINS @"Please enter bid coins."
#define ALERT_MESSAGE_CANT_DELETE_DEFAULT_IMAGE @"Sorry. You can't delete default image."

#define ALERT_MESSAGE_UPLOAD_IMAGE @"Please upload image first!"
#define ALERT_MESSAGE_IN_APP_FAILED @"In App failed! Please try again later."
#define ALERT_MESSAGE_ENTER_LINK @"Please enter link."
#define ALERT_MESSAGE_INVALID_LINK @"Please enter a valid link."


#define ALERT_MESSAGE_SOMETHING_WENT_WRONG                  @"Oops! Something went wrong. Kindly try again later"

#define ImageUploaded @"Your image has been successfully uploaded! It is under review and will be available for use shortly."


@interface CustomAlert : NSObject
+(void)showAlert:(NSString *)title message:(NSString *)msg canBtntitle:(NSString *)CancelbtnTitle otherBtnTitle:(NSString *)otherBtnTitle;
@end
