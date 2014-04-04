//
//  GRTComposePostViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTComposePostViewController.h"
#import "GRTDataStore.h"
#import "Post+Methods.h"
#import "Section+Methods.h"

@interface GRTComposePostViewController ()

@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (weak, nonatomic) IBOutlet UIView *postView;
- (IBAction)backButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *leftQuoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightQuoteLabel;
@property (strong, nonatomic) Section *verticalSelected;
@property (strong, nonatomic) UIButton *eatButton;
@property (strong, nonatomic) NSArray *verticalButtons;


- (IBAction)postButton:(id)sender;

@property (strong, nonatomic) GRTDataStore *dataStore;

@end

@implementation GRTComposePostViewController

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
    
    //self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:65/255.0 green:64/255.0 blue:66/255.0 alpha:1.0];
    
    UIImage *navBar = [UIImage imageNamed:@"navBar.png"];
    [self.navigationController.navigationBar setBackgroundImage:navBar forBarMetrics:UIBarMetricsDefault];
    
//    self.navigationController.toolbar.backgroundColor = [UIColor colorWithRed:65/255.0 green:64/255.0 blue:66/255.0 alpha:1.0];
    
    self.postContentTextView.delegate = self;
    [self.postContentTextView setTextColor:[UIColor colorWithRed:65/255 green:64/255.0 blue:66/255.0 alpha:1.0]];
    [[self.postContentTextView layer] setBorderColor:[[UIColor colorWithRed:65/255 green:64/255.0 blue:66/255.0 alpha:1.0] CGColor]];
    [[self.postContentTextView layer] setBorderWidth:1];
    [[self.postContentTextView layer] setCornerRadius:15];
    self.postContentTextView.textContainerInset = UIEdgeInsetsMake(15.0, 10.0, 15.0, 10.0);
    self.leftQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    self.rightQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    // Do any additional setup after loading the view.
    self.dataStore = [GRTDataStore sharedDataStore];
    self.view.backgroundColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];

    [self setupCategoryButtons];
    [self setupPostContent];
    [self setupPostButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    NSLog(@"%@", textView.text);
    [textView setTextColor:[UIColor greatistLightGrayColor]];
    [textView setText:@""];
}

- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods
- (void)setupCategoryButtons
{
    UIButton *eatButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [eatButton setFrame:CGRectMake(65, 20, 30, 30)];
    [eatButton setBackgroundImage:[UIImage imageNamed:@"Eat_Colored60x60"] forState:UIControlStateNormal];
    eatButton.alpha = 0.3;
    [eatButton addTarget:self action:@selector(eatButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:eatButton];
    
    UILabel *eatLabel = [[UILabel alloc] initWithFrame:CGRectMake(6, 25, 30, 30)];
    [eatLabel setText:@"EAT"];
    [eatLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [eatLabel setTextColor:[UIColor greatistEatColor]];
    [eatButton addSubview:eatLabel];
    
    UIButton *growButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [growButton setFrame:CGRectMake(115, 20, 30, 30)];
    [growButton setBackgroundImage:[UIImage imageNamed:@"Grow_Colored60x60"] forState:UIControlStateNormal];
    growButton.alpha = 0.3;
    [growButton addTarget:self action:@selector(growButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:growButton];
    
    UILabel *growLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 25, 30, 30)];
    [growLabel setText:@"GROW"];
    [growLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [growLabel setTextColor:[UIColor greatistGrowColor]];
    [growButton addSubview:growLabel];
    
    UIButton *moveButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [moveButton setFrame:CGRectMake(165, 20, 30, 30)];
    [moveButton setBackgroundImage:[UIImage imageNamed:@"Move_Colored60x60"] forState:UIControlStateNormal];
    moveButton.alpha = 0.3;
    [moveButton addTarget:self action:@selector(moveButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:moveButton];
    
    UILabel *moveLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 25, 30, 30)];
    [moveLabel setText:@"MOVE"];
    [moveLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [moveLabel setTextColor:[UIColor greatistMoveColor]];
    [moveButton addSubview:moveLabel];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playButton setFrame:CGRectMake(215, 20, 30, 30)];
    [playButton setBackgroundImage:[UIImage imageNamed:@"Play_Colored60x60"] forState:UIControlStateNormal];
    playButton.alpha = 0.3;
    [playButton addTarget:self action:@selector(playButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.postView addSubview:playButton];
    
    UILabel *playLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 25, 30, 30)];
    [playLabel setText:@"PLAY"];
    [playLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
    [playLabel setTextColor:[UIColor greatistPlayColor]];
    [playButton addSubview:playLabel];
    
    
    self.verticalButtons = @[playButton, eatButton, moveButton, growButton];
    
}

- (void)setupPostContent
{
    self.postContentTextView.delegate = self;
    [self.postContentTextView setFrame:CGRectMake(0, 0, 320, 320)];
    [self.postContentTextView setTextColor:[UIColor greatistPrimaryColor]];
    [[self.postContentTextView layer] setBorderColor:[[UIColor greatistLightGrayColor] CGColor]];
    [[self.postContentTextView layer] setBorderWidth:1];
    [[self.postContentTextView layer] setCornerRadius:15];
    self.postContentTextView.textContainerInset = UIEdgeInsetsMake(15.0, 10.0, 15.0, 10.0);
    
    self.leftQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
    self.rightQuoteLabel.font = [UIFont fontWithName:@"ArcherPro-Semibold" size:40];
}

-(void)setupPostButton
{
    UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *resizedPostImage = [UIImage imageWithImage:[UIImage imageNamed:@"Greatist_Logo_Badge_Blue"] scaledToSize:CGSizeMake(50, 50)];
    [postButton setBackgroundImage:resizedPostImage forState:UIControlStateNormal];
    [postButton setFrame:CGRectMake(145, 250, 30, 30)];
    [self.postView addSubview:postButton];
}




- (IBAction)postButton:(id)sender
{
    [Post postWithContent:self.postContentTextView.text author:nil section:self.verticalSelected responses:nil inContext:self.dataStore.managedObjectContext];
    [self.dataStore saveContext];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void) verticalButtonTapped:(UIButton *)sender
{

}

-(void) playButtonTapped: (UIButton *)sender
{
    NSString *nameSought = @"Play";
    NSPredicate *playSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
    NSArray *playVerticals = [self.verticals filteredArrayUsingPredicate:playSearch];
    self.verticalSelected= playVerticals[0];

    UIButton *playButton = self.verticalButtons[0];
    playButton.alpha = 1.0;
    UIButton *moveButton = self.verticalButtons[2];
    moveButton.alpha = 0.5;
    UIButton *eatButton = self.verticalButtons[1];
    eatButton.alpha = 0.5;
    UIButton *growButton = self.verticalButtons[3];
    growButton.alpha = 0.5;
    
    
}

-(void) moveButtonTapped: (UIButton *)sender
{
     NSString *nameSought = @"Move";
    NSPredicate *moveSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
    NSArray *moveVerticals = [self.verticals filteredArrayUsingPredicate:moveSearch];
    self.verticalSelected= moveVerticals[0];
    
    UIButton *playButton = self.verticalButtons[0];
    playButton.alpha = 0.5;
    UIButton *moveButton = self.verticalButtons[2];
    moveButton.alpha = 1.0;
    UIButton *eatButton = self.verticalButtons[1];
    eatButton.alpha = 0.5;
    UIButton *growButton = self.verticalButtons[3];
    growButton.alpha = 0.5;
    
}

-(void) eatButtonTapped: (UIButton *)sender
{
    NSString *nameSought = @"Eat";
    NSPredicate *eatSearch = [NSPredicate predicateWithFormat:@"name==%@",nameSought];
    NSArray *eatVerticals = [self.verticals filteredArrayUsingPredicate:eatSearch];
    self.verticalSelected= eatVerticals[0];
    
    UIButton *playButton = self.verticalButtons[0];
    playButton.alpha = 0.5;
    UIButton *moveButton = self.verticalButtons[2];
    moveButton.alpha = 0.5;
    UIButton *eatButton = self.verticalButtons[1];
    eatButton.alpha = 1.0;
    UIButton *growButton = self.verticalButtons[3];
    growButton.alpha = 0.5;
   

    
}

-(void) growButtonTapped: (UIButton *)sender
{
     NSString *nameSought = @"Grow";
    NSPredicate *growSearch = [NSPredicate predicateWithFormat:@"name==%@", nameSought];
    NSArray *growVerticals = [self.verticals filteredArrayUsingPredicate:growSearch];
    self.verticalSelected= growVerticals[0];
    
    UIButton *playButton = self.verticalButtons[0];
    playButton.alpha = 0.5;
    UIButton *moveButton = self.verticalButtons[2];
    moveButton.alpha = 0.5;
    UIButton *eatButton = self.verticalButtons[1];
    eatButton.alpha = 0.5;
    UIButton *growButton = self.verticalButtons[3];
    growButton.alpha = 1.0;
}

















@end
