

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "MBProgressHUD.h"
//#import "BakerBook.h"

#define SYSTEM_VERSION_EQUAL_TO(version)                  ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(version)              ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version)  ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(version)                 ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version)     ([[[UIDevice currentDevice] systemVersion] compare:version options:NSNumericSearch] != NSOrderedDescending)

@interface Utils : NSObject<MBProgressHUDDelegate>

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (NSString *)stringFromInterfaceOrientation:(UIInterfaceOrientation)orientation;
//+ (BOOL)webViewShouldBePaged:(UIWebView*)webView forBook:(BakerBook *)book;
+ (NSString *)appID;
+ (NSDate *)dateWithFormattedString:(NSString *)string;
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitle:(NSString *)buttonTitle;
+ (void)webView:(UIWebView *)webView dispatchHTMLEvent:(NSString *)event;
+ (void)webView:(UIWebView *)webView dispatchHTMLEvent:(NSString *)event withParams:(NSDictionary *)params;

+ (UIColor *) getUIColorFromHexColor: (NSString *) hexColor withAlphaValue: (float) alphaValue;
- (UIColor *) getUIColorFromHexColor: (NSString *) hexColor withAlphaValue: (float) alphaValue;

- (UIColor *) getUIColorFromRGBColor: (NSArray *) rgbColor withAlphaValue: (float) alphaValue;
- (NSString *) getHexColorFromUIColor:(UIColor *)color;
- (NSMutableArray *) getRGBColorArrayFromHexColor: (NSString *) hexColor withAlphaValue: (float) alphaValue;

//- (UIFont *) getFontForTypeSemiBoldWithSize: (NSInteger)fontSize;
//- (UIFont *) getFontForTypeLightWithSize: (NSInteger)fontSize;
//- (UIFont *) getFontForTypeMediumWithSize: (NSInteger)fontSize;

+ (UIFont *) getNexaBoldFontWithSize: (NSInteger)fontSize;
+ (UIFont *) getNexaLightFontWithSize: (NSInteger)fontSize;

- (UIFont *) getFuturaBoldFontWithSize: (NSInteger)fontSize;
- (UIFont *) getFuturaCondensedWithSize: (NSInteger)fontSize;
- (UIFont *) getFuturaCondensedLightWithSize: (NSInteger)fontSize;

+ (UIFont *) getFuturaBoldFontWithSize: (NSInteger)fontSize;
+ (UIFont *) getFuturaCondensedWithSize: (NSInteger)fontSize;
+ (UIFont *) getFuturaCondensedLightWithSize: (NSInteger)fontSize;


- (NSString *) getSystemVersionOfIphone;

- (NSString *)getCurrentDateTime;
- (NSString *)getDateAsUniqueId;
- (NSString *)getDateAsUniqueId:(NSString *)prefix;
- (NSString *)getTimeSpanToHoursAndMinutesForSeconds:(NSInteger)secondsInterval;
- (NSString *)getTimeSpanToMinutesForHours:(NSString *)hours AndMinutes:(NSString *)minutes;
- (NSInteger)getTimeSpanBetweenDateOne:(NSString *)dateOne AndDateTwo:(NSString *)dateTwo;

-(NSDate *) getGlobalTimeAsDateFromDate:(NSString *)date andWithFormat:(NSDateFormatter *)dateFormatter;
-(NSString *) getGlobalTimeAsStringFromDate:(NSDate *)date andWithFormat:(NSDateFormatter *)dateFormatter;
-(NSDate *) getLocalTimeAsDateFromDate:(NSString *)date andWithFormat:(NSDateFormatter *)dateFormatter;
-(NSString *) getLocalTimeAsStringFromDate:(NSDate *)date andWithFormat:(NSDateFormatter *)dateFormatter;
-(NSString *) getDateAsTimeIntervalInSeconds;

- (NSString *)getSameStringAsDate:(NSDate *)itemDate;
- (NSString *)getSameStringAsDate:(NSDate *)itemDate havingDateFormatter:(NSDateFormatter *)dateFormatter;

- (NSString *)getGMTStringAsDate:(NSDate *)itemDate;
- (NSString *)getGMTStringAsDate:(NSDate *)itemDate havingDateFormatter:(NSDateFormatter *)dateFormatter;

- (NSDate *)getSameDateAsString:(NSString *)itemString;
- (NSDate *)getSameDateAsString:(NSString *)itemString havingDateFormatter:(NSDateFormatter *)dateFormatter;

- (NSDate *)getGMTDateAsString:(NSString *)itemString;
- (NSDate *)getGMTDateAsString:(NSString *)itemString havingDateFormatter:(NSDateFormatter *)dateFormatter;

+(NSDate *) getGlobalTimeAsDateFromDate:(NSString *)date andWithFormat:(NSDateFormatter *)dateFormatter;
+(NSString *) getGlobalTimeAsStringFromDate:(NSDate *)date andWithFormat:(NSDateFormatter *)dateFormatter;
+(NSDate *) getLocalTimeAsDateFromDate:(NSString *)date andWithFormat:(NSDateFormatter *)dateFormatter;
+(NSString *) getLocalTimeAsStringFromDate:(NSDate *)date andWithFormat:(NSDateFormatter *)dateFormatter;

