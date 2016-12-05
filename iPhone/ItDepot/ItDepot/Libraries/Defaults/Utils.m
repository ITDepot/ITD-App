

#define ISPAGED_JS_SNIPPET @"\
var elem = document.getElementsByName('paged')[0];\
if (elem) {\
elem.getAttribute('content');\
}"

#import "Utils.h"
#import "UIDevice+IdentifierAddition.h"
#import "Reachability.h"
#import "iToast.h"
#import "JSON.h"
#import "AppDelegate.h"
#import "CRToast.h"
#import "FileManager.h"
#import "JTSImageViewController.h"
#import "JTSImageInfo.h"
#import "RequestManager.h"
//#import "UIImage+Color.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"

@implementation Utils

MBProgressHUD *progressHud;


-(NSString *) addSuffixToNumber:(int) number
{
    NSString *suffix;
    int ones = number % 10;
    int temp = floor(number/10.0);
    int tens = temp%10;
    
    if (tens ==1) {
        suffix = @"th";
    } else if (ones ==1){
        suffix = @"st";
    } else if (ones ==2){
        suffix = @"nd";
    } else if (ones ==3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }
    
    NSString *completeAsString = [NSString stringWithFormat:@"%d%@",number,suffix];
    return completeAsString;
}

// Color
+ (UIColor *) getUIColorFromHexColor: (NSString *) hexColor withAlphaValue: (float) alphaValue{
	unsigned int red, green, blue;
	NSRange range;
	range.length = 2;
	range.location = 0; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	range.location = 2; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	range.location = 4; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];	
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alphaValue];
}

- (UIColor *) getUIColorFromHexColor: (NSString *) hexColor withAlphaValue: (float) alphaValue{
	unsigned int red, green, blue;
	NSRange range;
	range.length = 2;
	range.location = 0;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	range.location = 2;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	range.location = 4;
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:alphaValue];
}

- (NSString *) getHexColorFromUIColor:(UIColor *)color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"FFFFF0"];
    }
    return [NSString stringWithFormat:@"%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0), (int)((CGColorGetComponents(color.CGColor))[1]*255.0), (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

- (NSMutableArray *) getRGBColorArrayFromHexColor: (NSString *) hexColor withAlphaValue: (float) alphaValue{
	unsigned int red, green, blue;
	NSRange range;
	range.length = 2;
	range.location = 0; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	range.location = 2; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	range.location = 4; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];	
    
    NSMutableArray *rgbColor=[[NSMutableArray alloc] init];
    [rgbColor addObject:[NSString stringWithFormat:@"%f",(float)(red/255.0f)]];
    [rgbColor addObject:[NSString stringWithFormat:@"%f",(float)(green/255.0f)]];
    [rgbColor addObject:[NSString stringWithFormat:@"%f",(float)(blue/255.0f)]];
    [rgbColor addObject:[NSString stringWithFormat:@"%f",alphaValue]];
    return rgbColor;
}

- (UIColor *) getUIColorFromRGBColor: (NSArray *) rgbColor withAlphaValue: (float) alphaValue{
    return [UIColor colorWithRed:[[rgbColor objectAtIndex:0]floatValue] green:[[rgbColor objectAtIndex:1]floatValue] blue:[[rgbColor objectAtIndex:2]floatValue] alpha:alphaValue];
}

// Font
+ (UIFont *) getNexaBoldFontWithSize: (NSInteger)fontSize{
    UIFont *font = [UIFont fontWithName:FONT_NEXA_BOLD size:fontSize];
    return font;
}

+ (UIFont *) getNexaLightFontWithSize: (NSInteger)fontSize{
    UIFont *font = [UIFont fontWithName:FONT_NEXA_LIGHT size:fontSize];
    return font;
}

- (UIFont *) getFuturaBoldFontWithSize: (NSInteger)fontSize{
    UIFont *font = [UIFont fontWithName:FONT_FUTURA_BOLD size:fontSize];
    return font;
}

- (UIFont *) getFuturaCondensedWithSize: (NSInteger)fontSize{
    UIFont *font = [UIFont fontWithName:FONT_FUTURA_CONDENSED size:fontSize];
    return font;
}

- (UIFont *) getFuturaCondensedLightWithSize: (NSInteger)fontSize{
    UIFont *font = [UIFont fontWithName:FONT_FUTURA_CONDENSED_LIGHT size:fontSize];
    return font;
}

+ (UIFont *) getFuturaBoldFontWithSize: (NSInteger)fontSize{
    UIFont *font = [UIFont fontWithName:FONT_FUTURA_BOLD size:fontSize];
    return font;
}

+ (UIFont *) getFuturaCondensedWithSize: (NSInteger)fontSize{
    UIFont *font = [UIFont fontWithName:FONT_FUTURA_CONDENSED size:fontSize];
    return font;
}

+ (UIFont *) getFuturaCondensedLightWithSize: (NSInteger)fontSize{
    UIFont *font = [UIFont fontWithName:FONT_FUTURA_CONDENSED_LIGHT size:fontSize];
    return font;
}

