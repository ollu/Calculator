//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorBrain : NSObject {
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
@private
	double memory;
}

@property double memory;

- (void)setOperand:(double)aDouble;
- (double)performOperation:(NSString *)operation;

@end
