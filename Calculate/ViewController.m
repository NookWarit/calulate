//
//  ViewController.m
//  Calculate
//
//  Created by Foodstory on 9/3/2564 BE.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self init];
}

-(id) init
{
    self = [ super init];
    if (self) {
        // Create vatiable
        numberStack = [[NSMutableArray alloc] init];
        signStack = [[NSMutableArray alloc] init];
        
        // Set View property
        self.view.autoresizesSubviews = YES;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.view.backgroundColor = [UIColor whiteColor];
        
        // Set View Component
        numberField = [[UITextField alloc] init];
        numberField.frame = CGRectMake(10, 30, 300, 50);
        numberField.borderStyle = UITextBorderStyleRoundedRect;
        numberField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        numberField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        numberField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        numberField.font = [UIFont boldSystemFontOfSize:30];
        numberField.textAlignment = NSTextAlignmentRight;
        numberField.text = @"";
        numberField.delegate = self;
        [self.view addSubview:numberField];
        
        for (int i = 0; i < 9; i++) {
            int row = floor(i / 3);
            int column = i % 3;
                              
            UIButton *numberButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            numberButton.frame = CGRectMake(10 + 70 * column, 250 - 70 * row, 60, 60);
            [numberButton setBackgroundColor: UIColor.lightGrayColor];
            [numberButton setTitle:[NSString stringWithFormat:@"%d", i+1] forState:normal];
            [numberButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:numberButton];
        }
        
        UIButton *zeroButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        zeroButton.frame = CGRectMake(10, 330, 200, 60);
        [zeroButton setBackgroundColor: UIColor.lightGrayColor];
        [zeroButton setTitle:@"0" forState:UIControlStateNormal];
        [zeroButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:zeroButton];
        
        UIButton *divideButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        divideButton.frame = CGRectMake(220, 110, 60, 60);
        [divideButton setBackgroundColor: UIColor.cyanColor];
        [divideButton setTitle:@"/" forState:UIControlStateNormal];
        [divideButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:divideButton];
        
        UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        timeButton.frame = CGRectMake(220, 180, 60, 60);
        [timeButton setBackgroundColor: UIColor.cyanColor];
        [timeButton setTitle:@"*" forState:UIControlStateNormal];
        [timeButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:timeButton];
        
        UIButton *minusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        minusButton.frame = CGRectMake(220, 250, 60, 60);
        [minusButton setBackgroundColor: UIColor.cyanColor];
        [minusButton setTitle:@"-" forState:UIControlStateNormal];
        [minusButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:minusButton];
        
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        plusButton.frame = CGRectMake(220, 330, 60, 60);
        [plusButton setBackgroundColor: UIColor.cyanColor];
        [plusButton setTitle:@"+" forState:UIControlStateNormal];
        [plusButton addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:plusButton];
        
        UIButton *calculateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        calculateButton.frame = CGRectMake(220, 400, 60, 60);
        [calculateButton setBackgroundColor: UIColor.greenColor];
        [calculateButton setTitle:@"=" forState:UIControlStateNormal];
        [calculateButton addTarget:self action:@selector(calculate) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:calculateButton];
        
        UIButton *resetButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        resetButton.frame = CGRectMake(10, 400, 200, 60);
        [resetButton setBackgroundColor: UIColor.yellowColor];
        [resetButton setTitle:@"Clear" forState:UIControlStateNormal];
        [resetButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:resetButton];
    }
    return  self;
    
}

#pragma mark - Instance Method
-(void)selectButton:(UIButton *)button
{
    NSString *tempString = [NSString stringWithFormat:@"%@%@", numberField.text, button.titleLabel.text];
    numberField.text = tempString;
}

-(void)calculate
{
    [numberStack removeAllObjects];
    [signStack removeAllObjects];
    
    NSString *inputString  = numberField.text;
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\d)+([\\+\\*-/](\\d)+)*$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSInteger numberOfMatches = [regex numberOfMatchesInString:inputString options:0 range:NSMakeRange(0, [inputString length])];
    if (numberOfMatches == 0) {
        //Invalid input
        
    }
    
    NSMutableString *tempString = [[NSMutableString alloc] init];
    for (int i = 0; i < [inputString length]; i++) {
        char c = [inputString characterAtIndex:i];
        switch (c) {
            case '+':
            case '-':
            case '*':
            case '/':
            {
                if ([tempString length] > 0) {
                    [numberStack addObject:[NSNumber numberWithInt:[tempString intValue]]];
                    [tempString deleteCharactersInRange:NSMakeRange(0, [tempString length])];
                    if ([signStack count] > 0 && [numberStack count] > 1) {
                        char sign = [[signStack lastObject] charValue];
                        int length = [numberStack count];
                        int x1 = [[numberStack objectAtIndex:(length - 2)] intValue];
                        int x2 = [[numberStack objectAtIndex:(length - 1)] intValue];
                        int y;
                        
                        switch (sign) {
                            case '*':
                            {
                                y = x1 * x2;
                                [numberStack removeLastObject];
                                [numberStack removeLastObject];
                                [signStack removeLastObject];
                                [numberStack addObject:[NSNumber numberWithInt:y]];
                                break;
                            }
                            case '/':
                            {
                                y = x1 / x2;
                                [numberStack removeLastObject];
                                [numberStack removeLastObject];
                                [signStack removeLastObject];
                                [numberStack addObject:[NSNumber numberWithInt:y]];
                                break;
                            }
                        }
                    }
                }
                [signStack addObject:[NSNumber numberWithChar:c]];
                                break;
            }
                            default:
            { [ tempString appendFormat:@"%c",c];
                                break;
                        }
                    }
                }
        if ([signStack count] > 0 ) {
            [numberStack addObject:[NSNumber numberWithInt:[tempString intValue]]];
            if ([signStack count] > 0 && [numberStack count] > 1) {
            char sign = [[signStack lastObject] charValue];
            int length = [numberStack count];
            int x1 = [[numberStack objectAtIndex:(length - 2)] intValue];
            int x2 = [[numberStack objectAtIndex:(length - 1)] intValue];
            int y;
            
            switch (sign) {
                case '*':
                {
                    y = x1 * x2;
                    [numberStack removeLastObject];
                    [numberStack removeLastObject];
                    [signStack removeLastObject];
                    [numberStack addObject:[NSNumber numberWithInt:y]];
                    break;
                }
                case '/':
                {
                    y = x1 / x2;
                    [numberStack removeLastObject];
                    [numberStack removeLastObject];
                    [signStack removeLastObject];
                    [numberStack addObject:[NSNumber numberWithInt:y]];
                    break;
                }
            }
        }
    }

    int x;
    int y = [[numberStack objectAtIndex:0] intValue];
    for (int i = 0; i< [signStack count]; i++) {
        x = [[numberStack objectAtIndex:(i+1)] intValue];
        switch ([[signStack objectAtIndex:i] charValue]) {
            case '+':
            {
                y += x;
                break;
            }
            case '-':
            {
                y -= x;
                break;
            }
        }
    }
    numberField.text = [NSString stringWithFormat:@"%d", y];
}

-(void)clear
{
    numberField.text = @"";
}

#pragma  mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+-*/"];
    for (int i = 0; i < [string length]; i++) {
        unichar c = [string characterAtIndex:i];
        if (![charSet characterIsMember:c]) {
            return NO;
        }
    }
    return  YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField canResignFirstResponder];
    [self calculate];
    
    return YES;
}


@end