+ (void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews
{
    [self setFontFamily:fontFamily forView:view andSubViews:isSubViews leftPadding:10 rightPadding:10];
}

+ (void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews leftPadding:(int)leftPadding rightPadding:(int)rightPadding
{
    
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *lbl = (UILabel *)view;
        NSString *fontName = lbl.font.fontName;
        
        //NSLog(@"uilabel font name '%@' --> '%@'",fontName,lbl.text);
        if([fontName isEqualToString:FONT_KAILASA]){
            fontFamily=FONT_FUTURA_CONDENSED;
            [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
            
        }else if([fontName isEqualToString:FONT_DEFAULT_NORMAL] || [fontName isEqualToString:FONT_DEFAULT_NORMAL_2]){
            fontFamily=FONT_FUTURA_CONDENSED_LIGHT;
            [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
            
        }else if([fontName isEqualToString:FONT_DEFAULT_BOLD]){
            fontFamily=FONT_FUTURA_BOLD;
            [lbl setFont:[UIFont fontWithName:fontFamily size:[[lbl font] pointSize]]];
            
        }else{
            //NSLog(@"different type face uilabel");
            //fontFamily=FONT_MYRIAD_PRO_REGULAR;
        }
        
    }else if ([view isKindOfClass:[UIButton class]]){
        UIButton *btn = (UIButton *)view;
        NSString *fontName = btn.titleLabel.font.fontName;
        //NSLog(@"uibutton font name '%@' --> '%@'",fontName,btn.titleLabel.text);
        
        if([fontName isEqualToString:FONT_KAILASA]){
            fontFamily=FONT_FUTURA_CONDENSED;
            [btn.titleLabel setFont:[UIFont fontWithName:fontFamily size:[[btn.titleLabel font] pointSize]]];
            
        }else if([fontName isEqualToString:FONT_DEFAULT_NORMAL] || [fontName isEqualToString:FONT_DEFAULT_NORMAL_2]){
            fontFamily=FONT_FUTURA_CONDENSED_LIGHT;
            [btn.titleLabel setFont:[UIFont fontWithName:fontFamily size:[[btn.titleLabel font] pointSize]]];
            
        }else if([fontName isEqualToString:FONT_DEFAULT_BOLD]){
            fontFamily=FONT_FUTURA_BOLD;
            [btn.titleLabel setFont:[UIFont fontWithName:fontFamily size:[[btn.titleLabel font] pointSize]]];
            
        }else{
            //NSLog(@"different type face uibutton");
            //fontFamily=FONT_MYRIAD_PRO_REGULAR;
        }
        
        
    }else if ([view isKindOfClass:[UITextField class]]){
        
        UITextField *txt = (UITextField *)view;
        NSString *fontName = txt.font.fontName;
        
        //NSLog(@"uitextfield font name '%@' --> '%@'",fontName,txt.text);
        
        if([fontName isEqualToString:FONT_KAILASA]){
            fontFamily=FONT_FUTURA_CONDENSED;
            [txt setFont:[UIFont fontWithName:fontFamily size:[[txt font] pointSize]]];
            
        }else if([fontName isEqualToString:FONT_DEFAULT_NORMAL] || [fontName isEqualToString:FONT_DEFAULT_NORMAL_2]){
            fontFamily=FONT_FUTURA_CONDENSED_LIGHT;
            [txt setFont:[UIFont fontWithName:fontFamily size:[[txt font] pointSize]]];
            
        }else if([fontName isEqualToString:FONT_DEFAULT_BOLD]){
            fontFamily=FONT_FUTURA_BOLD;
            [txt setFont:[UIFont fontWithName:fontFamily size:[[txt font] pointSize]]];
            
        }else{
            //NSLog(@"different type face uitextfield");
            //fontFamily=FONT_MYRIAD_PRO_REGULAR;
        }
        
        UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftPadding, rightPadding)];
        [txt setLeftViewMode:UITextFieldViewModeAlways];
        [txt setLeftView:spacerView];
        [txt setRightViewMode:UITextFieldViewModeAlways];
        [txt setRightView:spacerView];
        
    }else if ([view isKindOfClass:[UITextView class]]){
        UITextView *txtView = (UITextView *)view;
        NSString *fontName = txtView.font.fontName;
        //NSLog(@"uitextview font name '%@' --> '%@'",fontName,txtView.text);
        
        if([fontName isEqualToString:FONT_KAILASA]){
            fontFamily=FONT_FUTURA_CONDENSED;
            [txtView setFont:[UIFont fontWithName:fontFamily size:[[txtView font] pointSize]]];
            
        }else if([fontName isEqualToString:FONT_DEFAULT_NORMAL] || [fontName isEqualToString:FONT_DEFAULT_NORMAL_2]){
            fontFamily=FONT_FUTURA_CONDENSED_LIGHT;
            [txtView setFont:[UIFont fontWithName:fontFamily size:[[txtView font] pointSize]]];
            
        }else if([fontName isEqualToString:FONT_DEFAULT_BOLD]){
            fontFamily=FONT_FUTURA_BOLD;
            [txtView setFont:[UIFont fontWithName:fontFamily size:[[txtView font] pointSize]]];
            
        }else{
            //NSLog(@"different type face uitextview");
            //fontFamily=FONT_MYRIAD_PRO_REGULAR;
        }
        
    }
    
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setFontFamily:fontFamily forView:sview andSubViews:YES leftPadding:leftPadding rightPadding:rightPadding];
        }
    }
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColorString:(NSString *)colorString
{
    UIColor *color=[self getUIColorFromHexColor:colorString withAlphaValue:1];
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (NSString *)convertTimeInAmPmFormat:(NSString *)time{
    @try {
        NSArray *timeArray= [time componentsSeparatedByString:@":"];
        if([timeArray count]>0){
            int hour=[[timeArray objectAtIndex:0] intValue];
            int minute=[[timeArray objectAtIndex:1] intValue];
            
            if(hour<12){
                return [NSString stringWithFormat:@"%02d:%02d AM",hour,minute];
            }else if (hour==12){
                return [NSString stringWithFormat:@"%02d:%02d PM",hour,minute];
            }else if (hour>12){
                return [NSString stringWithFormat:@"%02d:%02d PM",hour-12,minute];
            }
        }
        return @"";

    }
    @catch (NSException *exception) {
        NSLog(@"excetion convertTimeInAmPmFormat %@",exception.description);
        return @"-";
    }
    
}

+ (NSString *)convertTimeIn24HoursFormat:(NSString *)time{
    @try {
        
        NSArray *timeArray= [time componentsSeparatedByString:@" "];
        if([timeArray count]>0){
            
            NSString *amPm=[[timeArray objectAtIndex:1] uppercaseString];
            int hours=[[[[timeArray objectAtIndex:0] componentsSeparatedByString:@":"] objectAtIndex:0] intValue];
            int minutes=[[[[timeArray objectAtIndex:0] componentsSeparatedByString:@":"] objectAtIndex:1] intValue];
            
            if([amPm isEqualToString:@"AM"]){
                if(hours==12){
                    hours=0;
                }
                
            }else{
                if(hours!=12){
                    hours+=12;
                }
            }
            
            return [NSString stringWithFormat:@"%02d:%02d:00",hours,minutes];
        }
        return @"";
    }
    @catch (NSException *exception) {
        NSLog(@"excetion convertTimeIn24HoursFormat %@",exception.description);
        return @"-";
    }
}

+(BOOL)isInternetAvailable{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    }else{
        return YES;
    }
    //AppDelegate_iPad *delegate=[[UIApplication sharedApplication]delegate];
    //[delegate.window.rootViewController.view addSubview:<#(UIView *)#>];
}

+ (void)setLocalizedValuesforView:(UIView*)view andSubViews:(BOOL)isSubViews{
    
    FileManager *fileManager=[[FileManager alloc]init];
    NSString *lang=@"en";
    NSMutableDictionary *otherSettings=[fileManager getOtherSettingsData];
    if(otherSettings!=nil){
        if([otherSettings objectForKey:SELECTED_LAUNGUAGE]){
            lang=[otherSettings objectForKey:SELECTED_LAUNGUAGE];
        }
    }
    
    //lang=@"fr";
    
    if ([view isKindOfClass:[UILabel class]])
    {
        UILabel *label = (UILabel *)view;
        NSString *title=[label text];
        label.text=[self getLocalizdString:title language:lang];
        
    }else if ([view isKindOfClass:[UIButton class]]){
        UIButton *button = (UIButton *)view;
        NSString *title=button.titleLabel.text;
        [button setTitle:[self getLocalizdString:title language:lang] forState:UIControlStateNormal];
        
    }else if ([view isKindOfClass:[UITextField class]]){
        
        UITextField *textField = (UITextField *)view;
        NSString *title=[textField text];
        if ([title isEqualToString:@""]) {
            title=textField.placeholder;
            textField.placeholder=[self getLocalizdString:title language:lang];
            return;
        }
        textField.text=[self getLocalizdString:title language:lang];
        
    }else if ([view isKindOfClass:[UITextView class]]){
        UITextView *textView = (UITextView *)view;
        NSString *title=[textView text];
        textView.text=[self getLocalizdString:title language:lang];
        
    }else if ([view isKindOfClass:[UITextField class]]){
        
    }
    
    if (isSubViews)
    {
        for (UIView *sview in view.subviews)
        {
            [self setLocalizedValuesforView:sview andSubViews:YES];
        }
    }
}

