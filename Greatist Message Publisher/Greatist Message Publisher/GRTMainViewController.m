//
//  GRTMainViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTMainViewController.h"
#import "GRTDataStore.h"
#import "Post+Methods.h"
#import "GRTPostTableViewCell.h"

@interface GRTMainViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *composePostButton;
- (IBAction)composePostButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *postsTableView;


@property (strong, nonatomic) GRTDataStore *dataStore;

@end

@implementation GRTMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.postsTableView registerNib:[UINib nibWithNibName:@"GRTTableViewCell" bundle:nil] forCellReuseIdentifier:@"postCell"];
    
    self.dataStore = [GRTDataStore sharedDataStore];
    
    self.postsTableView.delegate = self;
    self.postsTableView.dataSource = self;
    self.dataStore.postFRController.delegate = self;

    UIImage *navBar = [UIImage imageNamed:@"navBar.png"];
    [self.navigationController.navigationBar setBackgroundImage:navBar forBarMetrics:UIBarMetricsDefault];
    
    UIImage *greatistLogoImage = [UIImage imageNamed:@"Greatist_Logo86x50"];
    UIImage *scaledGreatistLogoImage = [UIImage imageWithImage:greatistLogoImage scaledToSize:CGSizeMake(65, 38)];
    UIImageView *greatistLogoView = [[UIImageView alloc] initWithImage:scaledGreatistLogoImage];
    [self.navigationController.navigationBar.topItem setTitleView:greatistLogoView];
    
    FAKFontAwesome *composePostIcon = [FAKFontAwesome pencilSquareOIconWithSize:40];
    [composePostIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistBlueColor]];
    UIImage *composePostImage = [composePostIcon imageWithSize:CGSizeMake(40, 40)];
    composePostIcon.iconFontSize = 40;
    
    [self.composePostButton setImage:composePostImage];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Methods


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GRTPostTableViewCell *cell = [self configureCellForMainTableViewWithIndexPath:indexPath];
    Post *post = [self.dataStore.postFRController objectAtIndexPath:indexPath];
    [cell configureWithPost:post];
//    cell.postLabel.text= @"random string";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataStore.postFRController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataStore.postFRController.sections[section] numberOfObjects];
    //return 20;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - FetchedResultsController Methods


- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.postsTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.postsTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.postsTableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCellForMainTableViewWithIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.postsTableView endUpdates];
}

#pragma mark - Button Methods

- (IBAction)composePostButtonTapped:(id)sender {

}

#pragma mark - Cell Methods


- (GRTPostTableViewCell *) configureCellForMainTableViewWithIndexPath: (NSIndexPath *)indexPath
{
    GRTPostTableViewCell *cell = [self.postsTableView dequeueReusableCellWithIdentifier:@"postCell"];
    Post *post = [self.dataStore.postFRController objectAtIndexPath:indexPath];
    [cell configureWithPost:post];

    cell.backgroundColor = [UIColor greatistPlayColor];
        
//    UIView *blueView = [UIView new];
//    blueView.backgroundColor = [UIColor greatistBlueColor];
//    cell.backgroundView = blueView;
    
    return cell;
}
@end
