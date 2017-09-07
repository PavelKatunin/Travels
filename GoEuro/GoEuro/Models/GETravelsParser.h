#import <Foundation/Foundation.h>
#import "GETravel.h"

@protocol GETravelsParser <NSObject>

// TODO: nullability

- (NSArray<GETravel *> *)parseTravels:(NSData *)data error:(NSError **)error;

@end
