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

- (void)viewDidLoad {
	brain = [[CalculatorBrain alloc] init];
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
		//NSLog(@"Cannot start expression with a zero");
		return;
	}
	
	
	if (range.location == NSNotFound) {	
		[self.brain buildExpression:digit];
		[self updateDisplay:digit];
	} 
	else {
		if ([digit isEqual:@"."]) {
			//NSLog(@"The dot can only appear once");
			return;
		} 
		else {
			[self.brain buildExpression:digit];
			[self updateDisplay:digit];
		}
	}
}

- (IBAction)operationPressed:(UIButton *)sender
{
	NSString *operation = sender.titleLabel.text;
	[self.brain buildExpression:operation];
	
	if (userIsInTheMiddleOfTypingANumber) {
		self.brain.operand = [display.text doubleValue];
		userIsInTheMiddleOfTypingANumber = NO;
	}
	
	[self.brain performOperation:operation];
	display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
}

@end