+ (NSString *)getLocalizdString:(NSString *)value{
    NSString *localizedValue=@"";
    
    @try {
        localizedValue=NSLocalizedString(value, nil);
    }
    @catch (NSException *exception) {
        NSLog(@"Exception while get localized value %@",[exception description]);
        localizedValue=value;
    }
    NSLog(@"localizedValue %@",localizedValue);
    return localizedValue;
}

+ (NSString *)getLocalizdImageName:(NSString *)value{
    
    //    NSString *userLocale = [[NSLocale currentLocale] localeIdentifier];
    //    NSString *userLanguage = [userLocale substringToIndex:2];
    NSString * userLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    NSLog(@"local language code %@",userLanguage);
    
    if([userLanguage isEqualToString:@"nl"]){
        //Dutch
        return [NSString stringWithFormat:@"%@_nl.png",value];
        
    }else{
        //English
        return [NSString stringWithFormat:@"%@.png",value];
    }
}

+ (NSString *)getLocalizdString:(NSString *)value language:(NSString *)language{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    
    NSBundle* languageBundle = [NSBundle bundleWithPath:path];
    NSString* str=[languageBundle localizedStringForKey:value value:value table:nil];
    
    return str;
    
//    FileManager *fileManager=[[FileManager alloc]init];
//    NSMutableDictionary *langDictionary=nil;
//    NSMutableDictionary *otherSettings=[fileManager getOtherSettingsData];
//    if(otherSettings!=nil){
//        if([otherSettings objectForKey:LANGUAGE]){
//            langDictionary=[otherSettings objectForKey:LANGUAGE];
//        }
//    }
//    
//    if(langDictionary!=nil){
//        NSMutableDictionary *dictionary=[langDictionary objectForKey:language];
//        if([dictionary objectForKey:value]){
//            return [dictionary objectForKey:value];
//        }else{
//            return value;
//        }
//        
//    }else{
//        return value;
//    }
    
}

//+ (void)setLocalizedValuesforView:(UIView*)view andSubViews:(BOOL)isSubViews{
//
//    if ([view isKindOfClass:[UILabel class]])
//    {
//        UILabel *label = (UILabel *)view;
//        NSString *title=[label text];
//        label.text=[self getLocalizdString:title];
//        
//    }else if ([view isKindOfClass:[UIButton class]]){
//        UIButton *button = (UIButton *)view;
//        NSString *title=button.titleLabel.text;
//        [button setTitle:[self getLocalizdString:title] forState:UIControlStateNormal];
//        
//    }else if ([view isKindOfClass:[UITextField class]]){
//        
//        
//    }else if ([view isKindOfClass:[UITextView class]]){
//       
//    }
//    
//    if (isSubViews)
//    {
//        for (UIView *sview in view.subviews)
//        {
//            [self setLocalizedValuesforView:sview andSubViews:YES];
//        }
//    }
//}
//
//+ (NSString *)getLocalizdString:(NSString *)value{
//    NSString *localizedValue=@"";
//    
//    @try {
//        localizedValue=NSLocalizedString(value, nil);
//    }
//    @catch (NSException *exception) {
//        NSLog(@"Exception while get localized value %@",[exception description]);
//        localizedValue=value;
//    }
//    NSLog(@"localizedValue %@",localizedValue);
//    return localizedValue;
//}
//
//+ (NSString *)getLocalizdImageName:(NSString *)value{
//    
////    NSString *userLocale = [[NSLocale currentLocale] localeIdentifier];
////    NSString *userLanguage = [userLocale substringToIndex:2];
//    NSString * userLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
//
//    NSLog(@"local language code %@",userLanguage);
//    
//    if([userLanguage isEqualToString:@"nl"]){
//        //Dutch
//        return [NSString stringWithFormat:@"%@_nl.png",value];
//        
//    }else{
//        //English
//     return [NSString stringWithFormat:@"%@.png",value];
//    }
//}


// Date Time
- (NSString *)getCurrentDateTime{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm"];
    NSString *currentDate=[self getLocalTimeAsStringFromDate:date andWithFormat:dateFormatter];
    return currentDate;
}

- (NSString *)getDateAsUniqueId{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyddMMHHmmssSSS"];
    NSString *uniqueDate = [dateFormatter stringFromDate:date];
    return uniqueDate;
}

- (NSString *)getDateAsUniqueId:(NSString *)prefix{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyddMMHHmmssSSS"];
    NSString *uniqueDate = [NSString stringWithFormat:@"%@%@",prefix,[dateFormatter stringFromDate:date]];
    return uniqueDate;
}

- (NSString *)getTimeSpanToMinutesForHours:(NSString *)hours AndMinutes:(NSString *)minutes {
    int totalHours = [hours intValue];
    int totalMinutes = [minutes intValue];
    totalMinutes += totalHours*60;
    return [NSString stringWithFormat:@"%d",totalMinutes];
}

- (NSString *)getTimeSpanToHoursAndMinutesForSeconds:(NSInteger)secondsInterval {
    int hour = secondsInterval/3600;
    int minutes = (secondsInterval/60)%60;
    return [self getTimeSpanToMinutesForHours:[NSString stringWithFormat:@"%d",hour] AndMinutes:[NSString stringWithFormat:@"%d",minutes]];
}

- (NSInteger)getTimeSpanBetweenDateOne:(NSString *)dateOne AndDateTwo:(NSString *)dateTwo {
    [NSTimeZone resetSystemTimeZone];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm"];
    
    NSDate *date1 = [dateFormatter dateFromString:dateOne];
    NSDate *date2 = [dateFormatter dateFromString:dateTwo];
    
    NSTimeInterval differenceBetweenDates = [date1 timeIntervalSinceDate:date2];
    //double secondsInAnHour = 3600;
    //double minutesInAnHour = 60;
    //NSInteger minutesBetweenDates = differenceBetweenDates / minutesInAnHour;
    //NSInteger hoursBetweenDates = differenceBetweenDates / secondsInAnHour;
    return differenceBetweenDates;
}


