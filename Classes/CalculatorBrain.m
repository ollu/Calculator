//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

- (void)setOperand:(double)aDouble
{
	operand = aDouble;
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
		operand = waitingOperand - operand;
	}
	else if ([@"/" isEqual:waitingOperation]) {
		if (operand) {
			operand = waitingOperand / operand;
		}
	}
}

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
	else {
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}


	return operand;
}

@end
