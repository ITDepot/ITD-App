//
//  VRGCalendarView.m
//  Vurig
//
//  Created by in 't Veen Tjeerd on 5/8/12.
//  Copyright (c) 2012 Vurig Media. All rights reserved.
//

#import "VRGCalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "NSDate+convenience.h"
#import "NSMutableArray+convenience.h"
#import "UIView+convenience.h"
#import "Utils.h"

@implementation VRGCalendarView
{
    int cellheight,cellWidth,calTopHeight;
}
@synthesize currentMonth,delegate,labelCurrentMonth, animationView_A,animationView_B;
@synthesize markedDates,markedColors,calendarHeight,selectedDate;

#pragma mark - Select Date
-(void)selectDate:(int)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit fromDate:self.currentMonth];
    [comps setDay:date];
    self.selectedDate = [gregorian dateFromComponents:comps];
    
    int selectedDateYear = [selectedDate year];
    int selectedDateMonth = [selectedDate month];
    int currentMonthYear = [currentMonth year];
    int currentMonthMonth = [currentMonth month];
    
    if (selectedDateYear < currentMonthYear) {
        [self showPreviousMonth];
    } else if (selectedDateYear > currentMonthYear) {
        [self showNextMonth];
    } else if (selectedDateMonth < currentMonthMonth) {
        [self showPreviousMonth];
    } else if (selectedDateMonth > currentMonthMonth) {
        [self showNextMonth];
    } else {
        [self setNeedsDisplay];
    }
    
    if ([delegate respondsToSelector:@selector(calendarView:dateSelected:)]) [delegate calendarView:self dateSelected:self.selectedDate];
}

#pragma mark - Mark Dates
//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates {
    self.markedDates = dates;
    NSMutableArray *colors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[dates count]; i++) {
//        [colors addObject:[UIColor colorWithHexString:@"0x383838"]];
        [colors addObject:[UIColor colorWithHexString:@"0x383838"]];
    }
    
    self.markedColors = [NSArray arrayWithArray:colors];
//    [colors release];
    
    [self setNeedsDisplay];
}

//NSArray can either contain NSDate objects or NSNumber objects with an int of the day.
-(void)markDates:(NSArray *)dates withColors:(NSArray *)colors {
    self.markedDates = dates;
    self.markedColors = colors;
    [currentMonth year];
    [self setNeedsDisplay];
}

#pragma mark - Set date to now
-(void)reset {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components =
    [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit |
                           NSDayCalendarUnit) fromDate: [NSDate date]];
    self.currentMonth = [gregorian dateFromComponents:components]; //clean month
    
    [self updateSize];
    [self setNeedsDisplay];
    [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
}

#pragma mark - Next & Previous
-(void)showNextMonth {
    if (isAnimating) return;
    self.markedDates=nil;
    isAnimating=YES;
    prepAnimationNextMonth=YES;
    
    [self setNeedsDisplay];
    
    int lastBlock = [currentMonth firstWeekDayInMonth]+[currentMonth numDaysInMonth]-1;
    int numBlocks = [self numRows]*7;
    BOOL hasNextMonthDays = lastBlock<numBlocks;
    
    //Old month
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //New month
    self.currentMonth = [currentMonth offsetMonth:1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight: animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationNextMonth=NO;
    [self setNeedsDisplay];
    
    UIImage *imageNextMonth = [self drawCurrentState];
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    
    UIView *animationHolder;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, calTopHeight, kVRGCalendarViewWidthiPad, targetSize-calTopHeight)];
    }
    else
    {
        animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, calTopHeight, kVRGCalendarViewWidth, targetSize-calTopHeight)];
    }
    
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
//    [animationHolder release];
    
    //Animate
    self.animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    self.animationView_B = [[UIImageView alloc] initWithImage:imageNextMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasNextMonthDays) {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight - (cellheight+3);
    } else {
        animationView_B.frameY = animationView_A.frameY + animationView_A.frameHeight -3;
    }
    
    //Animation
    __block VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         //blockSafeSelf.frameHeight = 100;
                         if (hasNextMonthDays) {
                             animationView_A.frameY = -animationView_A.frameHeight + cellheight+3;
                         } else {
                             animationView_A.frameY = -animationView_A.frameHeight + 3;
                         }
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}

