//
//  JbD_Opus001_MainViewController.h
//  Pixel Coder
//
//  Created by John E Russo on 1/9/13.
//  Copyright (c) 2013 John E Russo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JbD_Opus001_MainViewController : UIViewController <UITextFieldDelegate>
{
    int baseValue;
}

@property (nonatomic, strong) UIAlertView *noBaseValueAlert;
@property (nonatomic, strong) UIAlertView *noConversionValueAlert;
@property (nonatomic, strong) NSMutableString *displayString;
@property (nonatomic, strong) UITextField *mainTextField;
@property (nonatomic, strong) UILabel *insetLabel;
@property (nonatomic, strong) UILabel *baseValueLabel;
@property (nonatomic, strong) UIButton *baseButton;
@property (nonatomic, strong) UIView *firstConversionView;
@property (nonatomic, strong) UIView *secondConversionView;
@property (nonatomic, strong) UIView *thirdConversionView;
@property (nonatomic, strong) UILabel *pxUOMLabel;
@property (nonatomic, strong) UILabel *ptUOMLabel;
@property (nonatomic, strong) UILabel *emsUOMLabel;
@property (nonatomic, strong) UILabel *percentUOMLabel;
@property (nonatomic, strong) UILabel *pxValueLabel;
@property (nonatomic, strong) UILabel *ptValueLabel;
@property (nonatomic, strong) UILabel *percentValueLabel;
@property (nonatomic, strong) UILabel *emsValueLabel;


-(void) pressDigitButton: (id) sender;
-(void)pressBsButton:(id)sender;
-(void) processDigit: (int) numberPressed;
-(void) pressBaseButton: (UIButton *) sender;


@end
