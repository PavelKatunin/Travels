#import <XCTest/XCTest.h>
#import "GEJSONTravelsParser.h"

@interface GEJSONTravelsParserTests : XCTestCase

@end

@implementation GEJSONTravelsParserTests

- (NSData *)dataFromLocalFile:(NSString *)fileName {
    NSString *filePath =
        [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:fileName];
    XCTAssertNotNil(filePath);
    
    return [NSData dataWithContentsOfFile:filePath];
}

- (void)testCorrectTravelsJSON {
    
    GEJSONTravelsParser *parser = [[GEJSONTravelsParser alloc] init];
    
    NSError *error = nil;
    NSArray *travels = [parser parseTravels:[self dataFromLocalFile:@"testTravels.json"]
                                      error:&error];
    
    XCTAssertEqual(30, travels.count);
    
    [travels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XCTAssertTrue([obj isKindOfClass:[GETravel class]]);
        GETravel *travel = (GETravel *)obj;
        if ([travel.identifier isEqual:@(3)]) {
            XCTAssertEqualObjects(travel.imageUrl, @"http://cdn-goeuro.com/static_content/web/logos/{size}/air_berlin.png");
            XCTAssertEqual(travel.priceEur, 21.99);
            XCTAssertEqual(travel.numberOfStops, 1);
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            
            NSDateComponents *departureComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute)
                                                       fromDate:travel.departureTime];
            NSInteger departureHour = [departureComponents hour];
            NSInteger departureMinute = [departureComponents minute];
            
            XCTAssertEqual(departureHour, 4);
            XCTAssertEqual(departureMinute, 25);
            
            NSDateComponents *arrivalComponents = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute)
                                                                fromDate:travel.arrivalTime];
            NSInteger arrivalHour = [arrivalComponents hour];
            NSInteger arrivalMinute = [arrivalComponents minute];
            
            XCTAssertEqual(arrivalHour, 17);
            XCTAssertEqual(arrivalMinute, 33);
        }
    }];
    
    XCTAssertNil(error);
}

- (void)testIncorrectJSONFormat {
    
    GEJSONTravelsParser *parser = [[GEJSONTravelsParser alloc] init];
    
    NSError *error = nil;
    NSArray *travels = [parser parseTravels:[self dataFromLocalFile:@"incorrectJSONTestTravels.json"]
                                      error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(travels);
}

- (void)testIncorrectAPIFormat {
    
    GEJSONTravelsParser *parser = [[GEJSONTravelsParser alloc] init];
    
    NSError *error = nil;
    NSArray *travels = [parser parseTravels:[self dataFromLocalFile:@"incorrectAPITestTravels.json"]
                                      error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(travels);
}

- (void)testParseNilValueAttempt {
    
    GEJSONTravelsParser *parser = [[GEJSONTravelsParser alloc] init];
    
    NSError *error = nil;
    NSArray *travels = [parser parseTravels:nil
                                      error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertNil(travels);
}

@end
