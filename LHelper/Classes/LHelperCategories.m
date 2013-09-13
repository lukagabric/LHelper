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


- (NSData *)dataFromBase64String
{
    return [NSData dataFromBase64String:self];
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


//
// Mapping from 6 bit pattern to ASCII character.
//
static unsigned char base64EncodeLookup[65] =
"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

//
// Definition for "masked-out" areas of the base64DecodeLookup mapping
//
#define xx 65

//
// Mapping from ASCII character to 6 bit pattern.
//
static unsigned char base64DecodeLookup[256] =
{
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 62, xx, xx, xx, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, xx, xx, xx, xx, xx, xx,
    xx,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, xx, xx, xx, xx, xx,
    xx, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx,
};

//
// Fundamental sizes of the binary and base64 encode/decode units in bytes
//
#define BINARY_UNIT_SIZE 3
#define BASE64_UNIT_SIZE 4

//
// NewBase64Decode
//
// Decodes the base64 ASCII string in the inputBuffer to a newly malloced
// output buffer.
//
//  inputBuffer - the source ASCII string for the decode
//	length - the length of the string or -1 (to specify strlen should be used)
//	outputLength - if not-NULL, on output will contain the decoded length
//
// returns the decoded buffer. Must be free'd by caller. Length is given by
//	outputLength.
//
void *NewBase64Decode(
                      const char *inputBuffer,
                      size_t length,
                      size_t *outputLength)
{
	if (length == -1)
	{
		length = strlen(inputBuffer);
	}
	
	size_t outputBufferSize =
    ((length+BASE64_UNIT_SIZE-1) / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE;
	unsigned char *outputBuffer = (unsigned char *)malloc(outputBufferSize);
	
	size_t i = 0;
	size_t j = 0;
	while (i < length)
	{
		//
		// Accumulate 4 valid characters (ignore everything else)
		//
		unsigned char accumulated[BASE64_UNIT_SIZE];
		size_t accumulateIndex = 0;
		while (i < length)
		{
			unsigned char decode = base64DecodeLookup[inputBuffer[i++]];
			if (decode != xx)
			{
				accumulated[accumulateIndex] = decode;
				accumulateIndex++;
				
				if (accumulateIndex == BASE64_UNIT_SIZE)
				{
					break;
				}
			}
		}
		
		//
		// Store the 6 bits from each of the 4 characters as 3 bytes
		//
		// (Uses improved bounds checking suggested by Alexandre Colucci)
		//
		if(accumulateIndex >= 2)
			outputBuffer[j] = (accumulated[0] << 2) | (accumulated[1] >> 4);
		if(accumulateIndex >= 3)
			outputBuffer[j + 1] = (accumulated[1] << 4) | (accumulated[2] >> 2);
		if(accumulateIndex >= 4)
			outputBuffer[j + 2] = (accumulated[2] << 6) | accumulated[3];
		j += accumulateIndex - 1;
	}
	
	if (outputLength)
	{
		*outputLength = j;
	}
	return outputBuffer;
}


//
// NewBase64Encode
//
// Encodes the arbitrary data in the inputBuffer as base64 into a newly malloced
// output buffer.
//
//  inputBuffer - the source data for the encode
//	length - the length of the input in bytes
//  separateLines - if zero, no CR/LF characters will be added. Otherwise
//		a CR/LF pair will be added every 64 encoded chars.
//	outputLength - if not-NULL, on output will contain the encoded length
//		(not including terminating 0 char)
//
// returns the encoded buffer. Must be free'd by caller. Length is given by
//	outputLength.
//
char *NewBase64Encode(
                      const void *buffer,
                      size_t length,
                      bool separateLines,
                      size_t *outputLength)
{
	const unsigned char *inputBuffer = (const unsigned char *)buffer;
	
#define MAX_NUM_PADDING_CHARS 2
#define OUTPUT_LINE_LENGTH 64
#define INPUT_LINE_LENGTH ((OUTPUT_LINE_LENGTH / BASE64_UNIT_SIZE) * BINARY_UNIT_SIZE)
#define CR_LF_SIZE 2
	
	//
	// Byte accurate calculation of final buffer size
	//
	size_t outputBufferSize =
    ((length / BINARY_UNIT_SIZE)
     + ((length % BINARY_UNIT_SIZE) ? 1 : 0))
    * BASE64_UNIT_SIZE;
	if (separateLines)
	{
		outputBufferSize +=
        (outputBufferSize / OUTPUT_LINE_LENGTH) * CR_LF_SIZE;
	}
	
	//
	// Include space for a terminating zero
	//
	outputBufferSize += 1;
    
	//
	// Allocate the output buffer
	//
	char *outputBuffer = (char *)malloc(outputBufferSize);
	if (!outputBuffer)
	{
		return NULL;
	}
    
	size_t i = 0;
	size_t j = 0;
	const size_t lineLength = separateLines ? INPUT_LINE_LENGTH : length;
	size_t lineEnd = lineLength;
	
	while (true)
	{
		if (lineEnd > length)
		{
			lineEnd = length;
		}
        
		for (; i + BINARY_UNIT_SIZE - 1 < lineEnd; i += BINARY_UNIT_SIZE)
		{
			//
			// Inner loop: turn 48 bytes into 64 base64 characters
			//
			outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
			outputBuffer[j++] = base64EncodeLookup[((inputBuffer[i] & 0x03) << 4)
                                                   | ((inputBuffer[i + 1] & 0xF0) >> 4)];
			outputBuffer[j++] = base64EncodeLookup[((inputBuffer[i + 1] & 0x0F) << 2)
                                                   | ((inputBuffer[i + 2] & 0xC0) >> 6)];
			outputBuffer[j++] = base64EncodeLookup[inputBuffer[i + 2] & 0x3F];
		}
		
		if (lineEnd == length)
		{
			break;
		}
		
		//
		// Add the newline
		//
		outputBuffer[j++] = '\r';
		outputBuffer[j++] = '\n';
		lineEnd += lineLength;
	}
	
	if (i + 1 < length)
	{
		//
		// Handle the single '=' case
		//
		outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
		outputBuffer[j++] = base64EncodeLookup[((inputBuffer[i] & 0x03) << 4)
                                               | ((inputBuffer[i + 1] & 0xF0) >> 4)];
		outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i + 1] & 0x0F) << 2];
		outputBuffer[j++] =	'=';
	}
	else if (i < length)
	{
		//
		// Handle the double '=' case
		//
		outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i] & 0xFC) >> 2];
		outputBuffer[j++] = base64EncodeLookup[(inputBuffer[i] & 0x03) << 4];
		outputBuffer[j++] = '=';
		outputBuffer[j++] = '=';
	}
	outputBuffer[j] = 0;
	
	//
	// Set the output length and return the buffer
	//
	if (outputLength)
	{
		*outputLength = j;
	}
	return outputBuffer;
}


//
// dataFromBase64String:
//
// Creates an NSData object containing the base64 decoded representation of
// the base64 string 'aString'
//
// Parameters:
//    aString - the base64 string to decode
//
// returns the autoreleased NSData representation of the base64 string
//
+ (NSData *)dataFromBase64String:(NSString *)aString
{
	NSData *data = [aString dataUsingEncoding:NSASCIIStringEncoding];
	size_t outputLength;
	void *outputBuffer = NewBase64Decode([data bytes], [data length], &outputLength);
	NSData *result = [NSData dataWithBytes:outputBuffer length:outputLength];
	free(outputBuffer);
	return result;
}

//
// base64EncodedString
//
// Creates an NSString object that contains the base 64 encoding of the
// receiver's data. Lines are broken at 64 characters long.
//
// returns an autoreleased NSString being the base 64 representation of the
//	receiver.
//
- (NSString *)base64EncodedString
{
	size_t outputLength;
	char *outputBuffer =
    NewBase64Encode([self bytes], [self length], true, &outputLength);
	
	NSString *result =
    [[NSString alloc]
     initWithBytes:outputBuffer
     length:outputLength
     encoding:NSASCIIStringEncoding];
	free(outputBuffer);
	return result;
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