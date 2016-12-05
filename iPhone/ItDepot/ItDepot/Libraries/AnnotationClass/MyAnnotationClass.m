//
//  MyAnnotationClass.m
//  PolygonOverlaySample
//
//  Created by shawn on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotationClass.h"


@implementation MyAnnotationClass

@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize coordinate = _coordinate;
@synthesize tagg = _tagg;
@synthesize phoneNumber = _phoneNumber;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coordinate{
    self=[super init];
    if(self){
        _coordinate=coordinate;
    }
    return self;
}



-(void) dealloc{
    self.title = nil;
    self.subtitle = nil;
    self.tagg = nil;
    self.phoneNumber = nil;

    [super dealloc];
}


@end
