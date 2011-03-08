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
	userIsTypingAnExpression = NO;
	userIsInTheMiddleOfTypingANumber = NO;

}

- (NSMutableString *)arrayToString:(NSArray *)input {
	NSMutableString *concatedExpression = [[NSMutableString alloc] init];
	
	for (NSObject *obj in input) {
		if ([obj isKindOfClass:[NSNumber class]]) {
			[concatedExpression appendString:[obj description]];
		}
		else {
			[concatedExpression appendString:[obj description]];
		}
	}
	[concatedExpression autorelease];
	return concatedExpression;
}

- (void)updateDisplay:(NSString *)digit {
	if (userIsTypingAnExpression) {
		display.text = [self arrayToString:brain.internalExpression];
	}
	else {
		if (userIsInTheMiddleOfTypingANumber) {
			display.text = [display.text stringByAppendingString:digit];
		}
		else {
			display.text = digit;
			userIsInTheMiddleOfTypingANumber = YES;
		}	
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

- (void)clearAll {
	display.text = @"0";
	brain.operand = 0;
	brain.waitingOperand = 0;
	brain.waitingOperation = nil;
	[brain.internalExpression removeAllObjects];
	
	userIsTypingAnExpression = NO;
	userIsInTheMiddleOfTypingANumber = NO;
}

- (NSDictionary *)testVariablesValue {
	return [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:13], @"x",
													  [NSNumber numberWithFloat:23.8], @"y", 
													  [NSNumber numberWithFloat:8], @"z", nil];
}

- (IBAction)operationPressed:(UIButton *)sender
{
	NSString *operation = sender.titleLabel.text;
	[self.brain buildExpression:operation];
	
	if ([operation isEqual:@"x"] || [operation isEqual:@"y"] || [operation isEqual:@"z"]) {
		userIsTypingAnExpression = YES;
	}

	if (userIsTypingAnExpression && [operation isEqual:@"="]) {
		NSLog(@"lastObject: %@",[brain.internalExpression lastObject]);
			[self updateDisplay:operation];
	}
	else {
		if ([operation isEqual:@"C"]) {
			[self clearAll];
		}
		else {
			if (userIsInTheMiddleOfTypingANumber) {
				self.brain.operand = [display.text doubleValue];
				userIsInTheMiddleOfTypingANumber = NO;
			}
			
			[self.brain performOperation:operation];
			display.text = [NSString stringWithFormat:@"%g", self.brain.operand];
		}
		
		if (userIsTypingAnExpression) {
			[self updateDisplay:operation];
		}
	}
	
}

- (IBAction)solve:(UIButton *)sender {
	NSLog(@"Expression: %@", [self evaluateExpression:brain.internalExpression]);
}

- (NSMutableString *)evaluateExpression:(NSMutableArray *)expression {
	return [self arrayToString:expression];
}

@end