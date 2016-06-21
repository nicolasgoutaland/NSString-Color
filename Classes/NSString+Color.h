//
//  NSString+Color.h
//  NSStringColor
//
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//  Created by Nicolas Goutaland on 04/04/14.

@class UIColor;

/**
 @name NSString_Color_HEXADECIMAL_PREFIX
 */
#define NSString_Color_HEXADECIMAL_PREFIX                 @"#"

/**
 @name NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX
 */
#define NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX     @"[0-9A-Fa-f]{6,8}"

/**
 Category used to create a color from a string<br/>
 Use an internal cache to reuse colors<br/>
 When using hexadecimal string represntation, you can prefix it with `NSString_Color_HEXADECIMAL_PREFIX` to speed up test<br/>
 This class also support web colors code, as defined here : http://en.wikipedia.org/wiki/Web_colors<br/>
 
 `representedColor` is a convenient method, to be used when you don't know color format<br/>
 You can also use `colorFromRGBcode`, `colorFromRGBAcode` or `colorFromName` directly
 
 Another useful feature is the ability to define custom color codes
 
 ## Change log
 
 * 1.1.2 : Updated documentation
 * 1.1.1 : Fixed a bug handling cache in `registeredColorForKey` method
 * 1.1   : Added convenient method to register custom colors
 * 1.0   : Initial release
 */
@interface NSString(Color)
/** Allows you to register a custom color.<br/>
 Color could be retrieved from `registeredColorForKey`, `colorFromName` or `representedColor` method

 When trying to retrieve color from a string, registered colors will be checked first

 This method is really helpful to define colors used by your application.<br/>
 For example, you can define a titleTextForegroundColor in a configuration file and register it at loading<br/>
 You will just have to update its color definition in order to update it through all application

 @param color Color to be registered
 @param key Key associated to color

 @warning Be careful, keys are case insensitive !
 */
+ (void)registerColor:(UIColor *)color withKey:(NSString *)key;

/** Register a bunch of custom colors<br/>
  Useful when loading custom colors configuration from a PLIST<br/>
  Each value can be either UIColor object or strings, that will be transformed in UIColor objects using `representedColor` method<br/>
  @param colors Colors to be registered
 */
+ (void)registerColors:(NSDictionary *)colors;

/** Remove registered color
 @warning Be careful, keys are case insensitive !
 @param key A previously registered color key
 */
+ (void)clearRegisteredColorForKey:(NSString *)key;

/** Retrieve color registered with given key
 @param key a previously registered color key
 @warning Be careful, keys are case insensitive !
 @return Associated color, `nil` if no match
 */
+ (UIColor *)registeredColorForKey:(NSString *)key;

/** Retrieve web color using lowercase comparison 
 @param webColorName A web color name
 @return Represented color, `nil` if no match
 */
+ (UIColor *)webColorForKey:(NSString *)webColorName;

/** Return color from string, assuming it is an Hexadecimal number representation, without leading character<br/>
  If string isn't a valid hexadecimal color representation, a color object will still be returned, but with incorrect values
 @return Represented color, `nil` if no match
 */
- (UIColor *)colorFromRGBcode;

/** Return color from string, assuming it is an Hexadecimal number representation with alpha component, without leading character<br/>
  If string isn't a valid hexadecimal color representation, a color object will still be returned, but with incorrect values
 @return Associated color, `nil` if no match
 */
- (UIColor *)colorFromRGBAcode;

/** Return color from string, assuming it is a color name defined in UIColor class or a registered color name.<br/>
  First string will be check on registeredColors list. If a color is found, it will be returned.<br/>
  Next, check for web color, using lowercase comparison<br/>
  If no matching found, check for selector on UIColor<br/>
  If no matching on selector in UIColor found, retry adding *Color* suffix to string<br/>
  If no color is found, nil is returned<br/>
 @return Represented color, `nil` if no match
 */
- (UIColor *)colorFromName;

/** Return color from string.

 * First string will be check on `registeredColors` list. If a color is found, it will be returned.
 * Otherwise, if string start with `NSString_Color_HEXADECIMAL_PREFIX`, it will be considered as en hexadecimal string
   * If length is 7, `colorFromRGBcode` will be used on substring starting at 1
   * Else, `colorFromRGBAcode` will be used on substring starting at 1
 * Else, string be be checked through `NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX` to check if its an hexadecimal number
   * If matching
      * If length is 6, `colorFromRGBcode` will be used on string
      * Else, `colorFromRGBAcode` will be used on string
 * Finally, string will be assumed to be a color name, so `colorFromName` will be used on string
 @return Represented color, `nil` if no match
 */
- (UIColor *)representedColor;
@end
