//
//  MyAnnotationClass.h
//  PolygonOverlaySample
//
//  Created by shawn on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotationClass : NSObject <MKAnnotation> {
    NSString *_title;
    NSString *_subtitle;
    NSString *_tagg;
    NSString *_phoneNumber;

    CLLocationCoordinate2D _coordinate;
    
    
}
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, retain) NSString *tagg;
@property (nonatomic, retain) NSString *phoneNumber;

//@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic) CLLocationCoordinate2D coordinate;

-(id) initWithCoordinate:(CLLocationCoordinate2D) coordinate;

@end
