//
//  QoutesScreen.m
//  ItDepot
//
//  Created by iroid on 8/20/16.
//  Copyright (c) 2016 iroid. All rights reserved.
//

#import "QoutesScreen.h"
#import "RequestManager.h"
#import "FileManager.h"
#import "Utils.h"
#import "AppDelegate.h"

@interface QoutesScreen ()<RequestManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *qotestableView;
@property (weak, nonatomic) IBOutlet UIView *registrationPopUpView;

@end

@implementation QoutesScreen
NSMutableArray *qoutesArray;
NSMutableDictionary *qoutesDictionary;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkValidityOfUser];
    qoutesArray=[[NSMutableArray alloc]init];
    qoutesDictionary=[[NSMutableDictionary alloc]init];
    _qotestableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    _registrationPopUpView.hidden=YES;
    
    
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
    return [qoutesArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"QotesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UILabel *rqstdLabel=(UILabel *)[cell viewWithTag:100];
    UILabel *clientLabel=(UILabel *)[cell viewWithTag:101];
    UILabel *serviceLabel=(UILabel *)[cell viewWithTag:102];
    
    qoutesDictionary = [qoutesArray objectAtIndex:indexPath.row];
    NSString *requested=[qoutesDictionary objectForKey:REQUESTED];
    NSString *clientName=[qoutesDictionary objectForKey:CLIENT_NAME];
    NSString *service=[qoutesDictionary objectForKey:SERVICE];
    
    rqstdLabel.text=requested;
    clientLabel.text=clientName;
    serviceLabel.text=service;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)getQoutes{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
//        [Utils showIndicatorwithDelegate:nil];
        RequestManager *requestManager = [[RequestManager alloc] init];
        requestManager.delegate=self;
        
        NSString *url = [NSString stringWithFormat:@"%@/%@",URL_PREFIX,REQUEST_GET_QOUTES];
        
        NSMutableDictionary *parametersDictionary=[[NSMutableDictionary alloc]init];
        FileManager *fileManager=[[FileManager alloc]init];
        NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
        if(otherDetails==nil){
            otherDetails=[[NSMutableDictionary alloc]init];
        }
          [parametersDictionary setObject:[otherDetails objectForKey:USER_IDD] forKey:USER_IDD];
        
        requestManager.commandName=REQUEST_GET_QOUTES;
        [requestManager CallPostURL:url parameters:parametersDictionary request:REQUEST_GET_QOUTES];
        
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
    
    if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_GET_QOUTES]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            qoutesArray = [result objectForKey:DATA];
            [_qotestableView reloadData];
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
                // [Utils showAlertMessage:message];
            }
        }
    }else if ([[result objectForKey:COMMAND] isEqualToString:REQUEST_IS_USER_VALID]){
        BOOL flag=[[result objectForKey:FLAG] boolValue];
        
        if(flag){
            [self getQoutes];
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
