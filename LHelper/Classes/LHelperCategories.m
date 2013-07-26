#import "LHelperCategories.h"
#import "LHelper.h"
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>


#pragma mark -
#pragma mark - Categories
#pragma mark -


#pragma mark - UIViewController


@implementation UIViewController (UIViewController_LHelperCategories)


- (BOOL)isModal
{
	BOOL isModal = ((self.parentViewController && self.parentViewController.modalViewController == self) ||
					//or if I have a navigation controller, check if its parent modal view controller is self navigation controller
					( self.navigationController && self.navigationController.parentViewController && self.navigationController.parentViewController.modalViewController == self.navigationController) ||
					//or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
					[[[self tabBarController] parentViewController] isKindOfClass:[UITabBarController class]]);
    
    //iOS 5+
    if (!isModal && [self respondsToSelector:@selector(presentingViewController)]) {
        
        isModal = ((self.presentingViewController && self.presentingViewController.modalViewController == self) ||
				   //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
				   (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.modalViewController == self.navigationController) ||
				   //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
				   [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
        
    }
    
    return isModal;
    
}


- (void)autorotate
{
	UIViewController *c = [[UIViewController alloc]init];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0"))
    {
        [self presentViewController:c animated:NO completion:nil];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
    else
    {
        [self presentModalViewController:c animated:NO];
        [self dismissModalViewControllerAnimated:NO];
    }
}


@end


#pragma mark - UIView


@implementation UIView (UIView_LHelperCategories)


- (void)ceilFrame
{
    self.frame = CGRectMake(ceil(self.frame.origin.x), ceil(self.frame.origin.y), ceil(self.frame.size.width), ceil(self.frame.size.height));
}


- (UIImage *)getImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}


- (UIViewController *)viewController
{
    Class vcc = [UIViewController class];
    
    UIResponder *responder = self;
    
    while (responder)
    {
        responder = [responder nextResponder];
        if ([responder isKindOfClass:vcc])
            return (UIViewController *)responder;
    }
    
    return nil;
}


- (void)placeBelowView:(UIView *)fixedView withPadding:(CGFloat)padding
{
	CGRect addViewFrame = self.frame;
	addViewFrame.origin.y = CGRectGetMaxY(fixedView.frame) + padding;
	self.frame = addViewFrame;
}


- (void)placeCenterAndBelowView:(UIView *)fixedView withPadding:(CGFloat)padding
{
	self.center = fixedView.center;
    
	CGRect addViewFrame = self.frame;
	addViewFrame.origin.y = CGRectGetMaxY(fixedView.frame) + padding;
	self.frame = addViewFrame;
}


- (void)placeRightFromView:(UIView *)fixedView withPadding:(CGFloat)padding
{
	CGRect addViewFrame = self.frame;
	addViewFrame.origin.x = CGRectGetMaxX(fixedView.frame) + padding;
	self.frame = addViewFrame;
}


- (void)placeCenterAndRightFromView:(UIView *)fixedView withPadding:(CGFloat)padding
{
	self.center = fixedView.center;
    
	CGRect addViewFrame = self.frame;
	addViewFrame.origin.x = CGRectGetMaxX(fixedView.frame) + padding;
	self.frame = addViewFrame;
}


- (void)setWidth:(CGFloat)width andHeight:(CGFloat)height
{
	CGRect frame = self.frame;
	frame.size = CGSizeMake(width, height);
	self.frame = frame;
}


- (void)setX:(CGFloat)x andY:(CGFloat)y
{
	CGRect frame = self.frame;
	frame.origin = CGPointMake(x, y);
	self.frame = frame;
}


- (CGFloat)left
{
    return self.frame.origin.x;
}


- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)top
{
    return self.frame.origin.y;
}


- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)x
{
    return self.frame.origin.x;
}


- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)y
{
    return self.frame.origin.y;
}


- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)width
{
    return self.frame.size.width;
}


- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height
{
    return self.frame.size.height;
}


- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


- (CGFloat)midX
{
    return CGRectGetMidX(self.frame);
}


- (void)setMidX:(CGFloat)midX
{
    CGRect frame = self.frame;
    frame.origin.x = midX - frame.size.width/2;
    self.frame = frame;
}


- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}


- (void)setMaxX:(CGFloat)maxX
{
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}


- (CGFloat)midY
{
    return CGRectGetMidY(self.frame);
}


- (void)setMidY:(CGFloat)midY
{
    CGRect frame = self.frame;
    frame.origin.y = midY - frame.size.height/2;
    self.frame = frame;
}


- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}


- (void)setMaxY:(CGFloat)maxY
{
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}