- (NSString *)getSameStringAsDate:(NSDate *)itemDate{
    NSString *dateString=@"";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    dateString=[self getGlobalTimeAsStringFromDate:itemDate andWithFormat:dateFormatter];
    return dateString;
}

+ (NSString *)getSameStringAsDate:(NSDate *)itemDate{
    NSString *dateString=@"";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    dateString=[self getGlobalTimeAsStringFromDate:itemDate andWithFormat:dateFormatter];
    return dateString;
}

- (NSString *)getSameStringAsDate:(NSDate *)itemDate havingDateFormatter:(NSDateFormatter *)dateFormatter{
    NSString *dateString=@"";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    dateString=[self getGlobalTimeAsStringFromDate:itemDate andWithFormat:dateFormatter];
    return dateString;
}

+ (NSString *)getSameStringAsDate:(NSDate *)itemDate havingDateFormatter:(NSDateFormatter *)dateFormatter{
    NSString *dateString=@"";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    dateString=[self getGlobalTimeAsStringFromDate:itemDate andWithFormat:dateFormatter];
    return dateString;
}

- (NSString *)getGMTStringAsDate:(NSDate *)itemDate{
    NSString *dateString=@"";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    dateString=[self getLocalTimeAsStringFromDate:itemDate andWithFormat:dateFormatter];
    return dateString;
}

+ (NSString *)getGMTStringAsDate:(NSDate *)itemDate{
    NSString *dateString=@"";
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    dateString=[self getLocalTimeAsStringFromDate:itemDate andWithFormat:dateFormatter];
    return dateString;
}

- (NSString *)getGMTStringAsDate:(NSDate *)itemDate havingDateFormatter:(NSDateFormatter *)dateFormatter{
    NSString *dateString=@"";
   NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    dateString=[self getLocalTimeAsStringFromDate:itemDate andWithFormat:dateFormatter];
    return dateString;
}

+ (NSString *)getGMTStringAsDate:(NSDate *)itemDate havingDateFormatter:(NSDateFormatter *)dateFormatter{
    NSString *dateString=@"";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    dateString=[self getLocalTimeAsStringFromDate:itemDate andWithFormat:dateFormatter];
    return dateString;
}

- (NSDate *)getSameDateAsString:(NSString *)itemString{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    NSDate *dateString=[self getGlobalTimeAsDateFromDate:itemString andWithFormat:dateFormatter];
    return dateString;
}

+ (NSDate *)getSameDateAsString:(NSString *)itemString{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    NSDate *dateString=[self getGlobalTimeAsDateFromDate:itemString andWithFormat:dateFormatter];
    return dateString;
}

- (NSDate *)getSameDateAsString:(NSString *)itemString havingDateFormatter:(NSDateFormatter *)dateFormatter{
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    NSDate *dateString=[self getGlobalTimeAsDateFromDate:itemString andWithFormat:dateFormatter];
    return dateString;
}

+ (NSDate *)getSameDateAsString:(NSString *)itemString havingDateFormatter:(NSDateFormatter *)dateFormatter{
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    NSDate *dateString=[self getGlobalTimeAsDateFromDate:itemString andWithFormat:dateFormatter];
    return dateString;
}

- (NSDate *)getGMTDateAsString:(NSString *)itemString{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    NSDate *dateString=[self getLocalTimeAsDateFromDate:itemString andWithFormat:dateFormatter];
    return dateString;
}

+ (NSDate *)getGMTDateAsString:(NSString *)itemString{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd HH:mm:ss";
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    NSDate *dateString=[self getLocalTimeAsDateFromDate:itemString andWithFormat:dateFormatter];
    return dateString;
}

- (NSDate *)getGMTDateAsString:(NSString *)itemString havingDateFormatter:(NSDateFormatter *)dateFormatter{
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    NSDate *dateString=[self getLocalTimeAsDateFromDate:itemString andWithFormat:dateFormatter];
    return dateString;
}

+ (NSDate *)getGMTDateAsString:(NSString *)itemString havingDateFormatter:(NSDateFormatter *)dateFormatter{
    NSLocale *twentyFour = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    dateFormatter.locale=twentyFour;
    
    NSDate *dateString=[self getLocalTimeAsDateFromDate:itemString andWithFormat:dateFormatter];
    return dateString;
}

