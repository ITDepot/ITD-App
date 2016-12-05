
#import "FileManager.h"

@implementation FileManager


- (void) initializeFileSystem {
    [self createApplicationSettingsPListFile];
    [self createDatabaseMetaDataPlistFile];
    [self createOtherSettingsPlistFile];
}


-(void)createFoldersForStoringImages{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *profilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",PROFILES_PATH]];
    [fileManager createDirectoryAtPath:profilePath withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *originalImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",PROFILES_PATH,ORIGINALS_PATH]];
    [fileManager createDirectoryAtPath:originalImagePath withIntermediateDirectories:NO attributes:nil error:&error];
    
    //    NSString *thumbnailImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",PROFILES_PATH,THUMBNAILS_PATH]];
    //    [fileManager createDirectoryAtPath:thumbnailImagePath withIntermediateDirectories:NO attributes:nil error:&error];
}

- (void) createApplicationSettingsPListFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPath = [documentsDirectory stringByAppendingPathComponent:PLIST_FILE_APPLICATION_SETTINGS];
	NSFileManager *fileManger = [NSFileManager defaultManager];
	if (![fileManger fileExistsAtPath:myPath]) {
        [fileManger createFileAtPath:myPath contents:nil attributes:nil];
        [self initializeApplicationSettingsPListFile];
	}
}

- (void) initializeApplicationSettingsPListFile{
    NSMutableDictionary *writeApplicationSettingsData = [[NSMutableDictionary alloc] init];
    //    NSTimeInterval now=[[NSDate date] timeIntervalSince1970];
    //    long currentTime=now;
    //    long expiredTime=currentTime+(60*60*24*20);
    //    [writeApplicationSettingsData setObject:[NSString stringWithFormat:@"%ld",currentTime] forKey:CURRENT_TIME];
    //    [writeApplicationSettingsData setObject:[NSString stringWithFormat:@"%ld",expiredTime] forKey:EXPIRED_TIME];
    
    [writeApplicationSettingsData setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey] forKey:APPLICATION_VERSION];
    [writeApplicationSettingsData setObject:USER_STATUS_FREE forKey:USER_STATUS];
    [writeApplicationSettingsData setObject:APPLICATION_USAGE_NEW forKey:APPLICATION_USAGE];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_APPLICATION_SETTINGS];
    [writeApplicationSettingsData writeToFile:path atomically:YES];
}


- (void) writeApplicationSettingsData:(NSMutableDictionary *)applicationSettingsDataDictionary{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_APPLICATION_SETTINGS];
    [applicationSettingsDataDictionary writeToFile:path atomically:YES];
}


- (NSMutableDictionary *) getApplicationSettingsData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_APPLICATION_SETTINGS];
	NSMutableDictionary *applicationSettingsDictionary = [NSMutableDictionary dictionaryWithContentsOfFile: path];
    if (applicationSettingsDictionary!=nil){
        return applicationSettingsDictionary;
    }
    return nil;
}


- (void) createDatabaseMetaDataPlistFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPath = [documentsDirectory stringByAppendingPathComponent:PLIST_FILE_DATABASE_METADATA];
	NSFileManager *fileManger = [NSFileManager defaultManager];
	if (![fileManger fileExistsAtPath:myPath]) {
        [fileManger createFileAtPath:myPath contents:nil attributes:nil];
        [self initializeSQLMetaDataPListFile];
	}
}



- (void) initializeSQLMetaDataPListFile {
    NSMutableDictionary *writeApplicationSettingsData = [[NSMutableDictionary alloc] init];
    [writeApplicationSettingsData setObject:@"4" forKey:TABLE_WEATHER];
    [writeApplicationSettingsData setObject:@"0" forKey:TABLE_ALARMS];
    [writeApplicationSettingsData setObject:@"0" forKey:TABLE_EVENTS];
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_DATABASE_METADATA];
    [writeApplicationSettingsData writeToFile:path atomically:YES];
}



-(void)writeDataBaseMetaData:(NSMutableDictionary *)dbMetaDataDictionary{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_DATABASE_METADATA];
    [dbMetaDataDictionary writeToFile:path atomically:YES];
}


- (NSMutableDictionary *) getDBSettingsMetaData {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_DATABASE_METADATA];
	NSMutableDictionary *dbMetaDataSettingsDictionary = [NSMutableDictionary dictionaryWithContentsOfFile: path];
    if (dbMetaDataSettingsDictionary!=nil){
        return dbMetaDataSettingsDictionary;
    }
    return nil;
}


- (void) createOtherSettingsPlistFile{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myPath = [documentsDirectory stringByAppendingPathComponent:PLIST_FILE_OTHER_SETTINGS];
	NSFileManager *fileManger = [NSFileManager defaultManager];
	if (![fileManger fileExistsAtPath:myPath]) {
        [fileManger createFileAtPath:myPath contents:nil attributes:nil];
        [self initializeOtherSettingsPListFile];
	}
}


- (void) initializeOtherSettingsPListFile{
    NSMutableDictionary *writeApplicationSettingsData = [[NSMutableDictionary alloc] init];
    
    [writeApplicationSettingsData setObject:THEME_DARK forKey:THEME];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_OTHER_SETTINGS];
    [writeApplicationSettingsData writeToFile:path atomically:YES];
}


- (void) writeOtherSettingsData:(NSMutableDictionary *)goneAlarmsDataDictionary{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_OTHER_SETTINGS];
    [goneAlarmsDataDictionary writeToFile:path atomically:YES];
}

- (NSMutableDictionary *) getOtherSettingsData{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:PLIST_FILE_OTHER_SETTINGS];
	NSMutableDictionary *goneAlarmsDictionary = [NSMutableDictionary dictionaryWithContentsOfFile: path];
    if (goneAlarmsDictionary!=nil){
        return goneAlarmsDictionary;
    }
    return nil;
}


@end