- (CGPoint)origin
{
    return self.frame.origin;
}


- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)size
{
    return self.frame.size;
}


- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (CGPoint)topLeft
{
    return CGPointMake(self.left, self.top);
}


- (void)setTopLeft:(CGPoint)topLeft
{
    self.top = topLeft.y;
    self.left = topLeft.x;
}


- (CGPoint)bottomLeft
{
    return CGPointMake(self.left, self.bottom);
}


- (void)setBottomLeft:(CGPoint)bottomLeft
{
    self.bottom = bottomLeft.y;
    self.left = bottomLeft.x;
}


- (CGPoint)topRight
{
    return CGPointMake(self.right, self.top);
}


- (void)setTopRight:(CGPoint)topRight
{
    self.top = topRight.y;
    self.right = topRight.x;
}


- (CGPoint)bottomRight
{
    return CGPointMake(self.right, self.bottom);
}


- (void)setBottomRight:(CGPoint)bottomRight
{
    self.bottom = bottomRight.y;
    self.right = bottomRight.x;
}


@end


#pragma mark - NSObject


@implementation NSObject (NSObject_LHelperCategories)


static UINib *__nib;
static NSString *__nibName;


+ (id)getFromNibNamed:(NSString *)nibName
{
    if (![nibName isEqualToString:__nibName])
    {
        __nibName = nibName;
        __nib = [UINib nibWithNibName:nibName bundle:nil];
    }
    
    return [__nib instantiateWithOwner:nil options:nil][0];
}


+ (id)getFromNib
{
    return [self getFromNibNamed:NSStringFromClass(self)];
}


@end


#pragma mark - UILabel


@implementation UILabel (UILabel_LHelperCategories)


- (void)decreaseHeight
{
    CGRect frame;
    frame = self.frame;
    CGFloat heightThatFits = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:self.lineBreakMode].height;
    frame.size.height = MIN(heightThatFits, self.frame.size.height);
    self.frame = frame;
}


- (void)decreaseWidth
{
    CGRect frame;
    frame = self.frame;
    CGFloat widthThatFits = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:self.lineBreakMode].width;
    frame.size.width = MIN(widthThatFits, self.frame.size.width);
    self.frame = frame;
}


- (void)adjustHeightWithMaxHeight:(CGFloat)maxHeight
{
    CGRect frame;
    frame = self.frame;
    CGFloat heightThatFits = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:self.lineBreakMode].height;
    frame.size.height = MIN(heightThatFits, maxHeight);
    self.frame = frame;
}


- (void)adjustWidthWithMaxWidth:(CGFloat)maxWidth
{
    CGRect frame;
    frame = self.frame;
    CGFloat widthThatFits = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:self.lineBreakMode].width;
    frame.size.width = MIN(widthThatFits, maxWidth);
    self.frame = frame;
}


- (void)adjustHeightToFit
{
    [self adjustHeightWithMaxHeight:MAXFLOAT];
}


- (void)adjustWidthToFit
{
    [self adjustWidthWithMaxWidth:MAXFLOAT];
}


@end


#pragma mark - NSArray


@implementation NSArray (NSArray_LHelperCategories)


- (NSArray *)randomisedArray
{
    NSMutableArray *randomised = [NSMutableArray arrayWithCapacity:[self count]];
    
    for (id object in self)
    {
        NSUInteger index = randomInRange(0, [randomised count]);
        [randomised insertObject:object atIndex:index];
    }
    
    return randomised;
}


- (id)randomObject
{
    return [self objectAtIndex:randomInRange(0, [self count] - 1)];
}


- (void)logItems
{
    for (id item in self) Print(item);
}


@end


#pragma mark - NSDictionary


@implementation NSDictionary (NSDictionary_LHelperCategories)


- (NSString *)queryString
{
    if ([self count] == 0) return nil;
    
    NSMutableString *query = [NSMutableString string];
    
    for (NSString *parameter in [self allKeys])
        [query appendFormat:@"&%@=%@", [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], [[self valueForKey:parameter] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    return [NSString stringWithFormat:@"%@", [query substringFromIndex:1]];
}


@end


#pragma mark - NSDate


@implementation NSDate (NSDate_LHelperCategories)


- (NSDate *)dateToBeginningOfDay
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:0];
    [parts setMinute:0];
    [parts setSecond:0];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}


- (NSDate *)dateToEndOfDay
{
    unsigned int flags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents* parts = [[NSCalendar currentCalendar] components:flags fromDate:self];
    [parts setHour:23];
    [parts setMinute:59];
    [parts setSecond:59];
    return [[NSCalendar currentCalendar] dateFromComponents:parts];
}