-(NSDate *) getGlobalTimeAsDateFromDate:(NSString *)date andWithFormat:(NSDateFormatter *)dateFormatter{
    [dateFormatter setTimeZone :[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [dateFormatter dateFromString:date];
}

+(NSDate *) getGlobalTimeAsDateFromDate:(NSString *)date andWithFormat:(NSDateFormatter *)dateFormatter{
    [dateFormatter setTimeZone :[NSTimeZone timeZoneForSecondsFromGMT:0]];
    return [dateFormatter dateFromString:date];
}

-(NSString *) getGlobalTimeAsStringFromDate:(NSDate *)date andWithFormat:(NSDateFormatter *)dateFormatter{
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
}

+(NSString *) getGlobalTimeAsStringFromDate:(NSDate *)date andWithFormat:(NSDateFormatter *)dateFormatter{
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
}

-(NSDate *) getLocalTimeAsDateFromDate:(NSString *)date andWithFormat:(NSDateFormatter *)dateFormatter{
    NSInteger seconds = [[NSTimeZone systemTimeZone] secondsFromGMT];
    [dateFormatter setTimeZone :[NSTimeZone timeZoneForSecondsFromGMT: seconds]];
    return [dateFormatter dateFromString:date];
}

+(NSDate *) getLocalTimeAsDateFromDate:(NSString *)date andWithFormat:(NSDateFormatter *)dateFormatter{
    NSInteger seconds = [[NSTimeZone systemTimeZone] secondsFromGMT];
    [dateFormatter setTimeZone :[NSTimeZone timeZoneForSecondsFromGMT: seconds]];
    return [dateFormatter dateFromString:date];
}

-(NSString *) getLocalTimeAsStringFromDate:(NSDate *)date andWithFormat:(NSDateFormatter *)dateFormatter{
    NSInteger seconds = [[NSTimeZone systemTimeZone] secondsFromGMT];
    [dateFormatter setTimeZone :[NSTimeZone timeZoneForSecondsFromGMT: seconds]];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
}

+(NSString *) getLocalTimeAsStringFromDate:(NSDate *)date andWithFormat:(NSDateFormatter *)dateFormatter{
    NSInteger seconds = [[NSTimeZone systemTimeZone] secondsFromGMT];
    [dateFormatter setTimeZone :[NSTimeZone timeZoneForSecondsFromGMT: seconds]];
    return [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:date]];
}

- (NSString *) getDateAsTimeIntervalInSeconds{
    NSDate *date=[NSDate date];
    NSInteger seconds=[date timeIntervalSince1970];
    //NSInteger seconds = [[NSTimeZone systemTimeZone] secondsFromGMT];
    return [NSString stringWithFormat:@"%d",seconds];
}

- (NSString *)getCurrentDay{
    NSDate *date = [NSDate date];
    NSDateFormatter *weekDay = [[NSDateFormatter alloc] init];
    [weekDay setDateFormat:@"EEEE"];
    NSString *day = [NSString stringWithFormat:@"%@",[weekDay stringFromDate:date]];   
    return day;
}


// System
- (NSString *) getSystemVersionOfIphone{
    @try {
        return [[UIDevice currentDevice] systemVersion];    
    }
    @catch (NSException *exception) {
        return @"Oops! Exception in getting OS Version";
    }
}

+ (NSString *)getDeviceIdForDevice{
    /*NSString *appDomain = @"com.AnantApps.Moodlytics";
     NSString *appKey = @"AnantAppsMoodlyticsiPhoneClient";
     NSString *uniqueSecureId = [SecureUDID UDIDForDomain:appDomain usingKey:appKey];  
     return uniqueSecureId;*/
    NSString *uniqueID= [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
    return uniqueID;
    
//    NSString *deviceId=@"";
//    MoodlyticsFileManager *fileManager=[[MoodlyticsFileManager alloc]init];
//    NSMutableDictionary *dictionary=[fileManager getApplicationSettingsData];
//    if(dictionary==nil){
//        dictionary=[[NSMutableDictionary alloc]init];
//    }else{
//        [dictionary retain];
//    }
//    if([dictionary objectForKey:DEVICE_ID]){
//        deviceId=[NSString stringWithFormat:@"%@",[dictionary objectForKey:DEVICE_ID] ];
//    }else{
//        
//        NSString *string=[self getDateAsUniqueId];
//        NSString *string2= [self createMd5Password:string];
//        [dictionary setObject:string2 forKey:DEVICE_ID];
//        [fileManager writeApplicationSettingsData:dictionary];
//        deviceId=string2;
//    }
//    [dictionary release];
//    [fileManager release];
//    NSLog(@"device id %@",deviceId);
//    return deviceId;

}
//- (NSString *)createMd5Password:(NSString *)passWord{
    
    //unsigned char result[16];
    //
    //CC_MD5([passWord UTF8String] ,[passWord length],result);
    //
    //NSString *md5password = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                             
      //                       result[0], result[1],result[2], result[3],result[4], result[5],result[6], result[7],
                             
      //                       result[8], result[9],result[10], result[11],result[12], result[13],result[14], result[15]
                             
      //                       ];
    
    //return md5password;
    
//}

- (NSString *)getPhoneModel{
    NSString *str=[NSString stringWithFormat:@"Name - %@ :SystemName - %@ :Model - %@ :Localized Model - %@",[[UIDevice currentDevice] name],[[UIDevice currentDevice] systemName],[[UIDevice currentDevice] model],[[UIDevice currentDevice] localizedModel]];
    return [self urlEncode:str];
}

-(NSString *)urlEncode:(NSString *)value {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,(CFStringRef)value,NULL,
                                                               (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                               CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
}

- (NSString *)getOperatingSystemVersion{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)getApplicationVersion{
    NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    return versionString;
}

- (NSString *)getApplicationClient{
    UIUserInterfaceIdiom idiom = UI_USER_INTERFACE_IDIOM();
	if (idiom == UIUserInterfaceIdiomPad){
        return @"iPad";
    }else if(idiom==UIUserInterfaceIdiomPhone){
        return @"iPhone";
    }else{
        return @"iOS";
    }
}

- (NSString *)getCountryCode {
    NSString *countryCode = [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    NSString *countryName = [[NSLocale currentLocale] displayNameForKey: NSLocaleCountryCode
                                                                  value: countryCode];
    return [NSString stringWithFormat:@"%@ - (%@)",countryName,countryCode];
}

- (NSString *)getGMTOffset {
    return [NSString stringWithFormat:@"%f",([[NSTimeZone systemTimeZone] secondsFromGMT] / 3600.0)];
}

- (NSString *)getTimeZone {
    return [NSString stringWithFormat:@"Local TimeZone - %@ : System TimeZone - %@",[[NSTimeZone localTimeZone] name],[[NSTimeZone systemTimeZone] name]];
}

+ (void) showNoInternetConnectionAlertDialog{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"It seems you are not connected to the internet. Kindly connect and try again" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void) showSomethingWentWrongAlertDialog{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:APPLICATION_NAME message:@"Oops! Something went wrong. Kindly try again later" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void)showAlertMessage:(NSString *)alertMesasge{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:APPLICATION_NAME message:alertMesasge delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

+ (void)showToastMessage:(NSString *)toastMesasge{
    iToast *toast=[[iToast alloc]initWithText:toastMesasge];
    [toast show];
}

+ (void)showToastMessageBottom:(NSString *)toastMesasge{
    iToast *toast=[[iToast alloc]initWithText:toastMesasge];
    [toast setGravity:iToastGravityBottom];
    [toast show];
}

- (NSDictionary *)parseResults:(NSString *)result{
    SBJSON *jsonParser = [SBJSON new];
    NSDictionary *data = (NSDictionary *) [jsonParser objectWithString:result error:NULL];
    return data;
}

+ (void)showIndicator:(NSString *)message withDelegate:(id)delagate
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [app.window setUserInteractionEnabled:NO];
    progressHud = [[MBProgressHUD alloc] initWithView:app.window];
	[app.window addSubview:progressHud];
    progressHud.delegate = delagate;
	progressHud.labelText = message;
	
	[progressHud show:YES];
    
}

+ (void)showIndicatorwithDelegate:(id)delagate
{
    [self showIndicator:@"Please wait..." withDelegate:delagate];
}

+ (void)hideIndicator
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [app.window setUserInteractionEnabled:YES];
    [progressHud show:NO];
    [progressHud removeFromSuperview];
	///[HUD release];
	progressHud = nil;
}

+ (NSString *)getCurrentUserId{
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherSettingsDictionary=[fileManager getOtherSettingsData];
    NSString *userId=[otherSettingsDictionary objectForKey:USER_IDD];
    
    if(userId==nil){
        userId=@"";
    }
    return userId;
    
}

+ (BOOL)isUserAlreadyloggedIn{
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    
    BOOL isLoggedIn=NO;
    
    if (otherDetails!=nil) {
        if([otherDetails objectForKey:IS_LOGGED_IN]){
            if([[otherDetails objectForKey:IS_LOGGED_IN] isEqualToString:@"1"]){
                isLoggedIn=YES;
            }
        }
    }
    return isLoggedIn;
}

+(NSDictionary *)parseResults:(NSString *)result{
	SBJSON *jsonParser = [SBJSON new];
    NSError *errorr;
	NSDictionary *data = (NSDictionary *) [jsonParser objectWithString:result error:&errorr];
    
    NSLog(@"data %@",data);
    //    if(errorr!=nil){
    //        NSLog(@"error %@",errorr);
    //    }
	return data;
    //return nil;
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIImage *tempImage=[self resizedImageWithContentMode:UIViewContentModeScaleAspectFill imageToScale:image bounds:newSize interpolationQuality:0];
    return tempImage;
}

+  (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode imageToScale:(UIImage*)imageToScale bounds:(CGSize)bounds interpolationQuality:(CGInterpolationQuality)quality {
    
    CGFloat horizontalRatio = bounds.width / imageToScale.size.width;
    CGFloat verticalRatio = bounds.height / imageToScale.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %d", contentMode];
    }
    CGSize newSize = CGSizeMake(imageToScale.size.width * ratio, imageToScale.size.height * ratio);
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = imageToScale.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,newRect.size.width,newRect.size.height,CGImageGetBitsPerComponent(imageRef),0,CGImageGetColorSpace(imageRef),CGImageGetBitmapInfo(imageRef));
    CGContextSetInterpolationQuality(bitmap, quality);
    CGContextDrawImage(bitmap, newRect, imageRef);
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    return newImage;
}

+ (void)showView:(UIView *)view{
    //[self.view addSubview:_picsView];
    view.hidden=NO;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         //                         picsViewFrame.origin.y=0;
                         //                         _picsView.frame=picsViewFrame;
                         [view setAlpha:1];
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];
    
    
}

+ (void)hideView:(UIView *)view{
    //[_picsView removeFromSuperview];
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         //                         picsViewFrame.origin.y=-(self.view.frame.size.height+20);
                         //                         _picsView.frame=picsViewFrame;
                         [view setAlpha:0];
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                         view.hidden=YES;
                     }];
    
}

