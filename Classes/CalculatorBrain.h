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
	NSMutableArray *internalExpression;
}

@property double memory;
@property double operand;
@property double waitingOperand;

@property (nonatomic, retain) NSString *waitingOperation;
@property (nonatomic, retain) NSMutableArray *internalExpression;

- (void)buildExpression:(NSString *)sender;
- (double)performOperation:(NSString *)operation;

@end
