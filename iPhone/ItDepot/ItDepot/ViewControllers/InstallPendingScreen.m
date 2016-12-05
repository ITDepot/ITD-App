//
//  InstallPendingScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "InstallPendingScreen.h"
#import "RequestManager.h"
#import "FileManager.h"
#import "Utils.h"

@interface InstallPendingScreen ()<RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *installTableView;

@end

@implementation InstallPendingScreen
NSMutableArray *installPendingArray;
NSMutableDictionary *installPendingDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkValidityOfUser];
    installPendingArray=[[NSMutableArray alloc]init];
    installPendingDictionary=[[NSMutableDictionary alloc]init];
    _installTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   
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
    return [installPendingArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"InstallPendingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *clientLabel=(UILabel *)[cell viewWithTag:100];
    UILabel *serviceLabel=(UILabel *)[cell viewWithTag:101];
    UILabel *nrIncomLabel=(UILabel *)[cell viewWithTag:102];
    UILabel *mrIcomeLabel=(UILabel *)[cell viewWithTag:103];
    UILabel *estInstallLabel=(UILabel *)[cell viewWithTag:104];
    UILabel *lineLabel=(UILabel *)[cell viewWithTag:108];
    
    UIView *totalMainView=(UIView *)[cell viewWithTag:105];
    UIView *totalView=(UIView *)[cell viewWithTag:106];
    UILabel *nrTotalLabel=(UILabel *)[cell viewWithTag:109];
    UILabel *mrTotalLabel=(UILabel *)[cell viewWithTag:110];
    totalView.layer.borderColor=[[Utils getUIColorFromHexColor:@"d8d8d8" withAlphaValue:1]CGColor];
    totalView.layer.borderWidth=1.0f;

    
    int arrayCount=(int)[installPendingArray count];
    
    if(indexPath.row==arrayCount-1){
        totalMainView.hidden=NO;
        installPendingDictionary=[installPendingArray objectAtIndex:indexPath.row];
        NSString *nrTotal=[installPendingDictionary objectForKey:NR_INCOME_TOTAL];
        NSString *mrTotal=[installPendingDictionary objectForKey:MR_INCOME_TOTAL];
        nrTotalLabel.text=nrTotal;
        mrTotalLabel.text=mrTotal;
        
    }else{
        totalMainView.hidden=YES;
        installPendingDictionary=[installPendingArray objectAtIndex:indexPath.row];
        NSString *client=[installPendingDictionary objectForKey:CLIENT_NAME];
        NSString *service=[installPendingDictionary objectForKey:SERVICE];
        NSString *nrIncome=[installPendingDictionary objectForKey:NR_INCOME];
        NSString *mrIncome=[installPendingDictionary objectForKey:MR_INCOME];
        NSString *estInstall=[installPendingDictionary objectForKey:EST_INSTALL];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:DATE_FORMAT_SERVER_ONLY_DAY];
        NSDate *yourDate = [dateFormat dateFromString:estInstall];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
        [dateFormat stringFromDate:yourDate];
        NSString *dateString=[dateFormat stringFromDate:yourDate];
        
        clientLabel.text=client;
        serviceLabel.text=service;
        nrIncomLabel.text=nrIncome;
        mrIcomeLabel.text=mrIncome;
        estInstallLabel.text=dateString;

    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)getInstallPending{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
 //       [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_GET_INSTALL_PENDING];
        
        NSMutableDictionary *parametersDictionary=[[NSMutableDictionary alloc]init];
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if(otherDetails==nil){
            otherDetails=[[NSMutableDictionary alloc]init];
        }
       
       
        [parametersDictionary setObject:[otherDetails objectForKey:USER_IDD] forKey:USER_IDD];
        
        requestManager.commandName=REQUEST_GET_INSTALL_PENDING;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_GET_INSTALL_PENDING];
        
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
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_GET_INSTALL_PENDING]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            installPendingArray = [result objectForKey:DATA];
            [_installTableView reloadData];
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
                  //  [Utils showAlertMessage:message];
                }
        }
    }else if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_IS_USER_VALID]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
             [self getInstallPending];
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
