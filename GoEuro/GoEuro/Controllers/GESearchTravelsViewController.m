#import "GESearchTravelsViewController.h"
#import "GETravelsListViewController.h"
#import "GEJSONTravelsParser.h"
#import "NSLayoutConstraint+Helpers.h"
#import "GERemoteDataLoader.h"

@interface GESearchTravelsViewController ()

@property(nonatomic, weak) UISegmentedControl *travelTypeSegmentedControl;
@property(nonatomic, weak) UIView *travelsListContainerView;
@property(nonatomic, weak) UIViewController *currentChildViewController;

@end

@implementation GESearchTravelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISegmentedControl *travelTypeSegmentedControl = [self createTravelTypeSegmentedControl];
    self.travelTypeSegmentedControl = travelTypeSegmentedControl;
    [self.view addSubview:travelTypeSegmentedControl];
    
    UIView *travelsListContainerView = [self createTravelsListContainerView];
    self.travelsListContainerView = travelsListContainerView;
    [self.view addSubview:travelsListContainerView];

    [self setupInitialChildController];
    
    [self.view addConstraints:[self createConstraints]];
}

#pragma mark - Private

- (void)setupInitialChildController {
    GEJSONTravelsParser *parser = [[GEJSONTravelsParser alloc] init];
    
    GERemoteDataLoader *remoteDataLoader = [[GERemoteDataLoader alloc] initWithURLString:@"https://api.myjson.com/bins/w60i"];
    
    GETravelsLoader *travelsLoader = [[GETravelsLoader alloc] initWithDataLoader:remoteDataLoader
                                                                          parser:parser];
    
    UIViewController *initialController = [[GETravelsListViewController alloc] initWithTravelsLoader:travelsLoader];
    
    [initialController willMoveToParentViewController:self];
    [self addChildViewController:initialController];
    initialController.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.travelsListContainerView addSubview:initialController.view];
    [self.travelsListContainerView addConstraints:[NSLayoutConstraint constraintsForWrappedSubview:initialController.view
                                                                                        withInsets:UIEdgeInsetsZero]];
    
    [initialController didMoveToParentViewController:self];
    self.currentChildViewController = initialController;
}

- (UISegmentedControl *)createTravelTypeSegmentedControl {
    UISegmentedControl *travelTypeControl =
        [[UISegmentedControl alloc] initWithItems:@[@"Train",
                                                    @"Bus",
                                                    @"Flight"]];
    
    travelTypeControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [travelTypeControl addTarget:self
                          action:@selector(changeTravelType:)
                forControlEvents:UIControlEventValueChanged];
    
    return travelTypeControl;
}

- (UIView *)createTravelsListContainerView {
    UIView *containerView = [[UIView alloc] init];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    containerView.backgroundColor = [UIColor redColor];
    return containerView;
}

- (NSArray *)createConstraints {
    NSMutableArray *resultConstraints = [[NSMutableArray alloc] init];
    
    NSArray *horizontalSegmentedControlConstraints =
        [NSLayoutConstraint horizontalConstraintsForWrappedSubview:self.travelTypeSegmentedControl
                                                        withInsets:UIEdgeInsetsZero];
    
    
    [resultConstraints addObjectsFromArray:horizontalSegmentedControlConstraints];
    
    NSArray *horizontalContainerConstraints =
        [NSLayoutConstraint horizontalConstraintsForWrappedSubview:self.travelsListContainerView
                                                        withInsets:UIEdgeInsetsZero];
    
    [resultConstraints addObjectsFromArray:horizontalContainerConstraints];
    
    NSArray *verticalConstraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_travelTypeSegmentedControl]-[_travelsListContainerView]-|"
                                                options:0
                                                metrics:nil
                                                  views:NSDictionaryOfVariableBindings(_travelsListContainerView,
                                                                                       _travelTypeSegmentedControl)];
    
    [resultConstraints addObjectsFromArray:verticalConstraints];
    
    return resultConstraints;
}

- (void)changeTravelType:(id)sender {
    
}


@end
