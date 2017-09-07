#import <XCTest/XCTest.h>
#import "GETravel.h"

@interface GETravelTests : XCTestCase

@end

@implementation GETravelTests

- (void)testTravelInitialization {
    GETravel *travel = [[GETravel alloc] initWithId:@(1)
                                           imageUrl:@"https://google.com"
                                           priceEur:13
                                      departureTime:[NSDate date]
                                        arrivalTime:[NSDate date]
                                      numberOfStops:1];
    
    XCTAssertNotNil(travel);
}

- (void)testTravelProperties {
    NSNumber *identifier = @(2);
    NSString *imageURL = @"https://google2.com";
    double price = 100;
    NSDate *departureTime = [NSDate dateWithTimeIntervalSince1970:100000.];
    NSDate *arrivalTime = [NSDate dateWithTimeIntervalSince1970:100030.];
    NSInteger numberOfStops = 1;
    
    GETravel *travel = [[GETravel alloc] initWithId:identifier
                                           imageUrl:imageURL
                                           priceEur:price
                                      departureTime:departureTime
                                        arrivalTime:arrivalTime
                                      numberOfStops:numberOfStops];
    
    XCTAssertNotNil(travel);
    
    XCTAssertEqualObjects(identifier, travel.identifier);
    XCTAssertEqualObjects(imageURL, travel.imageUrl);
    XCTAssertEqual(price, travel.priceEur);
    XCTAssertEqualObjects(departureTime, travel.departureTime);
    XCTAssertEqualObjects(arrivalTime, travel.arrivalTime);
    XCTAssertEqual(numberOfStops, travel.numberOfStops);
}

@end
