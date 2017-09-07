#import <Foundation/Foundation.h>

// TODO: nullability

@interface GETravel : NSObject

@property(copy, readonly) NSNumber *identifier;
@property(copy, readonly) NSString *imageUrl;
@property(assign, readonly) double priceEur;
@property(copy, readonly) NSDate *departureTime;
@property(copy, readonly) NSDate *arrivalTime;
@property(assign, readonly) NSInteger numberOfStops;

- (instancetype)initWithId:(NSNumber *)identifier
                  imageUrl:(NSString *)imageUrl
                  priceEur:(double)priceEur
             departureTime:(NSDate *)departureTime
               arrivalTime:(NSDate *)arrivalTime
             numberOfStops:(NSInteger)numberOfStops;

@end