//+ (NSString *)getProfileImagesPath{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *destinationPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/%@/",FOLDER_IMAGES,FOLDER_PROFILE]];
//    return destinationPath;
//}

+ (void)showUserNotLoggedInAlertMessage{
    [self showAlertMessage:@"It seems you are not logged in. Plesae login and try again later."];
}

+(NSData *)getCompressedImageData:(UIImage *)originalImage
{
    // UIImage *largeImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImage *largeImage = originalImage;
    
    double compressionRatio = 1;
    int resizeAttempts = 3;
    NSData * imgData = UIImageJPEGRepresentation(largeImage,compressionRatio);
    NSLog(@"Starting Size: %lu", (unsigned long)[imgData length]);
    
    if([imgData length]>1000000){
        resizeAttempts=4;
    }else if ([imgData length]>400000 && [imgData length]<=1000000){
        resizeAttempts=2;
    }else if ([imgData length]>100000 && [imgData length]<=400000){
        resizeAttempts=2;
    }else if ([imgData length]>40000 && [imgData length]<=100000){
        resizeAttempts=1;
    }else if ([imgData length]>10000 && [imgData length]<=40000){
        resizeAttempts=1;
    }
    
    NSLog(@"resizeAttempts %d",resizeAttempts);
    
    //Trying to push it below around about 0.4 meg
    //while ([imgData length] > 400000 && resizeAttempts > 0) {
    while (resizeAttempts > 0) {
        
        resizeAttempts -= 1;
        
        NSLog(@"Image was bigger than 400000 Bytes. Resizing.");
        NSLog(@"%i Attempts Remaining",resizeAttempts);
        
        //Increase the compression amount
        compressionRatio = compressionRatio*0.6;
        NSLog(@"compressionRatio %f",compressionRatio);
        //Test size before compression
        NSLog(@"Current Size: %lu",(unsigned long)[imgData length]);
        imgData = UIImageJPEGRepresentation(largeImage,compressionRatio);
        
        //Test size after compression
        NSLog(@"New Size: %lu",(unsigned long)[imgData length]);
    }
    
    //Set image by comprssed version
    UIImage *savedImage = [UIImage imageWithData:imgData];
    
    //Check how big the image is now its been compressed and put into the UIImageView
    // *** I made Change here, you were again storing it with Highest Resolution ***
    
    NSData *endData = UIImageJPEGRepresentation(savedImage,compressionRatio);
    //NSData *endData = UIImagePNGRepresentation(savedImage);
    
    NSLog(@"Ending Size: %lu", (unsigned long)[endData length]);
    
    return endData;
    //    NSString *path = [self createPath:@"myImage.png"];
    //    NSLog(@"%@",path);
    //    [endData writeToFile:path atomically:YES];
}

+ (void)showToastNotificationAtTop:(NSString *)message{
    [self showToastNotificationAtTop:message withDuration:3.0f];
}

+ (void)showToastNotificationAtTop:(NSString *)message withDuration:(float)duration{
    //    NSMutableDictionary *options=[[NSMutableDictionary alloc]init];
    //    options[kCRToastNotificationTypeKey]=@(CRToastTypeNavigationBar);
    //    options[kCRToastImageKey] = [UIImage imageNamed:@"alert_icon.png"];
    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey               : @(CRToastTypeNavigationBar),
                                      kCRToastNotificationPresentationTypeKey   : @(CRToastPresentationTypeCover),
                                      kCRToastUnderStatusBarKey                 : @(NO),
                                      kCRToastTextKey                           : message,
                                      kCRToastTextAlignmentKey                  : @(NSTextAlignmentCenter),
                                      kCRToastTimeIntervalKey                   : @(duration),
                                      kCRToastAnimationInTypeKey                : @(CRToastAnimationTypeLinear),
                                      kCRToastAnimationOutTypeKey               : @(CRToastAnimationTypeLinear),
                                      kCRToastAnimationInDirectionKey           : @(0),
                                      kCRToastAnimationOutDirectionKey          : @(0)} mutableCopy];
    
    
    //    NSMutableDictionary *options = [@{kCRToastNotificationTypeKey               : self.coverNavBarSwitch.on ? @(CRToastTypeNavigationBar) : @(CRToastTypeStatusBar),
    //                                      kCRToastNotificationPresentationTypeKey   : self.slideOverSwitch.on ? @(CRToastPresentationTypeCover) : @(CRToastPresentationTypePush),
    //                                      kCRToastUnderStatusBarKey                 : @(self.slideUnderSwitch.on),
    //                                      kCRToastTextKey                           : self.txtNotificationMessage.text,
    //                                      kCRToastTextAlignmentKey                  : @(self.textAlignment),
    //                                      kCRToastTimeIntervalKey                   : @(self.sliderDuration.value),
    //                                      kCRToastAnimationInTypeKey                : @(CRToastAnimationTypeFromSegmentedControl(_inAnimationTypeSegmentedControl)),
    //                                      kCRToastAnimationOutTypeKey               : @(CRToastAnimationTypeFromSegmentedControl(_outAnimationTypeSegmentedControl)),
    //                                      kCRToastAnimationInDirectionKey           : @(self.segFromDirection.selectedSegmentIndex),
    //                                      kCRToastAnimationOutDirectionKey          : @(self.segToDirection.selectedSegmentIndex)} mutableCopy];
    //    options[kCRToastImageKey] = [UIImage imageNamed:@""];
    options[kCRToastBackgroundColorKey] = [UIColor whiteColor];
    options[kCRToastFontKey]=[UIFont systemFontOfSize:20];
    options[kCRToastTextColorKey]=[self getUIColorFromHexColor:@"e9550d" withAlphaValue:1];
    
    //    options[kCRToastSubtitleTextKey] = self.txtSubtitleMessage.text;
    //    options[kCRToastSubtitleTextAlignmentKey] = @(self.subtitleAlignment);
    
    options[kCRToastInteractionRespondersKey] = @[[CRToastInteractionResponder interactionResponderWithInteractionType:CRToastInteractionTypeTap
                                                                                                  automaticallyDismiss:YES
                                                                                                                 block:^(CRToastInteractionType interactionType){
                                                                                                                     NSLog(@"Dismissed with %@ interaction", NSStringFromCRToastInteractionType(interactionType));
                                                                                                                 }]];
    
    [CRToastManager showNotificationWithOptions:options
                                 apperanceBlock:^(void) {
                                     NSLog(@"Appeared");
                                 }
                                completionBlock:^(void) {
                                    NSLog(@"Completed");
                                }];
}


