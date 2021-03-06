//
//  GRTPostDetailViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTPostDetailViewController.h"
#import "GRTDataStore.h"
#import "GRTDataManager.h"

@interface GRTPostDetailViewController ()

@property (strong, nonatomic) GRTDataStore *dataStore;
@property (strong, nonatomic) UIScrollView *mainScrollView;
@property (strong, nonatomic) UIView *postDetailView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (strong, nonatomic) UIView *responseView;
@property (strong, nonatomic) NSMutableArray *responseArray;
@property (strong, nonatomic) NSMutableArray *responseLabelsArray;
@property (strong, nonatomic) NSMutableArray *responseLabelFramesArray;
@property (strong, nonatomic) NSMutableArray *responseButtonFramesArray;
@property (strong, nonatomic) NSArray *responseOptionsArray;

@end

@implementation GRTPostDetailViewController

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
    
    self.dataStore = [GRTDataStore sharedDataStore];

    [self createPostDetail];
    [self setupResponses];
    [self.backButton setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIFont fontWithName:@"DINOT-Medium" size:18],
                                                NSFontAttributeName,
                                                nil]
                                     forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPostDetail
{
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 66, 320, 320)];
    self.mainScrollView.backgroundColor = [UIColor purpleColor];
    
    UIView *postDetailView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 620)];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:postDetailView];
    
    UILabel *postDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 280, 280)];
    NSString *postDetailText = [NSString stringWithFormat:@"“\u00a0%@\u00a0”", self.post.content];
    [postDetailLabel setText:postDetailText];
    [postDetailLabel setTextAlignment:NSTextAlignmentCenter];
    [postDetailLabel setNumberOfLines:0];
    [postDetailLabel setFont:[UIFont fontWithName:@"ArcherPro-SemiboldItalic" size:24]];
    [postDetailLabel setTextColor:[UIColor greatistColorForCategory:self.post.section.name]];
    [postDetailView addSubview:postDetailLabel];
    
    if (![self.post.user.facebookID isEqualToString:self.dataStore.currentUser.facebookID])
    {
        UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [flagButton setFrame:CGRectMake(180, 410, 140, 40)];
        [flagButton setTitleColor:[UIColor greatistColorForCategory:self.post.section.name] forState:UIControlStateNormal];
        [flagButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:10]];
        flagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        flagButton.contentEdgeInsets = UIEdgeInsetsMake(0, 25, 0, 0);
        [flagButton setTitle:@"FLAG INAPPROPRIATE" forState:UIControlStateNormal];
        //    FAKFontAwesome *flagIcon = [FAKFontAwesome flagIconWithSize:15];
        //    [flagIcon addAttribute:NSForegroundColorAttributeName value:[UIColor greatistColorForCategory:self.post.section.name]];
        
        
        if ([self.post.section.name isEqualToString: @"happiness"])
        {
            UIImage *flagImage = [[UIImage imageWithImage:[UIImage imageNamed:@"Flag_Fill_Happiness"] scaledToSize:CGSizeMake(20, 40)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
            [flagButton setBackgroundImage:flagImage forState:UIControlStateNormal];
            [flagButton addTarget:self action:@selector(flagButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [postDetailView addSubview:flagButton];
        }
        
        if ([self.post.section.name isEqualToString:@"health"])
        {
            UIImage *flagImage = [[UIImage imageWithImage:[UIImage imageNamed:@"Flag_Fill_Health"] scaledToSize:CGSizeMake(20, 40)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
            [flagButton setBackgroundImage:flagImage forState:UIControlStateNormal];
            [flagButton addTarget:self action:@selector(flagButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [postDetailView addSubview:flagButton];
        }
        
        if ([self.post.section.name isEqualToString: @"fitness"])
        {
            UIImage *flagImage = [[UIImage imageWithImage:[UIImage imageNamed:@"Flag_Fill_Fitness"] scaledToSize:CGSizeMake(20, 40)] stretchableImageWithLeftCapWidth:20 topCapHeight:20];
            [flagButton setBackgroundImage:flagImage forState:UIControlStateNormal];
            [flagButton addTarget:self action:@selector(flagButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
            [postDetailView addSubview:flagButton];
        }

        //    flagIcon.iconFontSize = 15;
        
    }

//    UIButton *flagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [flagButton setBackgroundImage:[UIImage imageNamed:@"Flag_Fill"] forState:UIControlStateNormal];
//    [flagButton setFrame:CGRectMake(190, 280, 20, 40)];
//[flagButton setTitleColor:[UIColor greatistColorForCategory:self.post.section.name] forState:UIControlStateNormal];
//    [flagButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:20]];
//    flagButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    flagButton.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
//   [flagButton setTitle:@"FLAG INAPPROPRIATE" forState:UIControlStateNormal];
//     [postDetailView addSubview:flagButton];
//    UILabel*flagLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 120, 25)];
//    [flagLabel setText:@"FLAG INAPPROPRIATE"];
//    [flagLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:10]];
//    [flagLabel setTextColor:[UIColor greatistColorForCategory:self.post.section.name]];
//    [flagButton addSubview:flagLabel];

}

- (void)setupResponses
{
    self.responseLabelsArray = [NSMutableArray new];
    
    self.responseView = [[UIView alloc]initWithFrame:CGRectMake(0, 320, 320, 90)];
    [MBProgressHUD showHUDAddedTo:self.responseView animated:YES];
    [self.responseView setBackgroundColor:[UIColor greatistColorForCategory:self.post.section.name]];
    [self.view addSubview:self.responseView];
    
    NSArray *labelXCoordinates = @[@(30),@(170)];
    NSArray *labelYCoordinates = @[@(20),@(50)];
    
    self.responseLabelFramesArray = [NSMutableArray new];
    self.responseButtonFramesArray = [NSMutableArray new];
    
    for (NSNumber *xCoordinate in labelXCoordinates) {
        for (NSNumber *yCoordinate in labelYCoordinates) {
            NSInteger x = [xCoordinate integerValue];
            NSInteger y = [yCoordinate integerValue];
            CGRect responseLabelFrame = CGRectMake(x, y, 30, 20);
            [self.responseLabelFramesArray addObject:[NSValue valueWithCGRect:responseLabelFrame]];
            
            CGRect responseButtonFrame = CGRectMake(x+40, y, 100, 20);
            [self.responseButtonFramesArray addObject:[NSValue valueWithCGRect:responseButtonFrame]];
        }
    }
    
    self.responseOptionsArray = [[self.dataStore.selectedResponses allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [[GRTDataManager sharedManager] getUpdatedResponsesForPostID:self.post.objectId withCompletion:^(NSDictionary *postDictionary) {
        [self updateResponseButtons];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
     
}

- (void)updateResponseButtons
{
    [[self.responseView subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    for (NSInteger i = 0; i < [self.responseOptionsArray count]; i++) {
        NSString *responseContent = self.responseOptionsArray[i];
        NSNumber *responseCount = [self.dataStore.selectedResponses valueForKey:responseContent];
        
        UILabel *newResponseCountLabel = [[UILabel alloc] initWithFrame:[[self.responseLabelFramesArray objectAtIndex:i] CGRectValue]];
        [newResponseCountLabel setFont:[UIFont fontWithName:@"DINOT-Bold" size:16]];
        newResponseCountLabel.textColor = [UIColor whiteColor];
        newResponseCountLabel.text = [NSString stringWithFormat:@"%@", responseCount ];
        [newResponseCountLabel setTextAlignment:NSTextAlignmentCenter];
        [[newResponseCountLabel layer] setBorderColor:[[UIColor whiteColor] CGColor]];
        [[newResponseCountLabel layer] setBorderWidth:1];
        [[newResponseCountLabel layer] setCornerRadius:1];
        [newResponseCountLabel drawTextInRect:CGRectMake(5, 5, 10, 10)];
        [self.responseLabelsArray addObject:newResponseCountLabel];
        [self.responseView addSubview:newResponseCountLabel];
        
        UIButton *newResponseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [newResponseButton setFrame:[[self.responseButtonFramesArray objectAtIndex:i] CGRectValue]];
        [newResponseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [newResponseButton.titleLabel setFont:[UIFont fontWithName:@"DINOT-Medium" size:14]];
        newResponseButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [newResponseButton setTitle:[responseContent uppercaseString] forState:UIControlStateNormal];
        [newResponseButton setTag:i];
        [newResponseButton addTarget:self action:@selector(responseButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.responseView addSubview:newResponseButton];
    }
    
}

- (IBAction)backBarButtonItemTapped:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)responseButtonTapped:(UIButton *)sender
{
    UIButton *button = (UIButton *)sender;
    NSInteger responseIndex = [button tag];
    [[GRTDataManager sharedManager] incrementResponse:self.responseOptionsArray[responseIndex]
                                            forPostID:self.post.objectId
                                       withCompletion:^(NSString *updatedAt) {
       [self updateResponseButtons];
    }];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (buttonIndex == 0) {
        [[GRTDataManager sharedManager] flagPost:self.post withCompletion:^(NSDictionary *response) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

- (void)flagButtonTapped:(UIButton *)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Flag Post"
                                                    message:@"This will remove this post from everyone's feed- are you sure you want to flag this post?"
                                                   delegate:self
                                          cancelButtonTitle:@"Flag"
                                          otherButtonTitles:@"Cancel", nil];
    [alert show];

//    [[GRTDataManager sharedManager] flagPost:self.post withCompletion:^(NSDictionary *response) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
  
}
@end
