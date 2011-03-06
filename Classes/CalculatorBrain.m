//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

@synthesize memory;				// What's stored in the memory
@synthesize operand;
@synthesize waitingOperand;		// Queued operand
@synthesize waitingOperation;
@synthesize internalExpression;	// The complete operation

- (id) init {
	if (self = [super init]) {
		internalExpression = [[NSMutableArray alloc] init];
		NSLog(@"Brain init");
	}
	return self;
}

- (void)performWaitingOperation
{	
	if ([@"+" isEqual:waitingOperation]) {
		operand = waitingOperand + operand;
	}
	else if ([@"-" isEqual:waitingOperation]) {
		operand = waitingOperand - operand;
	}
	else if ([@"*" isEqual:waitingOperation]) {
		operand = waitingOperand * operand;
	}
	else if ([@"/" isEqual:waitingOperation]) {
		if (operand) {
			operand = waitingOperand / operand;
		}
	}
}

// operation is the arithmetic sent
// and operand is the number
- (double)performOperation:(NSString *)operation
{	
	if ([operation isEqual:@"sqrt"]) {
		operand = sqrt(operand);
	}
	else if ([operation isEqual:@"+/-"])
	{
		operand = - operand;
	}
	else if ([operation isEqual:@"cos"])
	{
		operand = cos(operand);
	}
	else if ([operation isEqual:@"sin"])
	{
		operand = sin(operand);
	}
	else if ([operation isEqual:@"1/x"])
	{
		operand = 1 / operand;
	}
	else if ([operation isEqual:@"M+"])
	{
		memory += operand;
	}
	else if ([operation isEqual:@"M-"])
	{
		memory -= operand;
	}
	else if ([operation isEqual:@"MR"])
	{
		operand = memory;
	}
	else if ([operation isEqual:@"MC"])
	{
		memory = 0;
	}
	else {
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}

	return operand;
}

- (void)buildExpression:(NSString *)sender {
	
	if ([sender isEqual:@"MC"] || [sender isEqual:@"MR"] || [sender isEqual:@"C"]) {
		return;
	}
	
	NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
	[nf setNumberStyle:NSNumberFormatterDecimalStyle];
	NSNumber * myNumber = [nf numberFromString:sender];

	if (myNumber) {
		[internalExpression addObject:myNumber];
	}
	else {
		if (![sender isEqual:@"C"]) {
			[internalExpression addObject:sender];
		}
	}
	
	[nf release];
}

- (void)dealloc {
	[internalExpression release];
	[super dealloc];
}

@end
