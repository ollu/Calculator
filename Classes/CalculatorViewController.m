//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import "CalculatorViewController.h"


@implementation CalculatorViewController

@synthesize brain;

// "Lazy instanciation"
- (CalculatorBrain *)brain
{
	// If there is no instance of brain create one and return it.
	if (!brain) {
		brain = [[CalculatorBrain alloc] init];
	}
	return brain;
}

- (void)updateDisplay:(NSString *)digit {
	if (userIsInTheMiddleOfTypingANumber) {
		display.text = [display.text stringByAppendingString:digit];
	}
	else {
		display.text = digit;
		userIsInTheMiddleOfTypingANumber = YES;
	}
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
		[self updateDisplay:digit];
	}
	else {
		if ([digit isEqual:@"."]) {
			//NSLog(@"The dot can only appear once");
			return;
		}
		else {
			[self updateDisplay:digit];
		}
	}
}

- (IBAction)operationPressed:(UIButton *)sender
{
	NSString *operation = sender.titleLabel.text;
	
	if (userIsInTheMiddleOfTypingANumber) {
		//[[self brain] setOperand:[[display text] doubleValue]];
		self.brain.operand = [display.text doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	//double result = [[self brain] performOperation:operation];
	//[display setText:[NSString stringWithFormat:@"%g", result]];
	[self.brain performOperation:operation];
	display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
}

@end
