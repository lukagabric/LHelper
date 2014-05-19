//
//  Created by Luka Gabrić.
//  Copyright (c) 2013 Luka Gabrić. All rights reserved.
//


#import "LHelperCategories.h"
#import "LHelper.h"
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <objc/runtime.h>


#pragma mark -
#pragma mark - Categories
#pragma mark -


#pragma mark - UIViewController


@implementation UIViewController (UIViewController_LHelperCategories)


- (BOOL)isModal
{
    BOOL isModal = ((self.presentingViewController && self.presentingViewController.presentedViewController == self) ||
                    //or if I have a navigation controller, check if its parent modal view controller is self navigation controller
                    (self.navigationController && self.navigationController.presentingViewController && self.navigationController.presentingViewController.presentedViewController == self.navigationController) ||
                    //or if the parent of my UITabBarController is also a UITabBarController class, then there is no way to do that, except by using a modal presentation
                    [[[self tabBarController] presentingViewController] isKindOfClass:[UITabBarController class]]);
    
    return isModal;
}


- (void)autorotate
{
	UIViewController *c = [[UIViewController alloc]init];
    
    [self presentViewController:c animated:NO completion:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
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


- (NSLayoutConstraint *)addTopConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:fromView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.0
                                                                   constant:constant];
    
    [self addConstraint:constraint];
    
    return constraint;
}


- (NSLayoutConstraint *)addBottomConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:fromView
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toView
                                                                  attribute:NSLayoutAttributeTop
                                                                 multiplier:1.0
                                                                   constant:constant];
    
    [self addConstraint:constraint];
    
    return constraint;
}


- (NSLayoutConstraint *)addLeftConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant
{
    return [self addConstraintWithAttribute:NSLayoutAttributeLeft fromView:fromView toView:toView withConstant:constant];
}


- (NSLayoutConstraint *)addRightConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant
{
    return [self addConstraintWithAttribute:NSLayoutAttributeRight fromView:fromView toView:toView withConstant:constant];
}


- (NSLayoutConstraint *)addLeadingConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant
{
    return [self addConstraintWithAttribute:NSLayoutAttributeLeading fromView:fromView toView:toView withConstant:constant];
}


- (NSLayoutConstraint *)addTrailingConstraintFromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant
{
    return [self addConstraintWithAttribute:NSLayoutAttributeTrailing fromView:fromView toView:toView withConstant:constant];
}


- (NSLayoutConstraint *)addConstraintWithAttribute:(NSLayoutAttribute)attribute fromView:(UIView *)fromView toView:(UIView *)toView
{
    return [self addConstraintWithAttribute:attribute fromView:fromView toView:toView withConstant:0];
}


- (NSLayoutConstraint *)addConstraintWithAttribute:(NSLayoutAttribute)attribute fromView:(UIView *)fromView toView:(UIView *)toView withConstant:(CGFloat)constant
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:fromView
                                                                  attribute:attribute
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:toView
                                                                  attribute:attribute
                                                                 multiplier:1.0
                                                                   constant:constant];
    
    [self addConstraint:constraint];
    
    return constraint;
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
    frame.size.height = ceil(MIN(heightThatFits, self.frame.size.height));
    self.frame = frame;
}


- (void)decreaseWidth
{
    CGRect frame;
    frame = self.frame;
    CGFloat widthThatFits = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:self.lineBreakMode].width;
    frame.size.width = ceil(MIN(widthThatFits, self.frame.size.width));
    self.frame = frame;
}


- (void)adjustHeightWithMaxHeight:(CGFloat)maxHeight
{
    CGRect frame;
    frame = self.frame;
    CGFloat heightThatFits = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:self.lineBreakMode].height;
    frame.size.height = ceil(MIN(heightThatFits, maxHeight));
    self.frame = frame;
}


- (void)adjustWidthWithMaxWidth:(CGFloat)maxWidth
{
    CGRect frame;
    frame = self.frame;
    CGFloat widthThatFits = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height) lineBreakMode:self.lineBreakMode].width;
    frame.size.width = ceil(MIN(widthThatFits, maxWidth));
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


- (CGFloat)heightForLabelWidth:(CGFloat)width
{
    return ceil([self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:self.lineBreakMode].height);
}


- (CGFloat)widthForLabelHeight:(CGFloat)height
{
    return ceil([self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(MAXFLOAT, height) lineBreakMode:self.lineBreakMode].width);
}


- (CGFloat)heightThatFits
{
    return [self heightForLabelWidth:self.frame.size.width];
}


- (CGFloat)widthThatFits
{
    return [self widthForLabelHeight:self.frame.size.height];
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
#if DEBUG
    for (id item in self)
        NSLog(@"%@", item);
#endif
}


- (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint
{
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                   options:(NSJSONWritingOptions)(prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                     error:nil];
    }
	
    return jsonData ? [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] : nil;
}



@end


#pragma mark - NSMutableArray


@implementation NSMutableArray (NSMutableArray_LHelperCategories)


