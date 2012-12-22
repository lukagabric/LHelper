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
    
    [_label2 placeCenterAndRightFromView:_label1 withPadding:10];
    
    _imageView.image = [self.view getImage];
}


@end