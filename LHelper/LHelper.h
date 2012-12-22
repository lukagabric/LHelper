#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LHelperCategories.h"


#pragma mark - StrTo conversion


#define StrToInt(str) [str intValue]
#define StrToInteger(str) [str integerValue]
#define StrToFloat(str) [str floatValue]


#pragma mark - ToStr conversion


#define IntToStr(int) [NSString stringWithFormat:@"%d", int]
#define FloatToStr(float) [NSString stringWithFormat:@"%f", float]


#pragma mark - Log


#ifdef DEBUG
#define LogLong(format, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define Print(object)        NSLog(@"%@", object)
#define Log(format, ...)	 NSLog(@"%@", [NSString stringWithFormat:format, ## __VA_ARGS__])
#define LogInt(someInt)	     NSLog(@"%d", someInt)
#define LogFloat(someFloat)  NSLog(@"%f", someFloat)
#else
#define LogLong(format, ...)
#define Print(object)
#define Log(format, ...)
#define LogInt(someInt)
#define LogFloat(someFloat)
#endif


#pragma mark - RGB color


#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromHex(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromHexAlpha(hexValue, a) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:a]


#pragma mark - Check if widescreen


#define IS_WIDESCREEN (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double)568) < DBL_EPSILON)


#pragma mark - Check device


#define IS_IPHONE ([[[UIDevice currentDevice] model] isEqualToString:@"iPhone"])
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


#pragma mark - Deg2Rad


#define degreesToRadians(x) (M_PI * x / 180.0)
#define radiansToDegrees(x) (x * (180.0 / M_PI))


#pragma mark - Functions to get dirs


#define documentsDir() [LHelper documentsDir]
#define libraryDir() [LHelper libraryDir]
#define cachesDir() [LHelper cachesDir]


#pragma mark - Check iOS versions


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#pragma mark - Singleton GCD Macro


#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)shared##classname {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * shared##classname = nil;\
dispatch_once( &pred, ^{                            \
shared##classname = [[self alloc] init]; });    \
return shared##classname;                           \
}
#endif


@interface LHelper : NSObject


#pragma mark - DoNotBackup


+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
+ (BOOL)addSkipBackupAttributeToItemAtPath:(NSString *)path;


#pragma mark - UUID


+ (NSString *)getUUID;


#pragma mark - RGB color


+ (UIColor *)colorFromHexString:(NSString *)hexString;


#pragma mark - Radnom


+ (NSInteger)randomNumberBetweenA:(NSInteger)a andB:(NSInteger)b;


#define randomInRange(a,b) [LHelper randomNumberBetweenA:a andB:b]


#pragma mark - Get View From Nib


+ (UIView *)getViewWithClass:(Class)viewClass fromNibNamed:(NSString *)nibName;


#pragma mark - Get applications window


+ (UIWindow *)appWindow;


#pragma mark - Get docs and lib dirs


+ (NSString *)documentsDir;
+ (NSString *)libraryDir;
+ (NSString *)cachesDir;


#pragma mark - Convert/get dates


+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)theFormat;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)theFormat;

#pragma mark - Label

+ (void)decreaseHeightOfLabel:(UILabel *)label;
+ (void)adjustHeightOfLabel:(UILabel *)label maxHeight:(CGFloat)maxHeight;
+ (void)decreaseWidthOfLabel:(UILabel *)label;
+ (void)adjustWidthOfLabel:(UILabel *)label maxWidth:(CGFloat)maxWidth;


#pragma mark - View


+ (void)placeView:(UIView *)addView belowView:(UIView *)fixedView withPadding:(CGFloat)padding;
+ (void)placeView:(UIView *)addView belowAndCenterView:(UIView *)fixedView withPadding:(CGFloat)padding;
+ (void)placeView:(UIView *)addView rightFromView:(UIView *)fixedView withPadding:(CGFloat)padding;
+ (void)placeView:(UIView *)addView rightAndCenterFromView:(UIView *)fixedView withPadding:(CGFloat)padding;
+ (void)setOrigin:(CGPoint)origin forView:(UIView *)view;
+ (void)setSize:(CGSize)size forView:(UIView *)view;
+ (void)setX:(CGFloat)x andY:(CGFloat)y forView:(UIView *)view;
+ (void)setWidth:(CGFloat)width andHeight:(CGFloat)height forView:(UIView *)view;


#pragma mark - Location/Map


@end