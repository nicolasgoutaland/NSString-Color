#NSString+Color [![Build Status](https://travis-ci.org/nicolasgoutaland/NSString-Color.svg?branch=master)](https://travis-ci.org/nicolasgoutaland/NSString-Color)

Category on `NSString` allowing simple color instantiation from its content. Support web colors and custom colors code also.

##Description
This category adds following methods to NSString.
```objective-c
- (UIColor *)colorFromRGBcode   // Consider string as an hexadecimal RGB code
- (UIColor *)colorFromRGBAcode  // Consider string as an hexadecimal RGBA code
- (UIColor *)colorFromName      // Consider string as a webcolor name, UIColor selector name or custom color code
- (UIColor *)representedColor   // This method will automatically choose between three other methods in order to generate a color

+ (UIColor *)webColorForKey:(NSString *)aWebColorName; // Return associated web color

+ (void)registerColor:(UIColor *)aColor withKey:(NSString *)aKey; // Register a custom color for given key
+ (void)registerColors:(NSDictionary *)colors;                    // Register a bunch of custom colors
+ (void)clearRegisteredColorForKey:(NSString *)aKey;              // Remove a previously registered color
+ (UIColor *)registeredColorForKey:(NSString *)aKey;              // Retreive a previously registered color
```

This allows you to load color codes from configuration file, such as `PLIST` and create colors to configure your views background color for example.
All created colors are cached using `NSCache`, allowing you to reuse them.
Webcolor names are case insensitive, and you can specify `UIColor` selectors name without Color suffix.

For a list of webcolors, you can have a look at [Wikipedia Web colors page](http://en.wikipedia.org/wiki/Web_colors)

![ScreenShot](https://raw.github.com/nicolasgoutaland/NSString-Color/master/Assets/NSString+Colors.gif)

Last update added support for custom color keys, allowing you to define custom code. You can for example define a *titleColor* key and use it in your application. Custom colors can be retrieved using `representedColor`, `colorFromName` and `registeredColorForKey` methods. This can be really helpful when styling an entire application, allowing you to update color through all screens, just by editing color from a PLIST file for example.  

![ScreenShot](https://raw.github.com/nicolasgoutaland/NSString-Color/master/Assets/RegisteredColors.gif)

##Usage
* simply call one of added method on an NSString object
* Preferred way is using representedColor method which will detect right color format
 
##Example
```objective-c
  [@"red" representedColor];        // UIColor selector name without suffix
  [@"redColor" representedColor];   // UIColor full selector name
  [@"#FFEE55" representedColor];    // RGB Hexadecimal code. Prefix with # to force hexadecimal method
  [@"FFEE55" representedColor];     // RGB Hexadecimal code. Will also work, but will be checked through a regex first
  [@"#eeEEEe77" representedColor];  // RGB and RGBA Hexadecimal code are case insensitive too
  [@"roSyBroWn" representedColor];  // Web color case insensitive

  [@"FFEE55" colorFromRGBcode];     // Hexadecimal code
  [@"red" colorFromName];           // UIColor selector name, without color suffix
  [@"redColor" colorFromName];      // UIColor full selector name
  [@"red" colorFromName];           // UIColor selector name, without color suffix
  [@"roSyBroWn" colorFromName];     // Web color case insensitive
```

##Custom color example
```objective-c
  [NSString registerColor:[@"#eeeeee"] withKey:@"descriptionText"]; /// Register a custom color
  [@"descriptionText" representedColor];  // Retrieve a custom color
  [@"dEscRiptIONText" representedColor];  // Custom color names are case insensitive

```

##Advantages
* Allows you to load colors from configuration files
* Remove all boilerplate code induced by format checking
* Add web colors

##Bonus
If you are using UIColor categories to add some color code to your project, you can load them from configuration file too. Be careful, selector name are case sensitive.

* [FPBrandColors](https://github.com/magtory/FPBrandColors)
```objective-c
  [@"Facebook" representedColor];                      // UIColor selector name from FPBrandColors
  [@"Github" representedColor];                        // UIColor selector name from FPBrandColors
```

* [UIColor-FlatColors](https://github.com/mokagio/UIColor-FlatColors)
```objective-c
  [@"flatEmeraldColor" representedColor];              // UIColor selector name from UIColor-FlatColors
  [@"flatPomegranateColor" representedColor];          // UIColor selector name from UIColor-FlatColors
```

* [UIColor-CSSColors](https://github.com/mokagio/UIColor-CSSColors)
```objective-c
  [@"cssBurlywoodColor" representedColor];             // UIColor selector name from UIColor-CSSColors
  [@"cssLightgoldenrodyellowColor" representedColor];  // UIColor selector name from UIColor-CSSColors
```

##Consideration
While colorFromName will return nil if color name is unknown, colorFromRGBAcode and colorFromRGBcode will return you an undefined color if hexadecimal code is invalid.
Same apply to representedColor when forcing hexadecimal format (Prefixing with #)

##Installation
__Cocoapods__: `pod 'NSString+Color'`<br>
__Manual__: Copy the __Classes__ folder in your project<br>

Import header in your project. .pch is a good place ;)

    #import "NSString+Color.h"

##Versions
1.1.1 : Fixed a bug handling cache in + registeredColorForKey method<br/>
1.1   : Added support for custom colors codes<br/>
1.0   : Initial release<br/>