+ (NSString *)getSameStringAsDate:(NSDate *)itemDate;
+ (NSString *)getSameStringAsDate:(NSDate *)itemDate havingDateFormatter:(NSDateFormatter *)dateFormatter;

+ (NSString *)getGMTStringAsDate:(NSDate *)itemDate;
+ (NSString *)getGMTStringAsDate:(NSDate *)itemDate havingDateFormatter:(NSDateFormatter *)dateFormatter;

+ (NSDate *)getSameDateAsString:(NSString *)itemString;
+ (NSDate *)getSameDateAsString:(NSString *)itemString havingDateFormatter:(NSDateFormatter *)dateFormatter;

+ (NSDate *)getGMTDateAsString:(NSString *)itemString;
+ (NSDate *)getGMTDateAsString:(NSString *)itemString havingDateFormatter:(NSDateFormatter *)dateFormatter;

+ (void)updateUserPushToken;
+ (void)updateuserPushToken:(NSString *)userId deviceToken:(NSString *)deviceToken;

+ (NSString *)getDeviceIdForDevice;
- (NSString *)getPhoneModel;
- (NSString *)urlEncode:(NSString *)value;

- (NSString *)getOperatingSystemVersion;
- (NSString *)getApplicationVersion;
- (NSString *)getApplicationClient;
- (NSString *)getCountryCode;
- (NSString *)getGMTOffset;
- (NSString *)getTimeZone;

- (NSString *) addSuffixToNumber:(int) number;

+ (void)setLocalizedValuesforView:(UIView*)view andSubViews:(BOOL)isSubViews;
+ (NSString *)getLocalizdString:(NSString *)value;
+ (NSString *)getLocalizdImageName:(NSString *)value;

+ (void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews;
+ (void)setFontFamily:(NSString*)fontFamily forView:(UIView*)view andSubViews:(BOOL)isSubViews leftPadding:(int)leftPadding rightPadding:(int)rightPadding;

+ (BOOL)isInternetAvailable;
+ (void)showAlertMessage:(NSString *)alertMesasge;
+ (void)showNoInternetConnectionAlertDialog;
+ (void)showSomethingWentWrongAlertDialog;
+ (void)showToastMessage:(NSString *)toastMesasge;
+ (void)showToastMessageBottom:(NSString *)toastMesasge;

+ (UIImage *)imageWithColor:(UIColor *)color;


+ (void)showIndicator:(NSString *)message withDelegate:(id)delagate;
+ (void)showIndicatorwithDelegate:(id)delagate;
+ (void)hideIndicator;

+ (NSString *)getCurrentUserId;
+ (NSString *)getCurrentChatUserId;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColorString:(NSString *)colorString;

+ (BOOL)isUserAlreadyloggedIn;
+(NSDictionary *)parseResults:(NSString *)result;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (NSString *)convertTimeInAmPmFormat:(NSString *)time;
+ (NSString *)convertTimeIn24HoursFormat:(NSString *)time;

+ (void)showView:(UIView *)view;
+ (void)hideView:(UIView *)view;

+ (NSString *)getProfileImagesPath;
+ (void)showUserNotLoggedInAlertMessage;
+(NSData *)getCompressedImageData:(UIImage *)originalImage;

+ (void)showToastNotificationAtTop:(NSString *)message;
+ (void)showToastNotificationAtTop:(NSString *)message withDuration:(float)duration;

+ (void)showImagePereview:(UIImageView *)imageView viewController:(UIViewController *)viewController;

+(BOOL)isPaidUser;
+ (void)applyCurrentTheme:(UIView *)view;

+(NSString *)getCurrentTheme;
+ (UIColor *)getHeaderBackgroundColor;
+ (UIColor *)getHeaderBackgroundColor:(NSString *)theme;
+ (UIColor *)getBackgroundColor;
+ (UIColor *)getBackgroundColor:(NSString *)theme;
+ (UIColor *)getMiddleTextColor;
+ (UIColor *)getMiddleTextColor:(NSString *)theme;
+ (UIColor *)getBottomBackgroundColor;
+ (UIColor *)getBottomBackgroundColor:(NSString *)theme;
+ (UIColor *)getButtonBackgroundColor;
+ (UIColor *)getButtonBackgroundColor:(NSString *)theme;
+ (UIColor *)getStrokeTitleColor;
+ (UIColor *)getStrokeTitleColor:(NSString *)theme;

+(UIImage *)getImage:(UIImage *)img;
+(UIImage *)getImage:(UIImage *)img theme:(NSString *)theme;
+(UIImage *)getImage:(UIImage *)img color:(UIColor *)color;

+(NSMutableArray *)dictRetrieveFromUserDefaults:(NSString *)key;
+(NSString *)stringRetrieveFromUserDefaults:(NSString *)key;
+(void)stringSaveToUserDefaults:(NSString *)myString withKey:(NSString *)key;
+(void)dictSaveToUserDefaults:(NSMutableArray *)myArr withKey:(NSString *)key;
+(NSDate *)dateFromString:(NSString *)strDate;
+ (NSString *)getLocalizdString:(NSString *)value language:(NSString *)language;


+ (void)setImage:(NSString *)imageUrl imageView:(UIImageView *)imageView;
+ (BOOL) validateInputLatitude: (NSString *) latitude;
+ (BOOL) validateInputLongitude: (NSString *) longitude;

@end