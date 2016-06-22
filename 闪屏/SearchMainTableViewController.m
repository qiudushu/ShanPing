//
//  SearchMainTableViewController.m
//  UISearchController&UISearchDisplayController
//
//  Created by zml on 15/12/2.
//  Copyright © 2015年 zml@lanmaq.com. All rights reserved.
//
#import "AppDelegate.h"
#import "SearchMainTableViewController.h"
#import "SearchResultTableViewController.h"
#import "DemoModel.h"
#import "DemoCell.h"

@interface SearchMainTableViewController ()<UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

// search results table view
@property (nonatomic, strong) SearchResultTableViewController *resultsTableController;

@property (nonatomic, strong) UISearchController *searchController;

// for state restoration
@property BOOL searchControllerWasActive;
@property BOOL searchControllerSearchFieldWasFirstResponder;

@property (nonatomic, strong) NSArray *models;

@end

@implementation SearchMainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"－－－－－卧槽－－－－－－－");
    
    self.models =  ((AppDelegate *)[UIApplication sharedApplication].delegate).dataManager.testDataArray;
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _resultsTableController = [[SearchResultTableViewController alloc] init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.placeholder = NSLocalizedString(@"UISearchController", @"please add string file");
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // we want to be the delegate for our filtered table so didSelectRowAtIndexPath is called for both tables
    self.resultsTableController.tableView.delegate = self;
    self.searchController.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = NO; // default is YES
    self.searchController.searchBar.delegate = self; // so we can monitor text changes + others
    
    // Search is now just presenting a view controller. As such, normal view controller
    // presentation semantics apply. Namely that presentation will walk up the view controller
    // hierarchy until it finds the root view controller or one that defines a presentation context.
    //
    self.definesPresentationContext = YES;  // know where you want UISearchController to be displayed
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UISearchBarDelegate (which you use ,which you choose!!)
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar                   // return NO to not become first responder
{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar                    // called when text starts editing
{
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar                       // return NO to not resign first responder
{
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar                     // called when text ends editing
{
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText   // called when text changes (including clear)
{
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0) // called before text changes
{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar                    // called when keyboard search button pressed
{
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar                   // called when bookmark button pressed
{
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar                     // called when cancel button pressed
{
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar NS_AVAILABLE_IOS(3_2) // called when search results button pressed
{
}
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope NS_AVAILABLE_IOS(3_0){

}

#pragma mark - UISearchControllerDelegate  (which you use ,which you choose!!)
// These methods are called when automatic presentation or dismissal occurs. They will not be called if you present or dismiss the search controller yourself.
- (void)willPresentSearchController:(UISearchController *)searchController{
    // do something before the search controller is presented 
}
- (void)didPresentSearchController:(UISearchController *)searchController{
}
- (void)willDismissSearchController:(UISearchController *)searchController{
}
- (void)didDismissSearchController:(UISearchController *)searchController{
}

// Called after the search controller's search bar has agreed to begin editing or when 'active' is set to YES. If you choose not to present the controller yourself or do not implement this method, a default presentation is performed on your behalf.
- (void)presentSearchController:(UISearchController *)searchController{

}
#pragma mark - UISearchResultsUpdating  (which you use ,which you choose!!)
// Called when the search bar's text or scope has changed or when the search bar becomes first responder.
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    // update the filtered array based on the search text
    NSString *searchText = searchController.searchBar.text;
    NSMutableArray *searchResults = [self.models mutableCopy];
    
    // strip out all the leading and trailing spaces
    NSString *strippedString = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    // break up the search terms (separated by spaces)
    NSArray *searchItems = nil;
    if (strippedString.length > 0) {
        searchItems = [strippedString componentsSeparatedByString:@" "];
    }
    
    // build all the "AND" expressions for each value in the searchString
    //
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    for (NSString *searchString in searchItems) {
        // each searchString creates an OR predicate for: name, id
        //
        // example if searchItems contains "iphone 599 2007":
        //      name CONTAINS[c] "lanmaq"
        //      id CONTAINS[c] "1568689942"
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        
        // use NSExpression represent expressions in predicates.
        // NSPredicate is made up of smaller, atomic parts: two NSExpressions (a left-hand value and a right-hand value)
        
        // friendName field matching
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"friendName"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        // friendId field matching
        
      lhs = [NSExpression expressionForKeyPath:@"friendId"];
      rhs = [NSExpression expressionForConstantValue:searchString];
      finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];

 
        
        // at this OR predicate to our master AND predicate
        NSCompoundPredicate *orMatchPredicates = [NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    // match up the fields of the Product object
    NSCompoundPredicate *finalCompoundPredicate =
    [NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    searchResults = [[searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];
    
    // hand over the filtered results to our search results table
    SearchResultTableViewController *tableController = (SearchResultTableViewController *)self.searchController.searchResultsController;
    tableController.filteredModels = searchResults;
    [tableController.tableView reloadData];

}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DemoCell *cell =  (DemoCell *)[self.tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    DemoModel *model = [self.models objectAtIndex:indexPath.row];
    [self configureCell:cell forModel:model];
    
    return cell;
}
@end
