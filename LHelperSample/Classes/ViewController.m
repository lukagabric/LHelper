#import "ViewController.h"
#import "LHelper.h"


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_label1 adjustHeightToFit];
    [_label1 adjustWidthToFit];
    [_label2 adjustHeightToFit];
    [_label2 adjustWidthToFit];
    
    _label2.y = _label1.maxY;
    _label2.x = _label1.midX;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //alert
    [UIAlertView showAlertWithTitle:@"title" message:@"message" okButtonTitle:@"OK!" okActionBlock:^{
        Print(@"OK ACTION BLOCK");
    }];
    
    //base64
    NSString *username = @"username";
    NSString *password = @"password";

    NSString *originalString = [NSString stringWithFormat:@"%@:%@", username, password];
    NSString *encodedString = [[originalString dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
    
    Print(encodedString);
    
    NSData *decodedData = [encodedString dataFromBase64String];
    NSString *decodedString = [decodedData stringUsingEncoding:NSUTF8StringEncoding];
    
    Print(decodedString);
}


@end