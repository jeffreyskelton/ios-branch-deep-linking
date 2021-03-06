

//--------------------------------------------------------------------------------------------------
//
//                                                                                 NSString+Branch.h
//                                                                                  Branch.framework
//
//                                                                                NSString Additions
//                                                                       Edward Smith, February 2017
//
//                                             -©- Copyright © 2017 Branch, all rights reserved. -©-
//
//--------------------------------------------------------------------------------------------------


#import <XCTest/XCTest.h>
#import "NSString+Branch.h"


#define _countof(array)  (sizeof(array)/sizeof(array[0]))


@interface NSStringBranchTest : XCTestCase
@end


@implementation NSStringBranchTest

- (void) testMaskEqual {
    XCTAssertTrue([@"0123" bnc_isEqualToMaskedString:@"0123"]);
    XCTAssertFalse([@"0123" bnc_isEqualToMaskedString:@"012"]);
    XCTAssertFalse([@"0123" bnc_isEqualToMaskedString:@"01234"]);
    XCTAssertTrue([@"0123" bnc_isEqualToMaskedString:@"01*3"]);
    XCTAssertFalse([@"0123" bnc_isEqualToMaskedString:@"01*4"]);
    XCTAssertTrue([@"0123" bnc_isEqualToMaskedString:@"*123"]);
    XCTAssertTrue([@"0123" bnc_isEqualToMaskedString:@"012*"]);
    XCTAssertTrue([@"日本語123日本語" bnc_isEqualToMaskedString:@"日本語123日本語"]);
    XCTAssertFalse([@"日本語123日本語" bnc_isEqualToMaskedString:@"日本語1234本語"]);
    XCTAssertTrue([@"日本語123日本語" bnc_isEqualToMaskedString:@"日本語***日本語"]);
    XCTAssertTrue([@"日本語123日本語" bnc_isEqualToMaskedString:@"***123日本語"]);
}

- (void) testStringTruncatedAtNull {
    char bytes[] = "\x30\x31\x00\x32\x33\x34\x35\x36";
    XCTAssert(sizeof(bytes) == 9);
    NSData *data = [NSData dataWithBytes:bytes length:sizeof(bytes)-1];
    XCTAssert(data.length == 8);
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    XCTAssert(string.length == 8);
    string = [string bnc_stringTruncatedAtNull];
    XCTAssert(string.length == 2);
    XCTAssertEqualObjects(string, @"01");

    string = @"";
    NSString *test = @"";
    string = [string bnc_stringTruncatedAtNull];
    XCTAssertEqualObjects(string, test);

    char byte2[] = "\x00\x31\x00\x32\x33\x34\x35\x36";
      data = [NSData dataWithBytes:byte2 length:sizeof(byte2)];
    string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    XCTAssert(string && string.length == 9);
    string = [string bnc_stringTruncatedAtNull];
    XCTAssert(string && string.length == 0);

    string = @"No truncate";
      test = @"No truncate";
    string = [string bnc_stringTruncatedAtNull];
    XCTAssertEqualObjects(string, test);
}

@end
