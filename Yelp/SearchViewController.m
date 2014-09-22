//
//  SearchViewController.m
//  Yelp
//
//  Created by Jianbao Tao on 9/20/14.
//  Copyright (c) 2014 ___JimTao___. All rights reserved.
//

#import "SearchViewController.h"
#import "YelpClient.h"
#import "SearchResultCell.h"
#import "BusinessItem.h"
#import "UIImageView+AFNetworking.h"

NSString *const initSearch = @"Restaurants";

@interface SearchViewController ()

@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *businesses;

@end

@implementation SearchViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    BusinessItem *item = self.businesses[indexPath.row];
    cell.nameLabel.text = item.name;
    [cell.previewImage setImageWithURL:[NSURL URLWithString:item.imageUrl]];
    [cell.ratingImage setImageWithURL:[NSURL URLWithString:item.ratingImgUrl]];
    cell.reviewsLabel.text = [NSString stringWithFormat:@"%d Reviews", item.reviewCount];
    cell.addressLabel.text = [NSString stringWithFormat:@"%@",
                              [self getAddress:item.displayAddress]];
    NSLog(@"%@", item.displayAddress);
    
    return  cell;
}

- (NSString *) getAddress: (NSArray *) displayAddress {
    NSMutableString *label = [[NSMutableString alloc] initWithString:displayAddress[0]];
    
    for (int i = 1; i < displayAddress.count; i++) {
        [label appendString:@", "];
        [label appendString:displayAddress[i]];
    }
    return [label mutableCopy];
}

// intialize the search bar
-(void) createSearchBar {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(-5.0, 0.0, 320.0, 44.0)];
    self.searchBar = searchBar;
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.text = initSearch;
    UIView *searchBarView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 310.0, 44.0)];
    searchBar.delegate = self;

    [searchBarView addSubview:searchBar];
    self.navigationItem.titleView = searchBarView;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:(UIBarButtonItemStylePlain)
                                                                 target:self action:@selector(onFilterButton)];
}

-(void) onFilterButton {
    NSLog(@"Filter button tapped");
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    NSLog(@"search bar should begin editing");
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText {

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
        NSLog(@"searching %@", searchBar.text);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 90.0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultCell" bundle:nil]
         forCellReuseIdentifier:@"SearchResultCell"];
    
    self.client = [YelpClient createHeadlessInstance];
    
    [self.client searchWithTerm:initSearch success:^(AFHTTPRequestOperation *operation, id response) {
        [self updateBusinessesFromResponse:response];
        NSLog(@"number of businesses found: %ld", self.businesses.count);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateBusinessesFromResponse:(id) response {
    NSArray *businesses = response[@"businesses"];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < businesses.count; i++) {
        BusinessItem *item = [self createBusinessItemFromResponse:businesses[i]];
        [array addObject:item];
    }
    self.businesses = array;
}


- (BusinessItem *) createBusinessItemFromResponse:(id) itemResponse {
    BusinessItem *item = [[BusinessItem alloc] init];
    item.name = itemResponse[@"name"];
    item.imageUrl = itemResponse[@"image_url"];
    item.ratingImgUrl = itemResponse[@"rating_img_url"];
    item.reviewCount = [itemResponse[@"review_count"] intValue];
    item.city = [itemResponse valueForKeyPath:@"location.city"];
    item.displayAddress = [itemResponse valueForKeyPath:@"location.display_address"];


    
    return item;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
