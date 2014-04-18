//
//  NSStringColorSampleTests.m
//  NSStringColorSampleTests
//
//  Created by Nicolas Goutaland on 10/04/14.
//  Copyright (c) 2014 Nicolas Goutaland. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface NSStringColorSampleTests : XCTestCase

@end

@implementation NSStringColorSampleTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testColorName
{
    XCTAssertNotNil([@"redColor" representedColor], @"redColor should return a color");
    XCTAssertNotNil([@"blue" colorFromName], @"redColor should return a color");
}

- (void)testColorNameNonSuffixed
{
    XCTAssertNotNil([@"red" representedColor], @"red should return a color");
}

- (void)testHexadecimalPrefixed
{
    XCTAssertNotNil([@"#eeeeee" representedColor], @"#eeeeee should return a color");
    XCTAssertNotNil([@"#eeeeeeee" representedColor], @"#eeeeeeee should return a color");
}

- (void)testWebcolor
{
    XCTAssertNotNil([@"teal" representedColor], @"teal should return a color");
    XCTAssertNotNil([@"RoSyBrOwn" representedColor], @"RoSyBrOwn should return a color");
    XCTAssertNotNil([@"darkMagenta" colorFromName], @"darkMagenta should return a color");
}

- (void)testCache
{
    UIColor *firstColor = [@"MediumSlateBlue" representedColor];
    UIColor *secondColor = [@"MediumSlateBlue" representedColor];
    
    XCTAssertEqual(firstColor, secondColor, @"2 same color have to be the same object");
}

- (void)testHexadecimal
{
    XCTAssertNotNil([@"00ffff" representedColor], @"00ffff should return a color");
    XCTAssertNotNil([@"fFe4b5" representedColor], @"fFe4b5 should return a color");
    XCTAssertNotNil([@"fFe4b577" representedColor], @"fFe4b577 should return a color");

    XCTAssertNil([@"fFe454b5FF" representedColor], @"fFe454b5FF should not return a color");
    XCTAssertNil([@"not a color" representedColor], @"not a color should not return a color");
}

- (void)testRegisteredColor
{
    NSString *key = @"myCustomColor";
    NSString *keyCaseUpdated = @"MyCuSTOMcolor";

    XCTAssertNil([NSString registeredColorForKey:key], @"myCustomColor should not return a color");
    XCTAssertNil([NSString registeredColorForKey:keyCaseUpdated], @"MyCuSTOMcolor should not return a color");

    UIColor *registeredColor = [UIColor redColor];
    [NSString registerColor:registeredColor
                    withKey:key];

    XCTAssertNotNil([NSString registeredColorForKey:key], @"myCustomColor should return a color");
    XCTAssertNotNil([NSString registeredColorForKey:keyCaseUpdated], @"MyCuSTOMcolor should return a color");
    XCTAssertEqual(registeredColor, [NSString registeredColorForKey:key], @"Returned color is not correct");

    [NSString clearRegisteredColorForKey:key];
    XCTAssertNil([NSString registeredColorForKey:key], @"myCustomColor should not return a color");
    XCTAssertNil([NSString registeredColorForKey:keyCaseUpdated], @"MyCuSTOMcolor should not return a color");
}

- (void)testRegisteredColorOverride
{
    UIColor *blueColor = [UIColor blueColor];
    XCTAssertNil([NSString registeredColorForKey:@"myCustomColor"], @"myCustomColor should not return a registered color");
    [NSString registerColor:blueColor withKey:@"myCustomColor"];

    UIColor *registeredCustomColor = [NSString registeredColorForKey:@"myCustomColor"];
    XCTAssertEqual(blueColor, registeredCustomColor, @"registered custom color should be the same as blueColor");

    registeredCustomColor = [@"myCustomColor" representedColor];
    XCTAssertEqual(blueColor, registeredCustomColor, @"registered custom color should be the same as blueColor");

    [NSString registerColors:@{@"myCustomColor": [@"redColor" representedColor], @"myOtherCustomColor" : @"yellow", @"wrongColorRepresentation" : @"jklsjlfs", @"ortherWrongColorRepresentation" : @[@""]}];

    registeredCustomColor = [@"myCustomColor" representedColor];
    XCTAssertNotEqual(blueColor, registeredCustomColor, @"registered custom color should be different than blueColor");

    XCTAssertNotNil([@"myOtherCustomColor" representedColor], @"myOtherCustomColor should return a color");
    XCTAssertNil([@"wrongColorRepresentation" representedColor], @"wrongColorRepresentation should not return a color");
    XCTAssertNil([@"ortherWrongColorRepresentation" representedColor], @"wrongColorRepresentation should not return a color");
}
@end
