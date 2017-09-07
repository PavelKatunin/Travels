#import "GETravel.h"

@interface GETravel ()

@property(copy) NSNumber *identifier;
@property(copy) NSString *imageUrl;
@property(assign) double priceEur;
@property(copy) NSDate *departureTime;
@property(copy) NSDate *arrivalTime;
@property(assign) NSInteger numberOfStops;

@end

@implementation GETravel

#pragma mark - Initialization

- (instancetype)initWithId:(NSNumber *)identifier
                  imageUrl:(NSString *)imageUrl
                  priceEur:(double)priceEur
             departureTime:(NSDate *)departureTime
               arrivalTime:(NSDate *)arrivalTime
             numberOfStops:(NSInteger)numberOfStops {
    self = [super init];
    
    if (self) {
        self.identifier = identifier;
        self.imageUrl = imageUrl;
        self.priceEur = priceEur;
        self.departureTime = departureTime;
        self.arrivalTime = arrivalTime;
        self.numberOfStops = numberOfStops;
    }
    return self;
}

@end
