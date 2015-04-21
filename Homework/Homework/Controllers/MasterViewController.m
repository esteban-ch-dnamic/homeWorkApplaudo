//
//  MasterViewController.m
//  Homework
//
//  Created by Esteban Chavarria Solano on 4/20/15.
//  Copyright (c) 2015 Phunware. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"

#import "VenuesAPI.h"
#import "VenueVO.h"
#import "Model.h"

@interface MasterViewController ()

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic,weak) IBOutlet UITableView *tableView;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    [[VenuesAPI sharedInstance]requestVenuesWithCompletionHandler:^(BOOL succes, NSError *error) {
        if (succes) {
            [self.tableView reloadData];
            [self.detailViewController setVenueVO:[Model sharedInstance].venuesArray[0]];
        }else{
            [[[UIAlertView alloc]initWithTitle:@"Ooppsss...!" message:@"We couldn't load the venues" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil]show];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        VenueVO *venueVO = [Model sharedInstance].venuesArray[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setVenueVO:venueVO];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [Model sharedInstance].venuesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    VenueVO *venueVO = [Model sharedInstance].venuesArray[indexPath.row];
    cell.textLabel.text = venueVO.name;
    cell.detailTextLabel.text = venueVO.address;
    return cell;
}

@end
