#import <XCTest/XCTest.h>
#import "GETravelsLoader.h"
#import "GELocalDataLoader.h"
#import "GEJSONTravelsParser.h"

@interface GETravelsLoaderTests : XCTestCase

@end

@implementation GETravelsLoaderTests

- (void)testReachableLocalFileForDownload {
    
    NSString *filePath =
        [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"testTravels.json"];
    XCTAssertNotNil(filePath);
    
    GEJSONTravelsParser *parser = [[GEJSONTravelsParser alloc] init];
    GELocalDataLoader *localDataLoader = [[GELocalDataLoader alloc] initWithURLString:filePath];
    
    GETravelsLoader *travelsLoader = [[GETravelsLoader alloc] initWithDataLoader:localDataLoader
                                                                          parser:parser];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Travels Loader"];
    
    [travelsLoader loadTravelsSuccess:^(NSArray<GETravel *> *travels) {
        XCTAssertNotNil(travels);
        XCTAssertEqual(30, travels.count);
        [expectation fulfill];
    } fail:^(NSError *error) {

    } targetQueue:dispatch_get_main_queue()];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
}

- (void)testErrorCases {
    
    NSString *filePath =
        [[[NSBundle bundleForClass:[self class]] resourcePath] stringByAppendingPathComponent:@"000"];
    XCTAssertNotNil(filePath);
    
    GEJSONTravelsParser *parser = [[GEJSONTravelsParser alloc] init];
    GELocalDataLoader *localDataLoader = [[GELocalDataLoader alloc] initWithURLString:filePath];
    
    GETravelsLoader *travelsLoader = [[GETravelsLoader alloc] initWithDataLoader:localDataLoader
                                                                          parser:parser];
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Async Travels Loader"];
    
    [travelsLoader loadTravelsSuccess:^(NSArray<GETravel *> *travels) {
        
    } fail:^(NSError *error) {
        XCTAssertNotNil(error);
        [expectation fulfill];
    } targetQueue:dispatch_get_main_queue()];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        
        if(error)
        {
            XCTFail(@"Expectation Failed with error: %@", error);
        }
        
    }];
}

@end
