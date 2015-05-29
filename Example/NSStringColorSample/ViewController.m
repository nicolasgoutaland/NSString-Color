//
//  ViewController.m
//  NSStringColorSample
//
//  Created by Nicolas Goutaland on 10/04/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import "ViewController.h"

#define CUSTOM_COLORS_FILE  @"CustomColors"

@interface ViewController ()
// Outlets
@property (nonatomic, weak) IBOutlet UITextField *textField;
@property (nonatomic, weak) IBOutlet UIView      *resultView;
@end

@implementation ViewController
#pragma mark - View management
- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure result view
    _resultView.layer.borderColor = [@"black" representedColor].CGColor;
    _resultView.layer.borderWidth = 2.0;
    _resultView.layer.cornerRadius = 4.0;

    // Register som custom colorspho
    NSString *colorsPath          = [[NSBundle mainBundle] pathForResource:CUSTOM_COLORS_FILE ofType:@"plist"];
    NSDictionary *dicCustomColors = [NSDictionary dictionaryWithContentsOfFile:colorsPath];
    [NSString registerColors:dicCustomColors];
}

#pragma mark - UITextFieldDelegate methods
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UIColor *color = [textField.text representedColor];
    _resultView.backgroundColor = color;

    // Check for wrong colors
    if (!color)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:[NSString stringWithFormat:@"<%@> is not a valid color", textField.text]
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
