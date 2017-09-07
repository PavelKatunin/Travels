#import "GEJSONTravelsParser.h"

@implementation GEJSONTravelsParser

#pragma mark - Public methods

- (NSArray<GETravel *> *)parseTravels:(NSData *)data error:(NSError **)errorPointer {
    NSError *error = nil;
    
    __block NSMutableArray *travelsArray = nil;
    
    if (!data) {
        // TODO: implement correct error
        *errorPointer = [[NSError alloc] initWithDomain:@"NilData"
                                                   code:1
                                               userInfo:@{}];
    }
    else {
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (error != nil) {
            *errorPointer = error;
        }
        else {
            travelsArray = [[NSMutableArray alloc] initWithCapacity:jsonArray.count];
            [jsonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSDictionary class]]) {
                    [travelsArray addObject:[self travelFromDictionary:obj]];
                }
                else {
                    // TODO: implement correct error
                    *errorPointer = [[NSError alloc] initWithDomain:@"ParserError"
                                                               code:1
                                                           userInfo:@{}];
                    travelsArray = nil;
                    *stop = YES;
                }
            }];
        }
    }
    
    return travelsArray;
}

#pragma mark - Private methods

- (GETravel *)travelFromDictionary:(NSDictionary *)dictionary {
    
    NSNumber *identifier = dictionary[@"id"];
    NSString *url = dictionary[@"provider_logo"];
    double price = ((NSNumber *)dictionary[@"price_in_euros"]).doubleValue;
    NSInteger numberOfStops = ((NSNumber *)dictionary[@"number_of_stops"]).integerValue;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
    NSDate *departureTime = [formatter dateFromString:dictionary[@"departure_time"]];
    NSDate *arrivalTime = [formatter dateFromString:dictionary[@"arrival_time"]];
    
    // TODO: implement dates  formatter
    
    return [[GETravel alloc] initWithId:identifier
                               imageUrl:url
                               priceEur:price
                          departureTime:departureTime
                            arrivalTime:arrivalTime
                          numberOfStops:numberOfStops];
}

@end
