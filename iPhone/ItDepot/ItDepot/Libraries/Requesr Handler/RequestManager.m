
#import "RequestManager.h"

@implementation RequestManager

@synthesize delegate, commandName,tagNumber,dataType;

- (NSString *) urlEncode:(NSString *)str {
    NSString *string = str;
    return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

-(NSString *)getString:(NSMutableDictionary *)Params{
    if (Params!=nil){
        NSString *postStr=@"";
        
        for(int i=0;i<[Params count];i++){
            NSString *key = [[[Params allKeys] objectAtIndex:i] description];
            postStr = [postStr stringByAppendingString:key];
            postStr = [postStr stringByAppendingString:@"="];
            postStr = [postStr stringByAppendingString:[Params objectForKey:key]];
            if(i < [Params count]-1){
                postStr = [postStr stringByAppendingString:@"&"];
            }
        }
        
        NSString *str=[NSString stringWithFormat:@"?%@",postStr];
        //NSLog(@"str %@",str);

        return [self urlEncode:str];
    }else{
        //NSLog(@"----- Text ----");
        return @"";
    }
}

-(NSString *)postString:(NSDictionary *)Params{
    if (Params!=nil){
        NSString *postStr=@"";
        for(int i=0;i<[Params count];i++){
            NSString *key = [[[Params allKeys] objectAtIndex:i] description];
            postStr = [postStr stringByAppendingString:@"&"];
            postStr = [postStr stringByAppendingString:key];
            postStr = [postStr stringByAppendingString:@"="];
            postStr = [postStr stringByAppendingString:[Params objectForKey:key]];
        }
        return postStr;
    }else{
        return @"";
    }
}

-(void)CallGetURL:(NSString *)url parameters:(NSMutableDictionary *)params{
    //NSLog(@"dax");
    NSLog(@"dictionary %@",params);
	NSString *parStr =[self getString:params];
    NSLog(@"parstr %@",parStr);
	NSString *requestUrl = [NSString stringWithFormat:@"%@%@", url,parStr];
    NSLog(@"requestUrl %@",requestUrl);
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestUrl]];
	[theRequest setHTTPMethod:GETMETHOD];
	NSURLConnection *theconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
	[theRequest release];
	//NSLog(@"tttt");
	if (theconnection) {
		receivedData = [[NSMutableData data] retain];
	}else{
		NSLog(@"Failed loading data");
	}
}

-(void)CallDeleteURL:(NSString *)url parameters:(NSMutableDictionary *)params{
	NSString *parStr =[self getString:params];
	NSString *requestUrl = [NSString stringWithFormat:@"%@%@", url,parStr];
	NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:requestUrl]];
	[theRequest setHTTPMethod:DELETEMETHOD];
	NSURLConnection *theconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
	[theRequest release];
	
	if (theconnection) {
		receivedData = [[NSMutableData data] retain];
	}else{
		NSLog(@"Failed loading data");
	}
}

-(void)CallPutURL:(NSString *)url parameters:(NSMutableDictionary *)params{
	NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
	[theRequest setHTTPMethod:PUTMETHOD];
	NSString *parStr =[self postString:params];
    NSLog(@"url %@",url);
    NSLog(@"parStr %@",parStr);

	NSData *data = [parStr dataUsingEncoding:NSASCIIStringEncoding];
	[theRequest setHTTPBody:data];
	
	NSURLConnection *theconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
	[theRequest release];
    
	if (theconnection) {
		receivedData = [[NSMutableData data] retain];
	}else{
		NSLog(@"Failed loading data");
	}
}

//-(void)CallPostURL:(NSString *)url parameters:(NSMutableDictionary *)params{
//    
//    NSLog(@"URL :  %@",url);
//    NSLog(@"PARAMETER : %@",params);
//    
//    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//    [theRequest setHTTPMethod:POSTMETHOD];
//    
//    NSMutableDictionary *dataDictionary=[[NSMutableDictionary alloc]init];
//    [dataDictionary setObject:API_ID_VALUE forKey:API_ID];
//    [dataDictionary setObject:API_SECRET_VALUE forKey:API_SECRET];
//    [dataDictionary setObject:[params objectForKey:API_REQUEST] forKey:API_REQUEST];
//    [dataDictionary setObject:params forKey:DATA];
//    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataDictionary
//                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
//                                                         error:&error];
//    if (! jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//        //NSLog(@"jsonString: %@", jsonString);
//    }
//    
//    [theRequest setHTTPBody:jsonData];
//    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    [theRequest setValue:@"json" forHTTPHeaderField:@"Data-Type"];
//    
//    NSURLConnection *theconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
//    [theRequest release];
//    
//    if (theconnection) {
//        receivedData = [[NSMutableData data] retain];
//    }else{
//        NSLog(@"Failed loading data");
//    }
//}

-(void)CallPostURL:(NSString *)url parameters:(NSMutableDictionary *)params{
    NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [theRequest setHTTPMethod:POSTMETHOD];
    NSString *parStr =[self postString:params];
    //NSLog(@"parStr %@",parStr);
    
    NSData *data = [parStr dataUsingEncoding:NSASCIIStringEncoding];
    [theRequest setHTTPBody:data];
    
    NSURLConnection *theconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    [theRequest release];
    
    if (theconnection) {
        receivedData = [[NSMutableData data] retain];
    }else{
        NSLog(@"Failed loading data");
    }
}

