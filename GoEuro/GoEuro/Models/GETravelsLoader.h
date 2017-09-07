#import <Foundation/Foundation.h>
#import "GETravelsParser.h"
#import "GETravel.h"
#import "GEDataLoader.h"

/* A service for loading travels */
@interface GETravelsLoader : NSObject

// TODO: nullability

- (instancetype)initWithDataLoader:(id <GEDataLoader>)dataLoader
                            parser:(id <GETravelsParser>)parser;

- (void)loadTravelsSuccess:(void (^)(NSArray<GETravel *> *travels))success
                      fail:(void (^)(NSError *error))fail
               targetQueue:(dispatch_queue_t)queue;

@end