-(void)showPreviousMonth {
    if (isAnimating) return;
    isAnimating=YES;
    self.markedDates=nil;
    //Prepare current screen
    prepAnimationPreviousMonth = YES;
    [self setNeedsDisplay];
    BOOL hasPreviousDays = [currentMonth firstWeekDayInMonth]>1;
    float oldSize = self.calendarHeight;
    UIImage *imageCurrentMonth = [self drawCurrentState];
    
    //Prepare next screen
    self.currentMonth = [currentMonth offsetMonth:-1];
    if ([delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:YES];
    prepAnimationPreviousMonth=NO;
    [self setNeedsDisplay];
    UIImage *imagePreviousMonth = [self drawCurrentState];
    
    float targetSize = fmaxf(oldSize, self.calendarHeight);
    UIView *animationHolder;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, calTopHeight, kVRGCalendarViewWidthiPad, targetSize-calTopHeight)];
    }
    else
    {
        animationHolder = [[UIView alloc] initWithFrame:CGRectMake(0, calTopHeight, kVRGCalendarViewWidth, targetSize-calTopHeight)];
    }
    
    
    [animationHolder setClipsToBounds:YES];
    [self addSubview:animationHolder];
//    [animationHolder release];
    
    self.animationView_A = [[UIImageView alloc] initWithImage:imageCurrentMonth];
    self.animationView_B = [[UIImageView alloc] initWithImage:imagePreviousMonth];
    [animationHolder addSubview:animationView_A];
    [animationHolder addSubview:animationView_B];
    
    if (hasPreviousDays) {
        animationView_B.frameY = animationView_A.frameY - (animationView_B.frameHeight-cellheight) + 3;
    } else {
        animationView_B.frameY = animationView_A.frameY - animationView_B.frameHeight + 3;
    }
    
    __block VRGCalendarView *blockSafeSelf = self;
    [UIView animateWithDuration:.35
                     animations:^{
                         [self updateSize];
                         
                         if (hasPreviousDays) {
                             animationView_A.frameY = animationView_B.frameHeight-(cellheight+3); 
                             
                         } else {
                             animationView_A.frameY = animationView_B.frameHeight-3;
                         }
                         
                         animationView_B.frameY = 0;
                     }
                     completion:^(BOOL finished) {
                         [animationView_A removeFromSuperview];
                         [animationView_B removeFromSuperview];
                         blockSafeSelf.animationView_A=nil;
                         blockSafeSelf.animationView_B=nil;
                         isAnimating=NO;
                         [animationHolder removeFromSuperview];
                     }
     ];
}


#pragma mark - update size & row count
-(void)updateSize {
    self.frameHeight = self.calendarHeight;
    [self setNeedsDisplay];
}

-(float)calendarHeight {
    return calTopHeight + [self numRows]*(cellheight+2)+1;
}

-(int)numRows {
    float lastBlock = [self.currentMonth numDaysInMonth]+([self.currentMonth firstWeekDayInMonth]-1);
    return ceilf(lastBlock/7);
}

