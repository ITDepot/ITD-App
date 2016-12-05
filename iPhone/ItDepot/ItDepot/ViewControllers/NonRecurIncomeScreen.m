//
//  NonRecurIncomeScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "NonRecurIncomeScreen.h"
#import "Utils.h"
#import "RequestManager.h"
#import "FileManager.h"

@interface NonRecurIncomeScreen ()<RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *nonRecurTableView;

@end

@implementation NonRecurIncomeScreen
NSMutableArray *recurringIncomeArray;
NSMutableDictionary *recurringIncomeDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkValidityOfUser];
    recurringIncomeArray=[[NSMutableArray alloc]init];
    recurringIncomeDictionary=[[NSMutableDictionary alloc]init];
    _nonRecurTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [recurringIncomeArray count];
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"NonRecurCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *clientLabel=(UILabel *)[cell viewWithTag:100];
    UILabel *serviceLabel=(UILabel *)[cell viewWithTag:101];
    UILabel *nrIncomeLabel=(UILabel *)[cell viewWithTag:102];
    UILabel *datePaidLabel=(UILabel *)[cell viewWithTag:103];
    UIView *totalMainView=(UIView *)[cell viewWithTag:105];
    UIView *totalView=(UIView *)[cell viewWithTag:106];
    UILabel *nrTotalLabel=(UILabel *)[cell viewWithTag:107];
    totalView.layer.borderColor=[[Utils getUIColorFromHexColor:@"d8d8d8" withAlphaValue:1]CGColor];
    totalView.layer.borderWidth=1.0f;

    int arrayCount=(int)[recurringIncomeArray count];
    
    if(indexPath.row==arrayCount-1){
        totalMainView.hidden=NO;
        recurringIncomeDictionary=[recurringIncomeArray objectAtIndex:indexPath.row];
        NSString *nrTotal=[recurringIncomeDictionary objectForKey:NR_INCOME_TOTAL];
        if((nrTotal == nil) || [nrTotal isKindOfClass:[NSNull class]]){
            nrTotal=@"";
        }
        
        nrTotalLabel.text=nrTotal;
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherdetails=[fileManager getOtherSettingsData];
        [otherdetails setObject:nrTotal forKey:NR_INCOME_TOTAL];
        [fileManager writeOtherSettingsData:otherdetails];
        
    }else{
        totalMainView.hidden=YES;
        recurringIncomeDictionary=[recurringIncomeArray objectAtIndex:indexPath.row];
        NSString *client=[recurringIncomeDictionary objectForKey:CLIENT_NAME];
        NSString *service=[recurringIncomeDictionary objectForKey:SERVICE];
        NSString *nrIncome=[recurringIncomeDictionary objectForKey:NR_INCOME];
        NSString *datePaid=[recurringIncomeDictionary objectForKey:DATE_PAID];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:DATE_FORMAT_SERVER_ONLY_DAY];
        NSDate *yourDate = [dateFormat dateFromString:datePaid];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        [dateFormat stringFromDate:yourDate];
        NSString *dateString=[dateFormat stringFromDate:yourDate];

        clientLabel.text=client;
        serviceLabel.text=service;
        nrIncomeLabel.text=nrIncome;
        datePaidLabel.text=dateString;
        
    }

    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}

-(void)getNonrecurringIncome{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
  //      [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_GET_NON_RECURRING_INCOM];
        
        NSMutableDictionary *parametersDictionary=[[NSMutableDictionary alloc]init];
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if(otherDetails==nil){
            otherDetails=[[NSMutableDictionary alloc]init];
        }
        [parametersDictionary setObject:[otherDetails objectForKey:USER_IDD] forKey:USER_IDD];
        
        requestManager.commandName=REQUEST_GET_NON_RECURRING_INCOM;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_GET_NON_RECURRING_INCOM];
        
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
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_GET_NON_RECURRING_INCOM]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            recurringIncomeArray = [result objectForKey:DATA];
            [_nonRecurTableView reloadData];
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
             [self getNonrecurringIncome];
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