+ (void)showImagePereview:(UIImageView *)imageView viewController:(UIViewController *)viewController{
    JTSImageInfo *imageInfo = [[JTSImageInfo alloc] init];
    
    //imageInfo.imageURL = [NSURL URLWithString:imageUrl];
    //imageInfo.placeholderImage = _mediaImageView.image;
    
    imageInfo.image = imageView.image;
    imageInfo.referenceRect =imageView.frame;
    imageInfo.referenceView = imageView.superview;
    imageInfo.referenceContentMode = imageView.contentMode;
    imageInfo.referenceCornerRadius = imageView.layer.cornerRadius;
    
    
    // Setup view controller
    
    JTSImageViewController *imageViewer = [[JTSImageViewController alloc]
                                           initWithImageInfo:imageInfo
                                           mode:JTSImageViewControllerMode_Image
                                           backgroundStyle:JTSImageViewControllerBackgroundOption_Scaled];
    
    // Present the view controller.
    [imageViewer showFromViewController:viewController transition:JTSImageViewControllerTransition_FromOriginalPosition];
}

+(BOOL)isPaidUser{
    BOOL isPaid=NO;
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *applicationDictionary=[fileManager getApplicationSettingsData];
    if(applicationDictionary!=nil){
        if([applicationDictionary objectForKey:USER_STATUS]){
            NSString *userStatus=[applicationDictionary objectForKey:USER_STATUS];
            if(userStatus!=nil && [userStatus isEqualToString:USER_STATUS_PAID]){
                isPaid=YES;
            }
        }
    }
    
    return isPaid;
}

+ (void)applyCurrentTheme:(UIView *)view{
    
}

+(NSString *)getCurrentTheme{
    NSString *theme=THEME_DARK;
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    if(otherDetails!=nil){
        if([otherDetails objectForKey:THEME]){
            theme=[otherDetails objectForKey:THEME];
        }
    }
    return theme;
    
}

+ (UIColor *)getHeaderBackgroundColor{
    return [self getHeaderBackgroundColor:[self getCurrentTheme]];
}

+ (UIColor *)getHeaderBackgroundColor:(NSString *)theme{
    if([theme isEqualToString:THEME_LIGHT]){
        return [self getUIColorFromHexColor:@"2996cf" withAlphaValue:1];
    }else{
        return [self getUIColorFromHexColor:@"030f16" withAlphaValue:1];
    }
}

+ (UIColor *)getBackgroundColor{
    return [self getBackgroundColor:[self getCurrentTheme]];
}

+ (UIColor *)getBackgroundColor:(NSString *)theme{
    if([theme isEqualToString:THEME_LIGHT]){
        return [self getUIColorFromHexColor:@"ffffff" withAlphaValue:1];
    }else{
        return [self getUIColorFromHexColor:@"051822" withAlphaValue:1];
    }
}

+ (UIColor *)getMiddleTextColor{
    return [self getMiddleTextColor:[self getCurrentTheme]];
}

+ (UIColor *)getMiddleTextColor:(NSString *)theme{
    if([theme isEqualToString:THEME_LIGHT]){
        return [self getUIColorFromHexColor:@"000000" withAlphaValue:1];
    }else{
        return [self getUIColorFromHexColor:@"ffffff" withAlphaValue:1];
    }
}

+ (UIColor *)getBottomBackgroundColor{
    return [self getBottomBackgroundColor:[self getCurrentTheme]];
}

+ (UIColor *)getBottomBackgroundColor:(NSString *)theme{
    if([theme isEqualToString:THEME_LIGHT]){
        return [self getUIColorFromHexColor:@"2996cf" withAlphaValue:1];
    }else{
        return [self getUIColorFromHexColor:@"030f16" withAlphaValue:1];
    }
}

+ (UIColor *)getButtonBackgroundColor{
    return [self getButtonBackgroundColor:[self getCurrentTheme]];
    
}

+ (UIColor *)getButtonBackgroundColor:(NSString *)theme{
    if([theme isEqualToString:THEME_LIGHT]){
        return [self getUIColorFromHexColor:@"2996cf" withAlphaValue:1];
    }else{
        return [self getUIColorFromHexColor:@"07c4a8" withAlphaValue:1];
    }
}


+ (UIColor *)getStrokeTitleColor{
    return [self getStrokeTitleColor:[self getCurrentTheme]];
    
}

+ (UIColor *)getStrokeTitleColor:(NSString *)theme{
    if([theme isEqualToString:THEME_LIGHT]){
        return [self getUIColorFromHexColor:@"2996cf" withAlphaValue:1];
    }else{
        return [self getUIColorFromHexColor:@"ffffff" withAlphaValue:1];
    }
}

+(UIImage *)getImage:(UIImage *)img {
    return [self getImage:img theme:[self getCurrentTheme]];
}

+(UIImage *)getImage:(UIImage *)img theme:(NSString *)theme{
    UIColor *color;
    
    if([theme isEqualToString:THEME_LIGHT]){
        color=[self getUIColorFromHexColor:@"ffffff" withAlphaValue:1];
    }else{
        color=[self getUIColorFromHexColor:@"07c4a8" withAlphaValue:1];
    }
    return [img imageWithColor:color];
   // return [self getImage:img withColor:color];
}


+(UIImage *)getImage:(UIImage *)img color:(UIColor *)color{
    return [img imageWithColor:color];
    //return [self getImage:img withColor:color];
}