#pragma mark - Touches
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{       
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    
    self.selectedDate=nil;
    
    //Touch a specific day
    if (touchPoint.y > calTopHeight) {
        float xLocation = touchPoint.x;
        float yLocation = touchPoint.y-calTopHeight;
        
        int column = floorf(xLocation/(cellWidth+2));
        int row = floorf(yLocation/(cellheight+2));
        
        int blockNr = (column+1)+row*7;
        int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
        int date = blockNr-firstWeekDay;
        [self selectDate:date];
        return;
    }
    
    self.markedDates=nil;
    self.markedColors=nil;  
    
    CGRect rectArrowLeft = CGRectMake(0, 0, 50, 40);
    CGRect rectArrowRight = CGRectMake(self.frame.size.width-50, 0, 50, 40);
    
    //Touch either arrows or month in middle
    if (CGRectContainsPoint(rectArrowLeft, touchPoint)) {
        [self showPreviousMonth];
    } else if (CGRectContainsPoint(rectArrowRight, touchPoint)) {
        [self showNextMonth];
    } else if (CGRectContainsPoint(self.labelCurrentMonth.frame, touchPoint)) {
        //Detect touch in current month
        int currentMonthIndex = [self.currentMonth month];
        int todayMonth = [[NSDate date] month];
        [self reset];
        if ((todayMonth!=currentMonthIndex) && [delegate respondsToSelector:@selector(calendarView:switchedToMonth:targetHeight:animated:)]) [delegate calendarView:self switchedToMonth:[currentMonth month] targetHeight:self.calendarHeight animated:NO];
    }
}
-(void)setMonth:(NSString *)strMonth withYear:(NSString *)strYear
{
    NSString *strSpanishMonth;
    if([strMonth isEqualToString:@"January"] || [strMonth isEqualToString:@"enero"])
    {
        strSpanishMonth = @"Enero";
    }
    else if([strMonth isEqualToString:@"February"] || [strMonth isEqualToString:@"febrero"])
    {
        strSpanishMonth = @"Febrero";
    }
    else if([strMonth isEqualToString:@"March"] || [strMonth isEqualToString:@"marzo"])
    {
        strSpanishMonth = @"Marzo";
    }
    else if([strMonth isEqualToString:@"April"] || [strMonth isEqualToString:@"abril"])
    {
        strSpanishMonth = @"Abril";
    }
    else if([strMonth isEqualToString:@"May"] || [strMonth isEqualToString:@"mayo"])
    {
        strSpanishMonth = @"Mayo";
    }
    else if([strMonth isEqualToString:@"June"] || [strMonth isEqualToString:@"junio"])
    {
        strSpanishMonth = @"Junio";
    }
    else if([strMonth isEqualToString:@"July"] || [strMonth isEqualToString:@"julio"])
    {
        strSpanishMonth = @"Julio";
    }
    else if([strMonth isEqualToString:@"August"] || [strMonth isEqualToString:@"Agosto"])
    {
        strSpanishMonth = @"Agosto";
    }
    else if([strMonth isEqualToString:@"September"] || [strMonth isEqualToString:@"Septiembre"])
    {
        strSpanishMonth = @"Septiembre";
    }
    else if([strMonth isEqualToString:@"October"] || [strMonth isEqualToString:@"Octubre"])
    {
        strSpanishMonth = @"Octubre";
    }
    else if([strMonth isEqualToString:@"November"] || [strMonth isEqualToString:@"Noviembre"])
    {
        strSpanishMonth = @"Noviembre";
    }
    else {
        strSpanishMonth = @"Diciembre";
    }
    labelCurrentMonth.text = [NSString stringWithFormat:@"%@ %@",strSpanishMonth,strYear];
}
-(void)setEnglishMonth:(NSString *)strMonth withYear:(NSString *)strYear
{
    NSString *strSpanishMonth;
    if([strMonth isEqualToString:@"January"] || [strMonth isEqualToString:@"enero"])
    {
        strSpanishMonth = @"January";
    }
    else if([strMonth isEqualToString:@"February"] || [strMonth isEqualToString:@"febrero"])
    {
        strSpanishMonth = @"February";
    }
    else if([strMonth isEqualToString:@"March"] || [strMonth isEqualToString:@"marzo"])
    {
        strSpanishMonth = @"March";
    }
    else if([strMonth isEqualToString:@"April"] || [strMonth isEqualToString:@"abril"])
    {
        strSpanishMonth = @"April";
    }
    else if([strMonth isEqualToString:@"May"] || [strMonth isEqualToString:@"mayo"])
    {
        strSpanishMonth = @"May";
    }
    else if([strMonth isEqualToString:@"June"] || [strMonth isEqualToString:@"junio"])
    {
        strSpanishMonth = @"June";
    }
    else if([strMonth isEqualToString:@"July"] || [strMonth isEqualToString:@"julio"])
    {
        strSpanishMonth = @"July";
    }
    else if([strMonth isEqualToString:@"August"] || [strMonth isEqualToString:@"agosto"])
    {
        strSpanishMonth = @"August";
    }
    else if([strMonth isEqualToString:@"September"] || [strMonth isEqualToString:@"septiembre"])
    {
        strSpanishMonth = @"September";
    }
    else if([strMonth isEqualToString:@"October"] || [strMonth isEqualToString:@"octubre"])
    {
        strSpanishMonth = @"October";
    }
    else if([strMonth isEqualToString:@"November"] || [strMonth isEqualToString:@"noviembre"])
    {
        strSpanishMonth = @"November";
    }
    else {
        strSpanishMonth = @"December";
    }
//    labelCurrentMonth.text = [NSString stringWithFormat:@"%@ %@",strSpanishMonth,strYear];
//    labelCurrentMonth.textColor=[UIColor whiteColor];
}