+ (id)mutableArrayUsingWeakReferences
{
    return [self mutableArrayUsingWeakReferencesWithCapacity:0];
}


+ (id)mutableArrayUsingWeakReferencesWithCapacity:(NSUInteger)capacity
{
    CFArrayCallBacks callbacks = {0, NULL, NULL, CFCopyDescription, CFEqual};
    return (id)CFBridgingRelease(CFArrayCreateMutable(0, capacity, &callbacks));
}


@end


#pragma mark - NSDictionary


@implementation NSDictionary (NSDictionary_LHelperCategories)


- (NSString *)queryString
{
    if ([self count] == 0) return nil;
    
    NSMutableString *query = [NSMutableString string];
    
    for (NSString *parameter in [self allKeys])
    {
        NSString *stringValue;
        
        id value = [self valueForKey:parameter];
        
        if ([value isKindOfClass:[NSString class]])
        {
            stringValue = value;
        }
		else if ([value respondsToSelector:@selector(jsonStringWithPrettyPrint:)])
		{
            stringValue = [value jsonStringWithPrettyPrint:NO];
		}
        else if ([value respondsToSelector:@selector(stringValue)])
		{
			stringValue = [value stringValue];
		}
        
        if (stringValue)
            [query appendFormat:@"&%@=%@", [parameter stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], [stringValue stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
        
        LWarning(stringValue, @"No string value?");
    }
    
    return query.length > 2 ? [query substringFromIndex:1] : nil;
}


- (NSString *)jsonStringWithPrettyPrint:(BOOL)prettyPrint
{
    NSData *jsonData;
    
    if ([NSJSONSerialization isValidJSONObject:self])
    {
        jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                   options:(NSJSONWritingOptions)(prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                     error:nil];
    }
	
    return jsonData ? [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] : nil;
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


- (NSDate *)dateToBeginningOfMonth
{
    NSDate *d = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&d interval:NULL forDate:self];
    LAssert(ok, @"Failed to calculate the first day the month based on %@", self);
    return ok ? d : nil;
}


- (NSDate *)dateToBeginningOfPreviousMonth
{
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = -1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0] dateToBeginningOfMonth];
}


