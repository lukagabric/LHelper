#import "LHelper.h"
#include <sys/xattr.h>


@implementation LHelper


#pragma mark - DoNotBackup


+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[URL path]]) return NO;

    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.1"))
    {
        NSError *error = nil;
        BOOL success = [URL setResourceValue:[NSNumber numberWithBool: YES]
                                      forKey:NSURLIsExcludedFromBackupKey
                                       error: &error];

        if (!success)
        {
            Log(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        
        return success;
    }
    else
    {
        return [self addSkipBackupAttributeToItemAtPath:[URL path]];
    }
}


+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)path
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return NO;

    const char* filePath = [path fileSystemRepresentation];
    
    const char* attrName = "com.apple.MobileBackup";
    u_int8_t attrValue = 1;
    
    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
    return result == 0;
}


#pragma mark - UUID


+ (NSString *)getUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
	NSString *uuid = [NSString stringWithString:(__bridge NSString *)uuidStringRef];
	CFRelease(uuidRef);
	CFRelease(uuidStringRef);
    return uuid;
}


#pragma mark - RGB color


+ (UIColor *)colorFromHexString:(NSString *)hexString
{
	if (hexString != nil && [hexString length] > 0)
	{
		NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
		if ([cleanString length] == 3)
		{
			cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@", 
						   [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
						   [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
						   [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
		}
		
		if ([cleanString length] == 6)
		{
			cleanString = [cleanString stringByAppendingString:@"ff"];
		}
		
		unsigned int baseValue;
		[[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
		
		float red = ((baseValue >> 24) & 0xFF)/255.0f;
		float green = ((baseValue >> 16) & 0xFF)/255.0f;
		float blue = ((baseValue >> 8) & 0xFF)/255.0f;
		float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
		
		return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];	
	}
	
	return [UIColor clearColor];
}


#pragma mark - Radnom


+ (NSInteger)randomNumberBetweenA:(NSInteger)a andB:(NSInteger)b
{
    NSInteger min = MIN(a, b);
    NSInteger max = MAX(a, b);
    
	return min + arc4random() % (max - min + 1);
}


#pragma mark - Get View From Nib


+ (UIView *)getViewWithClass:(Class)viewClass fromNibNamed:(NSString *)nibName
{
	NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
	
	for (UIView *view in topLevelObjects)
	{
		if ([view isKindOfClass:viewClass])
		{
			return view;
		}
	}
	
	return nil;
}


#pragma mark - Get applications window


+ (UIWindow *)appWindow
{
	return [[[UIApplication sharedApplication] windows] objectAtIndex:0];
}


#pragma mark - Get docs and lib dirs


+ (NSString *)documentsDir
{
	NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [documentsPaths objectAtIndex:0];
}


+ (NSString *)libraryDir
{
	NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [libraryPaths objectAtIndex:0];
}


+ (NSString *)cachesDir
{
	NSArray *cachesPaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [cachesPaths objectAtIndex:0];
}


#pragma mark - Convert/get dates


+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)theFormat
{
	if (string == nil) return nil;

	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateFormat:theFormat];
	return [dateFormatter dateFromString:string];
}


+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)theFormat
{
	if (date == nil) return nil;
	
	NSDateFormatter *dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateFormat:theFormat];
	return [dateFormatter stringFromDate:date];
}


#pragma mark - Label helper


+ (void)decreaseHeightOfLabel:(UILabel *)label
{
	CGRect frame;
	frame = label.frame;
	CGFloat heightThatFits = [label sizeThatFits:CGSizeMake(frame.size.width, 9999)].height;
	frame.size.height = MIN(heightThatFits, frame.size.height);
	label.frame = frame;
}


+ (void)adjustHeightOfLabel:(UILabel *)label maxHeight:(CGFloat)maxHeight
{
	CGRect frame;
	frame = label.frame;
	CGFloat heightThatFits = [label sizeThatFits:CGSizeMake(frame.size.width, 9999)].height;
	frame.size.height = MIN(heightThatFits, maxHeight);
	label.frame = frame;
}


+ (void)decreaseWidthOfLabel:(UILabel *)label
{
	CGRect frame;
	frame = label.frame;
	float widthThatFits = [label sizeThatFits:label.frame.size].width;
	if (widthThatFits < frame.size.width) frame.size.width = widthThatFits;
	label.frame = frame;
}


+ (void)adjustWidthOfLabel:(UILabel *)label maxWidth:(CGFloat)maxWidth
{
	CGRect frame;
	frame = label.frame;
	CGFloat widthThatFits = [label sizeThatFits:CGSizeMake(9999, frame.size.height)].width;
	frame.size.width = MIN(widthThatFits, maxWidth);
	label.frame = frame;
}


#pragma mark - View helper


+ (void)placeView:(UIView *)addView belowView:(UIView *)fixedView withPadding:(CGFloat)padding
{
	CGRect addViewFrame = addView.frame;
	addViewFrame.origin.y = CGRectGetMaxY(fixedView.frame) + padding;
	addView.frame = addViewFrame;
}


+ (void)placeView:(UIView *)addView belowAndCenterView:(UIView *)fixedView withPadding:(CGFloat)padding
{
	addView.center = fixedView.center;

	CGRect addViewFrame = addView.frame;
	addViewFrame.origin.y = CGRectGetMaxY(fixedView.frame) + padding;
	addView.frame = addViewFrame;
}


+ (void)placeView:(UIView *)addView rightFromView:(UIView *)fixedView withPadding:(CGFloat)padding
{
	CGRect addViewFrame = addView.frame;
	addViewFrame.origin.x = CGRectGetMaxX(fixedView.frame) + padding;
	addView.frame = addViewFrame;
}


+ (void)placeView:(UIView *)addView rightAndCenterFromView:(UIView *)fixedView withPadding:(CGFloat)padding
{
	addView.center = fixedView.center;

	CGRect addViewFrame = addView.frame;
	addViewFrame.origin.x = CGRectGetMaxX(fixedView.frame) + padding;
	addView.frame = addViewFrame;
}


+ (void)setOrigin:(CGPoint)origin forView:(UIView *)view
{
	CGRect frame = view.frame;
	frame.origin = origin;
	view.frame = frame;
}


+ (void)setSize:(CGSize)size forView:(UIView *)view
{
	CGRect frame = view.frame;
	frame.size = size;
	view.frame = frame;
}


+ (void)setX:(CGFloat)x andY:(CGFloat)y forView:(UIView *)view
{
	CGRect frame = view.frame;
	frame.origin = CGPointMake(x, y);
	view.frame = frame;
}


+ (void)setWidth:(CGFloat)width andHeight:(CGFloat)height forView:(UIView *)view
{
	CGRect frame = view.frame;
	frame.size = CGSizeMake(width, height);
	view.frame = frame;
}


#pragma mark -


@end