-(NSMutableArray *)spanishWeekday
{
    return [NSMutableArray arrayWithObjects:@"L",@"M",@"M",@"J",@"V",@"S",@"D", nil];
//    return [NSMutableArray arrayWithObjects:@"Lun",@"Mar",@"Mié",@"Jue",@"Vie",@"Sáb",@"Dom", nil];
}
#pragma mark - Drawing
- (void)drawRect:(CGRect)rect
{
    int firstWeekDay = [self.currentMonth firstWeekDayInMonth]-1; //-1 because weekdays begin at 1, not 0
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MMMM yyyy"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    labelCurrentMonth.text = [formatter stringFromDate:self.currentMonth];
    NSLog(@"%@",[formatter stringFromDate:self.currentMonth]);
    
    //Spanish change
    if([[Utils stringRetrieveFromUserDefaults:KeyLanguage]isEqualToString:@"Sp"])
    {
        [formatter setDateFormat:@"MMMM"];
        NSString *strMonth = [formatter stringFromDate:self.currentMonth];
        [formatter setDateFormat:@"yyyy"];
        NSString *strYear = [formatter stringFromDate:self.currentMonth];
        [self setMonth:strMonth withYear:strYear];
    }
    else
    {
//        [formatter setDateFormat:@"MMMM"];
//        NSString *strMonth = [formatter stringFromDate:self.currentMonth];
//        [formatter setDateFormat:@"yyyy"];
//        NSString *strYear = [formatter stringFromDate:self.currentMonth];
//        [self setEnglishMonth:strMonth withYear:strYear];
    }
    //change over
    
    [labelCurrentMonth sizeToFit];
    labelCurrentMonth.frameX = roundf(self.frame.size.width/2 - labelCurrentMonth.frameWidth/2 - 30);
    labelCurrentMonth.frameY = 10;
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        labelCurrentMonth.frameX = roundf(self.frame.size.width/2.2 - labelCurrentMonth.frameWidth/2 - 30);
//        labelCurrentMonth.frameY = 10;
//    }else{
//        labelCurrentMonth.frameX = roundf(self.frame.size.width/2.8 - labelCurrentMonth.frameWidth/2 - 30);
//        labelCurrentMonth.frameY = 10;
//    }
    
//    [formatter release];
    [currentMonth firstWeekDayInMonth];
    
    CGContextClearRect(UIGraphicsGetCurrentContext(),rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect rectangle = CGRectMake(0,0,self.frame.size.width,calTopHeight);
    CGContextAddRect(context, rectangle);
//    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    CGContextFillPath(context);
    
    //Arrows
    int arrowSize = 12;
    int xmargin = 20;
    int ymargin = 18;
    
    //Arrow Left
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, xmargin+arrowSize/1.5, ymargin);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5,ymargin+arrowSize);
    CGContextAddLineToPoint(context,xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,xmargin+arrowSize/1.5, ymargin);
    
//    CGContextSetFillColorWithColor(context, 
//                                   [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(context,
                                   [UIColor clearColor].CGColor);

    CGContextFillPath(context);
    
    //Arrow right
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    CGContextAddLineToPoint(context,self.frame.size.width-xmargin,ymargin+arrowSize/2);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5),ymargin+arrowSize);
    CGContextAddLineToPoint(context,self.frame.size.width-(xmargin+arrowSize/1.5), ymargin);
    
