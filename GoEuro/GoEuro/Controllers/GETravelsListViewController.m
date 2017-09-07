#import "GETravelsListViewController.h"
#import "GETravelsLoader.h"
#import "GETravel.h"
#import "GETravelTableViewCell.h"
#import "NSLayoutConstraint+Helpers.h"

static NSString *const kTravelCellIdentifier = @"TravelCell";

@interface GETravelsListViewController () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) GETravelsLoader *travelsLoader;
@property(nonatomic, strong) NSArray<GETravel *> *travels;

@end

// TODO: add custom cell

@implementation GETravelsListViewController

#pragma mark - Initialization

- (instancetype)initWithTravelsLoader:(GETravelsLoader *)travelsLoader {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.travelsLoader = travelsLoader;
    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // TODO: move to loadView
    UITableView *tableView = [self createTableView];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    [self.view addConstraints:[self createConstraints]];
    
    [self updateTravels];
    
    self.view.backgroundColor = [UIColor greenColor];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.travels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kTravelCellIdentifier
                                                                 forIndexPath:indexPath];
    
    cell.textLabel.text = self.travels[indexPath.row].imageUrl;
    
    return cell;
}

#pragma mark - Private methods

- (void)updateTravels {
    [self.travelsLoader loadTravelsSuccess:^(NSArray<GETravel *> *travels) {
        self.travels = travels;
        [self.tableView reloadData];
    } fail:^(NSError *error) {
            // TODO: handle
    } targetQueue:dispatch_get_main_queue()];
}

- (UITableView *)createTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTravelCellIdentifier];
    return tableView;
}

- (NSArray *)createConstraints {
    return [NSLayoutConstraint constraintsForWrappedSubview:self.tableView
                                                 withInsets:UIEdgeInsetsZero];
}

@end
