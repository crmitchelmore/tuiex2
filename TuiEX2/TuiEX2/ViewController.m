//
//  ViewController.m
//  TuiEX2
//
//  Created by Chris Mitchelmore on 25/01/2016.
//  Copyright © 2016 Chris Mitchelmore. All rights reserved.
//

#import "ViewController.h"
#import "Bwitter.h"


@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *commandField;
@property (nonatomic, strong) Bwitter *bwitter;
@property (weak, nonatomic) IBOutlet UITextView *outputTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bwitter = [Bwitter new];
    self.commandField.delegate = self;
}


- (IBAction)submitButtonTouched:(UIButton *)sender
{
    NSString *commandString = self.commandField.text;
    [self addLineToOutputView: [@"> " stringByAppendingString:commandString]];
    NSArray *results = [self.bwitter executeCommandFromString:commandString];
    if (results) {
        for (NSString *string in results) {
            [self addLineToOutputView:string];
        }
    }
    self.commandField.text = nil;
}

- (IBAction)clearOutputButtonTouched:(UIButton *)sender
{
    self.outputTextView.text = @"";
}

- (void)addLineToOutputView: (NSString *)line
{
    self.outputTextView.text = [self.outputTextView.text stringByAppendingFormat:@"%@\n", line];
}

//Mark - UITextfield delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self submitButtonTouched:nil];
    return YES;
}

@end