//    CGContextSetFillColorWithColor(context, 
//                                   [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(context,
                                   [UIColor whiteColor].CGColor);

    CGContextFillPath(context);
    
    //Weekdays
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat=@"EEE";
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    //always assume gregorian with monday first
    NSMutableArray *weekdays = [[NSMutableArray alloc] initWithArray:[dateFormatter shortWeekdaySymbols]];
    [weekdays moveObjectFromIndex:0 toIndex:6];
    
    if([[Utils stringRetrieveFromUserDefaults:KeyLanguage]isEqualToString:@"Sp"])
    {
        weekdays = [self spanishWeekday];
    }
    
    CGContextSetFillColorWithColor(context, 
                                   [UIColor colorWithHexString:@"0x023e53"].CGColor);
    for (int i =0; i<[weekdays count]; i++) {
        NSString *weekdayValue = (NSString *)[weekdays objectAtIndex:i];
        UIFont *font;
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            font = [UIFont fontWithName:@"HelveticaNeue" size:20];
        }
        else
        {
            font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        }
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            [weekdayValue drawInRect:CGRectMake(i*(cellWidth+2), 60, cellWidth+2, 20) withFont:font lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
        }
        else
        {
            [weekdayValue drawInRect:CGRectMake(i*(cellWidth+2), 40, cellWidth+2, 20) withFont:font lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
        }
        
    }
    
    int numRows = [self numRows];
    
    CGContextSetAllowsAntialiasing(context, NO);
    
    //Grid background
    float gridHeight = numRows*(cellheight+2)+1;
    CGRect rectangleGrid = CGRectMake(0,calTopHeight,self.frame.size.width,gridHeight);
    CGContextAddRect(context, rectangleGrid);
//    CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xf3f3f3"].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    //CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0xff0000"].CGColor);
    CGContextFillPath(context);
    
    //Grid white lines
//    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
 
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, calTopHeight+1);
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CGContextAddLineToPoint(context, kVRGCalendarViewWidthiPad, calTopHeight+1);
    }
    else
    {
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, calTopHeight+1);
    }
    
    for (int i = 1; i<7; i++) {
        CGContextMoveToPoint(context, i*(cellWidth+1)+i*1-1, calTopHeight);
        CGContextAddLineToPoint(context, i*(cellWidth+1)+i*1-1, calTopHeight+gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, calTopHeight+i*(cellheight+1)+i*1+1);
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            CGContextAddLineToPoint(context, kVRGCalendarViewWidthiPad, calTopHeight+i*(cellheight+1)+i*1+1);
        }
        else
        {
             CGContextAddLineToPoint(context, kVRGCalendarViewWidth, calTopHeight+i*(cellheight+1)+i*1+1);
        }
    }
    
    CGContextStrokePath(context);
    
    //Grid dark lines
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"0xcfd4d8"].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, calTopHeight);
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CGContextAddLineToPoint(context, kVRGCalendarViewWidthiPad, calTopHeight);
    }
    else
    {
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, calTopHeight);
    }
    for (int i = 1; i<7; i++) {
        //columns
        CGContextMoveToPoint(context, i*(cellWidth+1)+i*1, calTopHeight);
        CGContextAddLineToPoint(context, i*(cellWidth+1)+i*1, calTopHeight+gridHeight);
        
        if (i>numRows-1) continue;
        //rows
        CGContextMoveToPoint(context, 0, calTopHeight+i*(cellheight+1)+i*1);
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            CGContextAddLineToPoint(context, kVRGCalendarViewWidthiPad, calTopHeight+i*(cellheight+1)+i*1);
        }
        else
        {
             CGContextAddLineToPoint(context, kVRGCalendarViewWidth, calTopHeight+i*(cellheight+1)+i*1);
        }
    }
    CGContextMoveToPoint(context, 0, gridHeight+calTopHeight);
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        CGContextAddLineToPoint(context, kVRGCalendarViewWidthiPad, gridHeight+calTopHeight);
    }
    else
    {
        CGContextAddLineToPoint(context, kVRGCalendarViewWidth, gridHeight+calTopHeight);
    }
    
    CGContextStrokePath(context);
    
    CGContextSetAllowsAntialiasing(context, YES);
    
    //Draw days
    CGContextSetFillColorWithColor(context, 
                                   [UIColor colorWithHexString:@"0xffffff"].CGColor);
    
    
    //NSLog(@"currentMonth month = %i, first weekday in month = %i",[self.currentMonth month],[self.currentMonth firstWeekDayInMonth]);
    
    int numBlocks = numRows*7;
    NSDate *previousMonth = [self.currentMonth offsetMonth:-1];
    int currentMonthNumDays = [currentMonth numDaysInMonth];
    int prevMonthNumDays = [previousMonth numDaysInMonth];
    
    int selectedDateBlock = ([selectedDate day]-1)+firstWeekDay;
    
    //prepAnimationPreviousMonth nog wat mee doen
    
    //prev next month
    BOOL isSelectedDatePreviousMonth = prepAnimationPreviousMonth;
    BOOL isSelectedDateNextMonth = prepAnimationNextMonth;
    
    if (self.selectedDate!=nil) {
        isSelectedDatePreviousMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]<[currentMonth month]) || [selectedDate year] < [currentMonth year];
        
        if (!isSelectedDatePreviousMonth) {
            isSelectedDateNextMonth = ([selectedDate year]==[currentMonth year] && [selectedDate month]>[currentMonth month]) || [selectedDate year] > [currentMonth year];
        }
    }
    
    if (isSelectedDatePreviousMonth) {
        int lastPositionPreviousMonth = firstWeekDay-1;
        selectedDateBlock=lastPositionPreviousMonth-([selectedDate numDaysInMonth]-[selectedDate day]);
    } else if (isSelectedDateNextMonth) {
        selectedDateBlock = [currentMonth numDaysInMonth] + (firstWeekDay-1) + [selectedDate day];
    }
    
    
    NSDate *todayDate = [NSDate date];
    int todayBlock = -1;
    
