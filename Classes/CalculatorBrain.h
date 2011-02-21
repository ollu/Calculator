//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
@private
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	double memory;
}

@property double memory;
@property double operand;

- (double)performOperation:(NSString *)operation;

@end
