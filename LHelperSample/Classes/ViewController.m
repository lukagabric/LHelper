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


@end