- (BOOL)beforeDate:(NSDate *)date
{
    return [self compare:date] == NSOrderedAscending;
}


- (BOOL)beforeOrEqualToDate:(NSDate *)date
{
    return [self compare:date] != NSOrderedDescending;
}


- (BOOL)afterDate:(NSDate *)date
{
    return [self compare:date] == NSOrderedDescending;
}


- (BOOL)afterOrEqualToDate:(NSDate *)date
{
    return [self compare:date] != NSOrderedAscending;
}


- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:self];
}


@end


#pragma mark - UIImage


@implementation UIImage (UIImage_LHelperCategories)


- (UIImage *)imageWithFixedOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:(CGRect){0, 0, self.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}


@end


#pragma mark - NSString


@implementation NSString (NSString_LHelperCategories)


- (NSDate *)dateWithFormat:(NSString *)format
{
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	dateFormatter.dateFormat = format;
	return [dateFormatter dateFromString:self];
}


- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end


#pragma mark - NSData


@implementation NSData (NSData_LHelperCategories)


- (NSString *)stringUsingEncoding:(NSStringEncoding)encoding
{
    return [[NSString alloc] initWithData:self encoding:encoding];
}


- (NSString *)md5
{
    unsigned char result[16];
    CC_MD5(self.bytes, self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end


#pragma mark - UIAlertView


@implementation UIAlertView (UIAlertView_LHelperCategories)


static char LDISMISS_IDENTIFER;
static char LCANCEL_IDENTIFER;


@dynamic cancelBlock;
@dynamic dismissBlock;


- (void)setDismissBlock:(LDismissBlock)dismissBlock
{
    objc_setAssociatedObject(self, &LDISMISS_IDENTIFER, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LDismissBlock)dismissBlock
{
    return objc_getAssociatedObject(self, &LDISMISS_IDENTIFER);
}

- (void)setCancelBlock:(LCancelBlock)cancelBlock
{
    objc_setAssociatedObject(self, &LCANCEL_IDENTIFER, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LCancelBlock)cancelBlock
{
    return objc_getAssociatedObject(self, &LCANCEL_IDENTIFER);
}


+ (UIAlertView *)alertViewWithTitle:(NSString *)title
                            message:(NSString *)message
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                  otherButtonTitles:(NSArray *)otherButtons
                          onDismiss:(LDismissBlock)dismissed
                           onCancel:(LCancelBlock)cancelled
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:[self class]
                                          cancelButtonTitle:cancelButtonTitle
                                          otherButtonTitles:nil];
    
    [alert setDismissBlock:dismissed];
    [alert setCancelBlock:cancelled];
    
    for (NSString *buttonTitle in otherButtons)
        [alert addButtonWithTitle:buttonTitle];
    
    [alert show];
    
    return alert;
}


+ (void)showAlertWithMessage:(NSString *)message okButtonTitle:(NSString *)okTitle
{
    [self showAlertWithTitle:nil message:message okButtonTitle:okTitle okActionBlock:nil cancelButtonTitle:nil andCancelBlock:nil];

}


+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle
{
    [self showAlertWithTitle:title message:message okButtonTitle:okTitle okActionBlock:nil cancelButtonTitle:nil andCancelBlock:nil];
}


+ (void)showAlertWithMessage:(NSString *)message okButtonTitle:(NSString *)okTitle okActionBlock:(void(^)(void))okBlock
{
    [self showAlertWithTitle:nil message:message okButtonTitle:okTitle okActionBlock:okBlock cancelButtonTitle:nil andCancelBlock:nil];
}


+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okActionBlock:(void(^)(void))okBlock
{
    [self showAlertWithTitle:title message:message okButtonTitle:okTitle okActionBlock:okBlock cancelButtonTitle:nil andCancelBlock:nil];
}


+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okTitle okActionBlock:(void(^)(void))okBlock cancelButtonTitle:(NSString *)cancelTitle andCancelBlock:(void(^)(void))cancelBlock
{
    [[self alertViewWithTitle:title
                      message:message
            cancelButtonTitle:nil
            otherButtonTitles:cancelTitle ? @[okTitle, cancelTitle] : @[okTitle]
                    onDismiss:^(int buttonIndex) {
                        if (buttonIndex == -1 && okBlock != nil)
                            okBlock();
                        else if (buttonIndex == 0 && cancelBlock != nil)
                            cancelBlock();
                    }
                     onCancel:nil] show];
}


@end


#pragma mark -


#pragma mark -
#pragma mark - End Of Categories
#pragma mark -


#pragma mark -