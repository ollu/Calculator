//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController

- (CalculatorBrain *)brain
{
	// If there is no instance of brain create on and return it.
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
	}
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = sender.titleLabel.text;
	NSRange range = [display.text rangeOfString:@"."];

	if (range.location == NSNotFound) {	
		if (userIsInTheMiddleOfTypingANumber) {
			[display setText:[[display text] stringByAppendingString:digit]];
		}
		else {
			[display setText:digit];
			userIsInTheMiddleOfTypingANumber = YES;
		}
	}
	else {
		if ([digit isEqual:@"."]) {
			NSLog(@"Det finns redan ett komma i texten");
		}
		else {
			if (userIsInTheMiddleOfTypingANumber) {
				[display setText:[[display text] stringByAppendingString:digit]];
			}
			else {
				[display setText:digit];
				userIsInTheMiddleOfTypingANumber = YES;
			}
		}
	}

}

- (IBAction)operationPressed:(UIButton *)sender
{
	if (userIsInTheMiddleOfTypingANumber) {
		[[self brain] setOperand:[[display text] doubleValue]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	NSString *operation = sender.titleLabel.text;
	double result = [[self brain] performOperation:operation];
	[display setText:[NSString stringWithFormat:@"%g", result]];
}

@end