-(void)CallPostURL:(NSString *)url parameters:(NSMutableDictionary *)params request:(NSString*)request{
    
    SBJsonWriter *jsonWriter = [[SBJsonWriter alloc] init];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *dataString = [jsonWriter stringWithObject:params];
    
    NSLog(@"URL :  %@ \n REQUEST : %@ \n PARAMETER : %@",url,request,dataString);
    
    NSData *temp = [dataString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    dataString = [[[NSString alloc] initWithData:temp encoding:NSASCIIStringEncoding] autorelease];
    
    NSString *RequestString = @"";
    
    RequestString = [NSString stringWithFormat:@"api_id=%@&api_secret=%@&api_request=%@&data=%@",API_ID_VALUE,API_SECRET_VALUE,request,dataString];
    
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    //NSString *unaccentedString = [RequestString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    NSData *myRequestData = [NSData dataWithBytes:[RequestString UTF8String] length:[RequestString length]];
    
    //  NSData* myRequestData = [RequestString dataUsingEncoding:NSUTF8StringEncoding];
    
    [theRequest setHTTPMethod: @"POST" ];
    [theRequest setHTTPBody: myRequestData];
    
    
    NSURLConnection *theconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    [theRequest release];
    if (theconnection) {
        receivedData = [[NSMutableData data] retain];
    }else{
        NSLog(@"Failed loading data");
    }
}

//-(void)CallPostURL:(NSString *)url parameters:(NSMutableDictionary *)params{
//	NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
//	[theRequest setHTTPMethod:POSTMETHOD];
//    
//    NSMutableDictionary *dataDictionary=[[NSMutableDictionary alloc]init];
//    [dataDictionary setObject:API_ID_VALUE forKey:API_ID];
//    [dataDictionary setObject:API_SECRET_VALUE forKey:API_SECRET];
//    [dataDictionary setObject:[params objectForKey:API_REQUEST] forKey:API_REQUEST];
//    [dataDictionary setObject:params forKey:DATA];
//
//	NSString *parStr =[self postString:params];
//    NSString *finalString=[NSString stringWithFormat:@"&%@=%@&%@=%@&%@=%@&%@=%@",API_ID,API_ID_VALUE,API_SECRET,API_SECRET_VALUE,API_REQUEST,[params objectForKey:API_REQUEST],DATA,parStr];
//    NSLog(@"url %@",url);
//    NSLog(@"parStr %@",parStr);
//    NSLog(@"finalString %@",finalString);
//
//	NSData *data = [finalString dataUsingEncoding:NSASCIIStringEncoding];
//	[theRequest setHTTPBody:data];
//	
//	NSURLConnection *theconnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
//	[theRequest release];
//    
//	if (theconnection) {
//		receivedData = [[NSMutableData data] retain];
//	}else{
//		NSLog(@"Failed loading data");
//	}
//}   

- (void)connection:(NSURLConnection *)theConnection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"received response");
	
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data{
    //NSLog(@"received data");
	
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error{
    NSLog(@"failed");
    @try {
        receivedData=nil;
        [receivedData release];
    }
    @catch (NSException *exception) {
        NSLog(@"try catch the receivedData exception %@",exception.description);
    }
    
    @try {
        theConnection=nil;
        [theConnection release];
    }
    @catch (NSException *exception) {
        NSLog(@"try catch the connection exception %@",exception.description);
    }
	[delegate onFault:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)theConnection{
 	NSString *parseResponse = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
    NSLog(@"response string request manager class %@",parseResponse);
	NSDictionary *result = [self parseResults:parseResponse];
    //NSLog(@"result %@",result);

	NSMutableDictionary *myResult = [NSMutableDictionary dictionaryWithDictionary:result];
    //NSLog(@"myResult %@",myResult);

	if(commandName)
		[myResult setObject:commandName forKey:COMMAND];
	if(tagNumber)
		[myResult setObject:tagNumber forKey:TAG_NUMBER];

    @try {
        receivedData=nil;
        [receivedData release];
    }
    @catch (NSException *exception) {
        NSLog(@"try catch the receivedData exception %@",exception.description);
    }
    [parseResponse release];
    @try {
        theConnection=nil;
        [theConnection release];
    }
    @catch (NSException *exception) {
        NSLog(@"try catch the connection exception %@",exception.description);
    }

	[delegate onResult:myResult];
}

-(NSDictionary *)parseResults:(NSString *)result{
    SBJSON *jsonParser = [SBJSON new];
    NSDictionary *data = (NSDictionary *) [jsonParser objectWithString:result error:NULL];
    [jsonParser release];
    return data;
    
//    if(dataType==DATA_TYPE_XML){
//        NSDictionary *dict=[XMLParser dictionaryForXMLString:result error:nil];
//        return dict;
//    }else{
//        SBJSON *jsonParser = [SBJSON new];
//        NSDictionary *data = (NSDictionary *) [jsonParser objectWithString:result error:NULL];
//        [jsonParser release];
//        return data;
//    }
    
    //return nil;
}

- (void) dealloc {
	if(commandName)
		[commandName release];
    if(tagNumber)
		[tagNumber release];

	receivedData = nil;
	[super dealloc];
}

@end
