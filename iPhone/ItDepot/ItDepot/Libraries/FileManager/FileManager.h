
#import <Foundation/Foundation.h>
#import "Constants.h"

@interface FileManager : NSObject {
    
}

- (void) initializeFileSystem;


- (void) createApplicationSettingsPListFile;
- (void) initializeApplicationSettingsPListFile;
- (NSMutableDictionary *) getApplicationSettingsData;
- (void) writeApplicationSettingsData:(NSMutableDictionary *)applicationSettingsDataDictionary;

- (void) createDatabaseMetaDataPlistFile;
- (void) initializeSQLMetaDataPListFile;
- (NSMutableDictionary *) getDBSettingsMetaData;
- (void) writeDataBaseMetaData:(NSMutableDictionary *)dbMetaDataDictionary;

- (void) createOtherSettingsPlistFile;
- (void) initializeOtherSettingsPListFile;
- (void) writeOtherSettingsData:(NSMutableDictionary *)goneAlarmsDataDictionary;
- (NSMutableDictionary *) getOtherSettingsData;


@end

