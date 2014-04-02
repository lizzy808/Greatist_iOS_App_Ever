//
//  GRTComposePostViewController.m
//  Greatist Message Publisher
//
//  Created by Elizabeth Choy on 4/2/14.
//  Copyright (c) 2014 Ezekiel Abuhoff. All rights reserved.
//

#import "GRTComposePostViewController.h"

@interface GRTComposePostViewController ()

@property (weak, nonatomic) IBOutlet UITextView *postContentTextView;
@property (nonatomic, assign) id<UITextFieldDelegate> delegate;

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
    self.postContentTextView.delegate = self;
    [self.postContentTextView setTextColor:[UIColor lightGrayColor]];
    
    // Do any additional setup after loading the view.
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%@", textField);
    [self.postContentTextView setTextColor:[UIColor blackColor]];
    [self.postContentTextView setSelectedRange:NSMakeRange(0, self.postContentTextView.text.length)];
    [self.postContentTextView setText:@""];
}

@end