- (NSDate *)dateToBeginningOfNextMonth
{
    NSDateComponents *dateComponents = [NSDateComponents new];
    dateComponents.month = 1;
    return [[[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0] dateToBeginningOfMonth];
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


- (BOOL)isEmpty
{
    return [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0;
}


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


- (NSData *)dataFromBase64String
{
    return [NSData dataFromBase64String:self];
}


- (NSString *)AES128EncryptedBase64StringWithKey:(NSString *)key
{
    return [[[self dataUsingEncoding:NSUTF8StringEncoding] AES128EncryptWithKey:key] base64EncodedString];
}


- (NSString *)AES128DecryptedBase64StringWithKey:(NSString *)key
{
    return [[[NSData dataFromBase64String:self] AES128DecryptWithKey:key] stringUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)AES256EncryptedBase64StringWithKey:(NSString *)key
{
    return [[[self dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:key] base64EncodedString];
}


- (NSString *)AES256DecryptedBase64StringWithKey:(NSString *)key
{
    return [[[NSData dataFromBase64String:self] AES256DecryptWithKey:key] stringUsingEncoding:NSUTF8StringEncoding];
}


@end


#pragma mark - NSData


@implementation NSData (NSData_LHelperCategories)


#pragma mark String using encoding


- (NSString *)stringUsingEncoding:(NSStringEncoding)encoding
{
    return [[NSString alloc] initWithData:self encoding:encoding];
}


#pragma mark MD5


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


#pragma mark AES128


- (NSData *)AES128EncryptWithKey:(NSString *)key
{
    char keyPtr[kCCKeySizeAES128+1];
    bzero( keyPtr, sizeof(keyPtr) );
    
    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    const unsigned char iv[] = {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
    
    CCCryptorStatus result = CCCrypt( kCCEncrypt,
                                     kCCAlgorithmAES128,
                                     kCCOptionPKCS7Padding,
                                     keyPtr,
                                     kCCKeySizeAES128,
                                     iv,
                                     [self bytes], [self length],
                                     buffer, bufferSize,
                                     &numBytesEncrypted );
    
    if( result == kCCSuccess )
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    else {
        NSLog(@"Failed AES");
    }
    return nil;
}


- (NSData *)AES128DecryptWithKey:(NSString *)key
{
    char  keyPtr[kCCKeySizeAES128+1];
    bzero( keyPtr, sizeof(keyPtr) );
    
    [key getCString: keyPtr maxLength: sizeof(keyPtr) encoding: NSUTF8StringEncoding];
    
    size_t numBytesEncrypted = 0;
    
    NSUInteger dataLength = [self length];
    
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer_decrypt = malloc(bufferSize);
    const unsigned char iv[] = {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00};
    
    CCCryptorStatus result = CCCrypt( kCCDecrypt , kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                     keyPtr, kCCKeySizeAES128,
                                     iv,
                                     [self bytes], [self length],
                                     buffer_decrypt, bufferSize,
                                     &numBytesEncrypted );
    
    if( result == kCCSuccess )
        return [NSData dataWithBytesNoCopy:buffer_decrypt length:numBytesEncrypted];
    
    return nil;
}


#pragma mark AES256


- (NSData *)AES256EncryptWithKey:(NSString *)key
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}


- (NSData *)AES256DecryptWithKey:(NSString *)key
{
    // 'key' should be 32 bytes for AES256, will be null-padded otherwise
    char keyPtr[kCCKeySizeAES256+1]; // room for terminator (unused)
    bzero(keyPtr, sizeof(keyPtr)); // fill with zeroes (for padding)
    
    // fetch key data
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [self length];
    
    //See the doc: For block ciphers, the output size will always be less than or
    //equal to the input size plus the size of one block.
    //That's why we need to add the size of one block here
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128, kCCOptionPKCS7Padding,
                                          keyPtr, kCCKeySizeAES256,
                                          NULL /* initialization vector (optional) */,
                                          [self bytes], dataLength, /* input */
                                          buffer, bufferSize, /* output */
                                          &numBytesDecrypted);
    
    if (cryptStatus == kCCSuccess) {
        //the returned NSData takes ownership of the buffer and will free it on deallocation
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
    }
    
    free(buffer); //free the buffer;
    return nil;
}


#pragma mark Base64


+ (NSData *)dataFromBase64String:(NSString *)aString
{
    if (![aString length]) return nil;
    
    NSData *decoded = nil;
    
    if (![NSData instancesRespondToSelector:@selector(initWithBase64EncodedString:options:)])
        decoded = [[self alloc] initWithBase64Encoding:[aString stringByReplacingOccurrencesOfString:@"[^A-Za-z0-9+/=]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [aString length])]];
    else
        decoded = [[self alloc] initWithBase64EncodedString:aString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    return [decoded length] ? decoded : nil;
}


- (NSString *)base64EncodedString
{
	const uint8_t *input = (const uint8_t *)[self bytes];
	NSInteger length = [self length];
	
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
	
    NSMutableData *data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t *output = (uint8_t*)data.mutableBytes;
	
	NSInteger i,i2;
    for (i = 0; i < length; i += 3)
    {
        NSInteger value = 0;
		for (i2 = 0; i2 < 3; i2++)
        {
            value <<= 8;
            if (i+i2 < length)
            {
                value |= (0xFF & input[i+i2]);
            }
        }
		
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
	
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}


@end


#pragma mark - UIAlertView


@implementation UIAlertView (UIAlertView_LHelperCategories)


static const void *LDISMISS_IDENTIFER = &LDISMISS_IDENTIFER;
static const void *LCANCEL_IDENTIFER = &LCANCEL_IDENTIFER;


@dynamic cancelBlock;
@dynamic dismissBlock;


- (void)setDismissBlock:(LDismissBlock)dismissBlock
{
    objc_setAssociatedObject(self, LDISMISS_IDENTIFER, dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LDismissBlock)dismissBlock
{
    return objc_getAssociatedObject(self, LDISMISS_IDENTIFER);
}

- (void)setCancelBlock:(LCancelBlock)cancelBlock
{
    objc_setAssociatedObject(self, LCANCEL_IDENTIFER, cancelBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LCancelBlock)cancelBlock
{
    return objc_getAssociatedObject(self, LCANCEL_IDENTIFER);
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


+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtons onDismiss:(LDismissBlock)dismissBlock onCancel:(LCancelBlock)cancelBlock
{
    [[self alertViewWithTitle:title
                      message:message
            cancelButtonTitle:cancelButtonTitle
            otherButtonTitles:otherButtons
                    onDismiss:dismissBlock
                     onCancel:cancelBlock] show];
}


#pragma mark - UIAlertViewDelegate


+ (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == [alertView cancelButtonIndex])
	{
		if (alertView.cancelBlock)
            alertView.cancelBlock();
	}
    else
    {
        if (alertView.dismissBlock)
            alertView.dismissBlock(buttonIndex - 1);
    }
}


#pragma mark -


@end


#pragma mark - UINavigationBar


@implementation UINavigationBar (UINavigationBar_LHelperCategories)


- (void)removeBottomBorder
{
    for (UIView *parentView in self.subviews)
        for (UIView *childView in parentView.subviews)
            if ([childView isKindOfClass:[UIImageView class]])
                [childView removeFromSuperview];
}


@end



#pragma mark - UITableViewCell


@implementation UITableViewCell (UITableViewCell_LHelperCategories)


- (UITableView *)getTableView
{
    id view = [self superview];
    
    while ([view isKindOfClass:[UITableView class]] == NO)
        view = [view superview];
        
        return (UITableView *)view;
}


@end


#pragma mark -


#pragma mark -
#pragma mark - End Of Categories
#pragma mark -


#pragma mark -