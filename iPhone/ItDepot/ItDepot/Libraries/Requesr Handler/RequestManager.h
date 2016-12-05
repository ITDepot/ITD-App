
#import <Foundation/Foundation.h>
#import "Constants.h"
#import "JSON.h"

#define GETMETHOD       @"GET"
#define PUTMETHOD       @"PUT"
#define POSTMETHOD      @"POST"
#define DELETEMETHOD    @"DELETE"
#define COMMAND         @"Command"
#define FLAG            @"flag"
#define DATA            @"data"
#define TAG_NUMBER      @"tagNumber"


//http://iroidsolutions.com/ozan/webservices/searchcars.php?searchtext=benchod
//
//http://iroidsolutions.com/ozan/webservices/getcarbyid.php?cids=15,16,17
//
//http://iroidsolutions.com/ozan/webservices/getcarsbyranking.php?columnname=sp0to100km&sortdirection=desc
//
//http://iroidsolutions.com/ozan/webservices/getallpartners.php

#define REQUEST_SEARCH_CARS                         @"searchcars.php"
#define REQUEST_GET_CAR_BY_ID                       @"getcarbyid.php"
#define REQUEST_GET_CARS_BY_RANKING                 @"getcarsbyranking.php"
#define REQUEST_GET_ALL_PARTNERS                    @"getallpartners.php"

#define DATA_TYPE_JSON              1
#define DATA_TYPE_XML               2

//#import "SBJSON.h"

@protocol RequestManagerDelegate;

@interface RequestManager : NSObject {
	NSMutableData *receivedData;
	id<RequestManagerDelegate> delegate;
	NSString *commandName;
    int dataType;
    NSString *tagNumber;
}

@property (nonatomic, retain) id<RequestManagerDelegate> delegate;
@property (nonatomic, retain) NSString *commandName;
@property (nonatomic, retain) NSString *tagNumber;
@property (nonatomic) int dataType;

-(void)CallPostURL:(NSString *)url parameters:(NSMutableDictionary *)params request:(NSString*)request;
-(void)CallPostURL:(NSString *)url parameters:(NSMutableDictionary *)params;
-(void)CallGetURL:(NSString *)url parameters:(NSMutableDictionary *)params;
-(void)CallPutURL:(NSString *)url parameters:(NSMutableDictionary *)params;
-(void)CallDeleteURL:(NSString *)url parameters:(NSMutableDictionary *)params;

-(NSString *)postString:(NSDictionary *)Params;
-(NSString *)getString:(NSMutableDictionary *)Params;

-(NSDictionary *)parseResults:(NSString *)result;
- (NSString *) urlEncode:(NSString *)str;

@end

@protocol RequestManagerDelegate
- (void)onResult:(NSDictionary *)result;
- (void)onFault:(NSError *)error;
@end