#import "GETravelsLoader.h"

@interface GETravelsLoader ()

@property(nonatomic, strong) id <GETravelsParser> parser;
@property(nonatomic, strong) id <GEDataLoader> dataLoader;

@end

@implementation GETravelsLoader

- (instancetype)initWithDataLoader:(id <GEDataLoader>)dataLoader
                            parser:(id <GETravelsParser>)parser {
    self = [super init];
    if (self) {
        self.dataLoader = dataLoader;
        self.parser = parser;
    }
    return self;
}

- (void)loadTravelsSuccess:(void (^)(NSArray<GETravel *> *travels))success
                      fail:(void (^)(NSError *error))fail
               targetQueue:(dispatch_queue_t)queue {
    
    [self.dataLoader loadDataSuccess:^(NSData *data) {
        dispatch_async(queue, ^{
            NSError *error = nil;
            success([self.parser parseTravels:data
                                        error:&error]);
        });
    } fail:fail
    targetQueue:queue];
}

@end
