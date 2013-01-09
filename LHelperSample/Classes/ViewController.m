#import "ViewController.h"
#import "LHelper.h"


@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [_label1 adjustWidthWithMaxWidth:9999];
    [_label1 adjustHeightWithMaxHeight:9999];
    [_label2 adjustWidthWithMaxWidth:9999];
    [_label2 adjustHeightWithMaxHeight:9999];
        
    _label1.maxX = _label2.midX;
}


@end