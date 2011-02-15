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
//	switch (waitingOperation) {
//		case @"+":
//			operand = waitingOperand + operand;
//			break;
//		case @"-":
//			operand = waitingOperand - operand;
//			break;
//		case @"*":
//			operand = waitingOperand * operand;
//			break;
//		case @"/":
//			if (operand) {
//				operand = waitingOperand / operand;
//			}
//			break;
//		default:
//			break;
//	}
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
	else if ([@"+/-" isEqual:operation])
	{
		operand = - operand;
	}
	else {
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand = operand;
	}


	return operand;
}

@end