+ (void)updateUserPushToken{
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherSettingsDictionary=[fileManager getOtherSettingsData];
    NSString *userId=[Utils getCurrentUserId];
    NSString *deviceToken=[NSString stringWithFormat:@"%@",[otherSettingsDictionary objectForKey:DEVICE_TOKEN]];
    if(userId!=nil && ![userId isEqualToString:@""] && ![userId isEqualToString:@"(null)"] && deviceToken!=nil && ![deviceToken isEqualToString:@""] && ![deviceToken isEqualToString:@"(null)"]){
        [self updateuserPushToken:userId deviceToken:deviceToken];
    }
}

+ (void)updateuserPushToken:(NSString *)userId deviceToken:(NSString *)deviceToken{
    BOOL internetEnable=[Utils isInternetAvailable];
    if(internetEnable){
        RequestManager *requestManager = [[RequestManager alloc] init];
        //requestManager.delegate=self;
        requestManager.commandName=ACTION_UPDATE_DEVICE_TOKEN;
        
        NSString *url = [NSString stringWithFormat:@"%@?%@=%@",URL_PREFIX,REQUEST,ACTION_UPDATE_DEVICE_TOKEN];
        NSMutableDictionary *parametersDictionary = [[NSMutableDictionary alloc] init];
        
        [parametersDictionary setObject:[Utils getCurrentUserId] forKey:USER_IDD];
        [parametersDictionary setObject:[Utils getDeviceIdForDevice] forKey:DEVICE_ID];
        [parametersDictionary setObject:deviceToken forKey:DEVICE_TOKEN];
        
        [requestManager CallPostURL:url parameters:parametersDictionary];
    }else{
        //[Utils showNoInternetConnectionAlertDialog];
    }
}

+(NSMutableArray *)dictRetrieveFromUserDefaults:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *val = Nil;
    
    if (standardUserDefaults)
        val = [standardUserDefaults objectForKey:key];
    
    return val;
}

+(NSString *)stringRetrieveFromUserDefaults:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSString *val = @"";
    
    if (standardUserDefaults && [standardUserDefaults objectForKey:key] != Nil)
        val = [NSString stringWithFormat:@"%@",[standardUserDefaults objectForKey:key]];
    
    return val;
}

+(void)stringSaveToUserDefaults:(NSString *)myString withKey:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myString forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(void)dictSaveToUserDefaults:(NSMutableArray *)myArr withKey:(NSString *)key
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (standardUserDefaults) {
        [standardUserDefaults setObject:myArr forKey:key];
        [standardUserDefaults synchronize];
    }
}

+(NSDate *)dateFromString:(NSString *)strDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    if (strDate.length > 11) {
        //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    NSDate *date = [dateFormatter dateFromString:strDate];
    NSLog(@"dateFormater %@",date);
    return date;
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    // Returns a UIColor by scanning the string for a hex number and passing that to (UIColor *)colorWithRGBHex:(UInt32)hex
    // Skips any leading whitespace and ignores any trailing characters
    
    NSString *hexString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [Utils colorWithRGBHex:hexNum];
}
+ (NSString *)stringFromInterfaceOrientation:(UIInterfaceOrientation)orientation {
    switch (orientation) {
        case UIInterfaceOrientationPortrait:           return @"UIInterfaceOrientationPortrait";
        case UIInterfaceOrientationPortraitUpsideDown: return @"UIInterfaceOrientationPortraitUpsideDown";
        case UIInterfaceOrientationLandscapeLeft:      return @"UIInterfaceOrientationLandscapeLeft";
        case UIInterfaceOrientationLandscapeRight:     return @"UIInterfaceOrientationLandscapeRight";
    }
    return nil;
}

/*+ (BOOL)webViewShouldBePaged:(UIWebView*)webView forBook:(BakerBook *)book {
    BOOL shouldBePaged = NO;
    
    NSString *pagePagination = [webView stringByEvaluatingJavaScriptFromString:ISPAGED_JS_SNIPPET];
    if ([pagePagination length] > 0) {
        shouldBePaged = [pagePagination boolValue];
    } else {
        shouldBePaged = [book.bakerVerticalPagination boolValue];
    }
    //NSLog(@"[Utils] Current page Pagination Mode status = %d", shouldBePaged);
    
    return shouldBePaged;
}*/
+ (NSString *)appID {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSDate *)dateWithFormattedString:(NSString *)string {
    static NSDateFormatter *dateFormat = nil;
    if (dateFormat == nil) {
        dateFormat = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        [dateFormat setLocale:enUSPOSIXLocale];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormat setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    }
    return [dateFormat dateFromString:string];
}

+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:buttonTitle
                                          otherButtonTitles:nil];
    [alert show];
    //    [alert release];
}

+ (void)webView:(UIWebView *)webView dispatchHTMLEvent:(NSString *)event {
    [Utils webView:webView dispatchHTMLEvent:event withParams:[NSDictionary dictionary]];
}
+ (void)webView:(UIWebView *)webView dispatchHTMLEvent:(NSString *)event withParams:(NSDictionary *)params {
    __block NSMutableString *jsDispatchEvent = [NSMutableString stringWithFormat:
                                                @"var bakerDispatchedEvent = document.createEvent('Events');\
                                                bakerDispatchedEvent.initEvent('%@', false, false);", event];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *jsParamSet = [NSString stringWithFormat:@"bakerDispatchedEvent.%@='%@';\n", key, obj];
        [jsDispatchEvent appendString:jsParamSet];
    }];
    [jsDispatchEvent appendString:@"window.dispatchEvent(bakerDispatchedEvent);"];
    
    [webView stringByEvaluatingJavaScriptFromString:jsDispatchEvent];
}

+ (void)setImage:(NSString *)imageUrl imageView:(UIImageView *)imageView{
    if(imageUrl!=nil && ![imageUrl isEqualToString:@""]){
        //        categoryImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
        [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"placehoder_image.png"] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }else{
        imageView.image=[UIImage imageNamed:@"placehoder_image.png"];
    }
}

+ (BOOL) validateInputLatitude: (NSString *) latitude
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *latitude1 = [numberFormatter numberFromString:latitude];
    
    if (latitude1 != nil)
        
    {
        //check it is within lat/long range
        
        if ((latitude1.floatValue > -90.0) && (latitude1.floatValue < 90.0)) {
            
            NSLog(@"Hello Latitude!!!");
            
            return 1;
        }
        
    } else {
        
        //not even a valid number, reject it
        
        return 0;
        
    }
    
    return 0;
    
}


+ (BOOL) validateInputLongitude: (NSString *) longitude
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *longitude1 = [numberFormatter numberFromString:longitude];
    
    if (longitude1 != nil)
        
    {
        //check it is within lat/long range
        
        if ((longitude1.floatValue > -180.0) && (longitude1.floatValue < 180.0)) {
            
            NSLog(@"Hello Longitude!!!");
            
            return 1;
        }
        
    } else {
        
        //not even a valid number, reject it
        
        return 0;
        
    }
    
    return 0;
    
}

@end