//    NSLog(@"currentMonth month = %i day = %i, todaydate day = %i",[currentMonth month],[currentMonth day],[todayDate month]);
    
    if ([todayDate month] == [currentMonth month] && [todayDate year] == [currentMonth year]) {
        todayBlock = [todayDate day] + firstWeekDay - 1;
    }
    
    for (int i=0; i<numBlocks; i++) {
        int targetDate = i;
        int targetColumn = i%7;
        int targetRow = i/7;
        int targetX = targetColumn * (cellWidth+2);
        int targetY = calTopHeight + targetRow * (cellheight+2);
        
        // BOOL isCurrentMonth = NO;
        if (i<firstWeekDay) { //previous month
            targetDate = (prevMonthNumDays-firstWeekDay)+(i+1);
            NSString *hex = (isSelectedDatePreviousMonth) ? @"0xffffff" : @"aaaaaa";
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        } else if (i>=(firstWeekDay+currentMonthNumDays)) { //next month
            targetDate = (i+1) - (firstWeekDay+currentMonthNumDays);
            NSString *hex = (isSelectedDateNextMonth) ? @"0xffffff" : @"aaaaaa";
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        } else { //current month
            // isCurrentMonth = YES;
            targetDate = (i-firstWeekDay)+1;
            NSString *hex = (isSelectedDatePreviousMonth || isSelectedDateNextMonth) ? @"0xaaaaaa" : @"0xaab1be";
            CGContextSetFillColorWithColor(context, 
                                           [UIColor colorWithHexString:hex].CGColor);
        }
        
        NSString *date = [NSString stringWithFormat:@"%i",targetDate];
        
        //draw selected date
        if (selectedDate && i==selectedDateBlock) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,cellWidth+2,cellheight+2);
            CGContextAddRect(context, rectangleGrid);
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x169B81"].CGColor);
//            CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context, 
                                           [UIColor whiteColor].CGColor);
