//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Ola Lundén on 2/14/11.
//  Copyright 2011 Fickla. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {
	IBOutlet UILabel *display;
	CalculatorBrain *brain;
	BOOL userIsInTheMiddleOfTypingANumber;
	BOOL userIsTypingAnExpression;
}

@property (nonatomic, readonly) CalculatorBrain *brain;

- (void)updateDisplay:(NSString *)digit;
- (NSMutableString *)arrayToString:(NSArray *)input;
- (void)clearAll;
- (NSDictionary *)testVariablesValue;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)operationPressed:(UIButton *)sender;

@end

