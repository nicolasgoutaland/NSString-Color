#NSString-Color [![Build Status](https://travis-ci.org/nicolasgoutaland/NSString-Color.svg?branch=master)](https://travis-ci.org/nicolasgoutaland/NSString-Color)

Category on `NSString` allowing simple color instantiation from its content. Support web colors also.

##Description
This category adds four methods to NSString.
- (UIColor *)colorFromRGBcode   // Consider string as an hexadecimal RGB code
- (UIColor *)colorFromRGBAcode  // Consider string as an hexadecimal RGBA code
- (UIColor *)colorFromName      // Consider string as a webcolor name, UIColor selector name
- (UIColor *)representedColor   // This method will automatically choose between three others methods in order to generate a color

This allows you to load color codes from configuration file, such as `PLIST` and create colors to configure your views background color for example.
All created colors are cached using `NSCache`, allowing you to reuse them.
Webcolor names are case insensitive, and you can specify `UIColor` selectors name without Color suffix.

For a list of webcolors, http://en.wikipedia.org/wiki/Web_colors

![ScreenShot](https://raw.github.com/nicolasgoutaland/NSString-Color/master/Assets/NSString+Colors.gif)

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

##Advantages
* Allows you to load colors from configuration files
* Remove all boilerplate code induced by format checking
* Add web colors

##Bonus
If you are using UIColor categories to add some color code to your project, such as https://github.com/magtory/FPBrandColors, youcan load them from configuration file too.

```objective-c
  [@"Facebook" representedColor];        // UIColor selector name from FPBrandColors
  [@"Github" representedColor];          // UIColor selector name from FPBrandColors
```

##Consideration
While colorFromName will return nil if color name is unknown, colorFromRGBAcode and colorFromRGBcode will return you an undefined color if hexadecimal code is invalid.
Same apply to representedColor when forcing hexadecimal format (Prefixing with #)

##Installation
__Cocoapods__: `pod 'NSString+Colors'`<br>
__Manual__: Copy the __Classes__ folder in your project<br>

Import header in your project. .pch is a good place ;)

    #import "NSString+Colors.h"

##Versions
1.0 : Initial release<br/>