//            CGContextSetFillColorWithColor(context,
//                                           [UIColor clearColor].CGColor);
        } else if (todayBlock==i) {
            CGRect rectangleGrid = CGRectMake(targetX,targetY,cellWidth+2,cellheight+2);
            CGContextAddRect(context, rectangleGrid);
            //CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x383838"].CGColor);
            CGContextSetFillColorWithColor(context, [UIColor colorWithHexString:@"0x023e53"].CGColor);

            CGContextFillPath(context);
            
            CGContextSetFillColorWithColor(context,
                                           [UIColor whiteColor].CGColor);
//            CGContextSetFillColorWithColor(context,
//                                           [UIColor clearColor].CGColor);
        }
        
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            [date drawInRect:CGRectMake(targetX+2, targetY+10, cellWidth, cellheight) withFont:[UIFont fontWithName:@"HelveticaNeue" size:24] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
        }
        else
        {
            [date drawInRect:CGRectMake(targetX+2, targetY+10, cellWidth, cellheight) withFont:[UIFont fontWithName:@"HelveticaNeue" size:16] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
        }
        
    }
    
    //    CGContextClosePath(context);
    
    
    //Draw markings
    if (!self.markedDates || isSelectedDatePreviousMonth || isSelectedDateNextMonth) return;
    
    for (int i = 0; i<[self.markedDates count]; i++) {
        id markedDateObj = [self.markedDates objectAtIndex:i];
        
        int targetDate;
        if ([markedDateObj isKindOfClass:[NSNumber class]]) {
            targetDate = [(NSNumber *)markedDateObj intValue];
        } else if ([markedDateObj isKindOfClass:[NSDate class]]) {
            NSDate *date = (NSDate *)markedDateObj;
            targetDate = [date day];
        } else {
            continue;
        }
        
        int targetBlock = firstWeekDay + (targetDate-1);
        int targetColumn = targetBlock%7;
        int targetRow = targetBlock/7;
        
        int targetX = targetColumn * (cellWidth+2) + 7;
        int targetY;
        
        CGRect rectangle;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            targetY = calTopHeight + targetRow * (cellheight+2) + 60;
            rectangle = CGRectMake(targetX,targetY,64,2);
        }
        else
        {
            targetY = calTopHeight + targetRow * (cellheight+2) + 28;
            rectangle = CGRectMake(targetX,targetY,20,2);
        }
        CGContextAddRect(context, rectangle);
        
        UIColor *color;
        if (selectedDate && selectedDateBlock==targetBlock) {
            color = [UIColor whiteColor];
            //color = [UIColor clearColor];
        }  else if (todayBlock==targetBlock) {
            color = [UIColor whiteColor];
            //color = [UIColor clearColor];
        } else {
            color  = (UIColor *)[markedColors objectAtIndex:i];
        }
        
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillPath(context);
    }
}

#pragma mark - Draw image for animation
-(UIImage *)drawCurrentState {
    float targetHeight = calTopHeight + [self numRows]*(cellheight+2)+1;
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        UIGraphicsBeginImageContext(CGSizeMake(kVRGCalendarViewWidthiPad, targetHeight-calTopHeight));
    }
    else
    {
        UIGraphicsBeginImageContext(CGSizeMake(kVRGCalendarViewWidth, targetHeight-calTopHeight));

    }
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(c, 0, -calTopHeight);    // <-- shift everything up by 40px when drawing.
    [self.layer renderInContext:c];
    UIImage* viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

#pragma mark - Init
-(id)init {
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self = [super initWithFrame:CGRectMake(60, 120, kVRGCalendarViewWidthiPad, 0)];
        cellheight = 76;
        cellWidth = 76;
        calTopHeight = 80;
    }
    else
    {
        self = [super initWithFrame:CGRectMake(0, 64, kVRGCalendarViewWidth, 0)];
        cellheight = 30;
        cellWidth = 30;
        calTopHeight = 60;
    }
    
    if (self) {
        self.contentMode = UIViewContentModeTop;
        self.clipsToBounds=YES;
        
        isAnimating=NO;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            self.labelCurrentMonth = [[UILabel alloc] initWithFrame:CGRectMake(34, 0, kVRGCalendarViewWidthiPad, 40)];
        }
        else
        {
            self.labelCurrentMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kVRGCalendarViewWidth-68, 40)];
        }
        [self addSubview:labelCurrentMonth];
        //labelCurrentMonth.backgroundColor=[UIColor whiteColor];
        labelCurrentMonth.backgroundColor=[UIColor clearColor];

        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            labelCurrentMonth.font = [UIFont fontWithName:@"HelveticaNeue" size:26];
        }
        else
        {
            labelCurrentMonth.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        }
        
        labelCurrentMonth.textColor = [UIColor colorWithHexString:@"0x093E52"];
        labelCurrentMonth.textAlignment = UITextAlignmentCenter;
        
        [self performSelector:@selector(reset) withObject:nil afterDelay:0.1]; //so delegate can be set after init and still get called on init
        //        [self reset];
    }
    return self;
}

-(void)dealloc {
    
    self.delegate=nil;
    self.currentMonth=nil;
    self.labelCurrentMonth=nil;
    
    self.markedDates=nil;
    self.markedColors=nil;
    
//    [super dealloc];
}
@end
