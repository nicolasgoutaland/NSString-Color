//
//  NSString+Color.h
//  NSStringColor
//
//  Copyright 2014 Nicolas Goutaland. All rights reserved.
//  Created by Nicolas Goutaland on 04/04/14.
//
// Category used to create a color from a string.
// Use an internal cache to reuse colors
// When using hexadecimal string represntation, you can prefix it with NSString_Color_HEXADECIMAL_PREFIX to speed up test
// This class also support web colors code, as defined here : http://en.wikipedia.org/wiki/Web_colors
//
// representedColor is a convenient method, to be used when you don't know color format.
// You can also use colorFromRGBcode colorFromRGBAcode or colorFromName directly

#define NSString_Color_HEXADECIMAL_PREFIX                 @"#"
#define NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX     @"[0-9A-Fa-f]{6,8}"

@interface NSString(Color)
/* Return color from string, assuming it is an Hexadecimal number representation, without leading character 
 * If string isn't a valid hexadecimal color representation, a color object will still be returned, but with incorrect values
 */
- (UIColor *)colorFromRGBcode;

/* Return color from string, assuming it is an Hexadecimal number representation with alpha component, without leading character
 * If string isn't a valid hexadecimal color representation, a color object will still be returned, but with incorrect values
 */
- (UIColor *)colorFromRGBAcode;

/* Return color from string, assuming it is a color name defined in UIColor class.
 * First, check for web color, using lowercas comparison
 * If no matching found, check for selector on UIColor
 * If no matching on selector in UIColor found, retry adding "Color" suffix to string
 * If no color is found, nil is returned
 */
- (UIColor *)colorFromName;

/* Return color from string. 
 * - If string start with NSString_Color_HEXADECIMAL_PREFIX, it will be considered as en hexadecimal string
 *      - If length is 7, colorFromRGBcode will be used on substring starting at 1
 *      - Else, colorFromRGBAcode will be used on substring starting at 1
 * - Else, string be be checked through NSString_Color_HEXADECIMAL_COLOR_STRING_REGEX to check if its an hexadecimal number
 *      - If matching
 *          - If length is 6, colorFromRGBcode will be used on string
 *          - Else, colorFromRGBAcode will be used on string
 * - Finally, string will be assumed to be a color name, so colorFromName will be used on string
 */
- (UIColor *)representedColor;
@end
