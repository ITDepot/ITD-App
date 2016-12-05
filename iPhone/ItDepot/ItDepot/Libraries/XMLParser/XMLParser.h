//
//  XMLParser.h
//  Snorelax
//
//  Created by Daxesh on 04/05/14.
//  Copyright (c) 2014 iRoid Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLParser : NSObject<NSXMLParserDelegate>
{
    NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
    NSError *errorPointer;
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;

@end
