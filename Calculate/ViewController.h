//
//  ViewController.h
//  Calculate
//
//  Created by Foodstory on 9/3/2564 BE.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *numberField;
    NSMutableArray *numberStack;
    NSMutableArray *signStack;
}
- (void)selectButton:(UIButton *)button;
- (void)calculate;
- (void)clear;


@end

