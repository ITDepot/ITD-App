//
//  MonthlyIncomeScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "MonthlyIncomeScreen.h"
#import "FileManager.h"
#import "RequestManager.h"
#import "Utils.h"

@interface MonthlyIncomeScreen ()<RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *monthlyIncometableView;

@end

@implementation MonthlyIncomeScreen
NSMutableArray *monthlyIncomeArray;
NSMutableDictionary *monthlyIncomeDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkValidityOfUser];
    monthlyIncomeArray=[[NSMutableArray alloc]init];
    monthlyIncomeDictionary=[[NSMutableDictionary alloc]init];
    _monthlyIncometableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [monthlyIncomeArray count];
   
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"MonthlyIncomeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *clientLabel=(UILabel *)[cell viewWithTag:100];
    UILabel *serviceLabel=(UILabel *)[cell viewWithTag:101];
    UILabel *mrIncomeLabel=(UILabel *)[cell viewWithTag:102];
     UILabel *datestartedLabel=(UILabel *)[cell viewWithTag:103];
    
    UIView *totalMainView=(UIView *)[cell viewWithTag:105];
    UIView *totalView=(UIView *)[cell viewWithTag:106];
    UILabel *mrTotalLabel=(UILabel *)[cell viewWithTag:107];
    totalView.layer.borderColor=[[Utils getUIColorFromHexColor:@"d8d8d8" withAlphaValue:1]CGColor];
    totalView.layer.borderWidth=1.0f;
    
    int arrayCount=(int)[monthlyIncomeArray count];
    
    if(indexPath.row==arrayCount-1){
        totalMainView.hidden=NO;
        monthlyIncomeDictionary=[monthlyIncomeArray objectAtIndex:indexPath.row];
        NSString *mrTotal=[monthlyIncomeDictionary objectForKey:MR_INCOME_TOTAL];
        if((mrTotal == nil) || [mrTotal isKindOfClass:[NSNull class]]){
            mrTotal=@"";
        }
        mrTotalLabel.text=mrTotal;
        
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherdetails=[fileManager getOtherSettingsData];
        [otherdetails setObject:mrTotal forKey:MR_INCOME_TOTAL];
        [fileManager writeOtherSettingsData:otherdetails];
        
    }else{
        totalMainView.hidden=YES;
        monthlyIncomeDictionary=[monthlyIncomeArray objectAtIndex:indexPath.row];
        NSString *client=[monthlyIncomeDictionary objectForKey:CLIENT_NAME];
        NSString *service=[monthlyIncomeDictionary objectForKey:SERVICE];
        NSString *mrIncome=[monthlyIncomeDictionary objectForKey:MR_INCOME];
        NSString *dateStarted=[monthlyIncomeDictionary objectForKey:DATE_STARTED];
        
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:DATE_FORMAT_SERVER_ONLY_DAY];
        NSDate *yourDate = [dateFormat dateFromString:dateStarted];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        [dateFormat stringFromDate:yourDate];
        NSString *dateString=[dateFormat stringFromDate:yourDate];


        clientLabel.text=client;
        serviceLabel.text=service;
        mrIncomeLabel.text=mrIncome;
        datestartedLabel.text=dateString;
        
    }

    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}

-(void)getMonthlyIncome{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
    //    [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_GET_MONTHLY_RECURRING_INCOME];
        
        NSMutableDictionary *parametersDictionary=[[NSMutableDictionary alloc]init];
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if(otherDetails==nil){
            otherDetails=[[NSMutableDictionary alloc]init];
        }
         [parametersDictionary setObject:[otherDetails objectForKey:USER_IDD] forKey:USER_IDD];
        
        
        requestManager.commandName=REQUEST_GET_MONTHLY_RECURRING_INCOME;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_GET_MONTHLY_RECURRING_INCOME];
        
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


- (void) onResult:(NSDictionary *)result{
    NSLog(@"Result %@",result);
    [Utils hideIndicator];
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_GET_MONTHLY_RECURRING_INCOME]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            monthlyIncomeArray = [result objectForKey:DATA];
            [_monthlyIncometableView reloadData];
        }
        else{
            int error_code = [[result objectForKey:CODE] intValue];
            if(error_code == 99){
                 [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_SHOW_REGISTRATION_VIEW object:self];
            }else{
                NSString *message=[result objectForKey:MESSAGE];
                if(message==nil || [message isEqualToString:@""]){
                    message=ALERT_MESSAGE_SOMETHING_WENT_WRONG;
                }
             //   [Utils showAlertMessage:message];
            }
        }
    }else if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_IS_USER_VALID]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
             [self getMonthlyIncome];
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
