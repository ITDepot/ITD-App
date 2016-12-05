

#import "MySidePanelControllerr.h"
#import "FileManager.h"
#import "Utils.h"

@interface MySidePanelControllerr ()

@end

@implementation MySidePanelControllerr

-(void)awakeFromNib{
    
    self.navigationController.navigationBarHidden=YES;
    
    FileManager *fileManager=[[FileManager alloc]init];
    NSMutableDictionary *otherDetails=[fileManager getOtherSettingsData];
    
//    if ([[otherDetails objectForKey:INITIAL_CREDITCARD_SCREEN_SHOWN] isEqualToString:@"0"]) {
//        [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"MenuScreen"]];
//        [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"]];
//        [self setLeftFixedWidth:274];
//        
//    }else{
//        [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"MenuScreen"]];
//        [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginScreen"]];
//        [self setLeftFixedWidth:274];
//    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewwillappearrr2");
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"viewWillDisappearrrr2");
    [super viewWillDisappear:animated];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_SHOW_APPOINTMENT_SCREEN object:nil];
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTIFICATION_GREETINGS object:nil];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
