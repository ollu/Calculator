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
	// If there is no instance of brain create one and return it.
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
	}
	return brain;
}

- (IBAction)digitPressed:(UIButton *)sender
{
	NSString *digit = sender.titleLabel.text;
	NSRange range = [display.text rangeOfString:@"."];
	
	
	// Prevent user from starting a number with zero
	if ([display.text isEqual:@"0"] && [digit isEqual:@"0"]) {
		return;
	}
	
	
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
			NSLog(@"The dot can only appear once");
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
	NSString *operation = sender.titleLabel.text;
	
	if ([operation isEqual:@"C"]) {
		[display setText:[NSString stringWithFormat:@"0"]];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	else {
		if (userIsInTheMiddleOfTypingANumber) {
			[[self brain] setOperand:[[display text] doubleValue]];
			userIsInTheMiddleOfTypingANumber = NO;
		}
	
		double result = [[self brain] performOperation:operation];
		[display setText:[NSString stringWithFormat:@"%g", result]];
	}
}

@end
