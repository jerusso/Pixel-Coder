//
//  JbD_Opus001_MainViewController.m
//  Pixel Coder
//
//  Created by John E Russo on 1/9/13.
//  Copyright (c) 2013 John E Russo. All rights reserved.
//

#import "JbD_Opus001_MainViewController.h"
#import "JbD_Opus001_Converter.h"
#import "Constants.h"

@implementation JbD_Opus001_MainViewController
{
    JbD_Opus001_Converter *myConverter;
}

@synthesize noBaseValueAlert, noConversionValueAlert, displayString, mainTextField, insetLabel, baseValueLabel, baseButton, firstConversionView, secondConversionView, thirdConversionView, pxUOMLabel, ptUOMLabel, percentUOMLabel, emsUOMLabel, pxValueLabel, ptValueLabel, percentValueLabel, emsValueLabel;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    //init alert views
    noBaseValueAlert = [[UIAlertView alloc] initWithTitle:@"No Base Value" message:@"Enter a non-zero value and tap the Set Base button" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    noConversionValueAlert = [[UIAlertView alloc] initWithTitle:@"No Conversion Value" message:@"Enter a value and tap a conversion button" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    //init displayString
    displayString = [NSMutableString stringWithCapacity:4];
    
    //init Converter
    myConverter = [[JbD_Opus001_Converter alloc] init];
    
    //set nav controller's view b/g color
    self.view.backgroundColor = kMyGray;
    
    //grab nav bar from nav controller
    UINavigationBar *mainNavBar = [self.navigationController navigationBar];
    
    //change nav bar b/g to black
    mainNavBar.barStyle = UIBarStyleBlack;
    
    //customize title text
    NSDictionary *titleTextProperties = [[NSDictionary alloc] initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:18.0f], UITextAttributeFont, [UIColor whiteColor], UITextAttributeTextColor, nil];
    mainNavBar.titleTextAttributes = titleTextProperties;
    self.title = @"Pixel Coder";
    
    //build and add first conversion view
    CGRect firstConversionViewRect = CGRectMake(0.0f, 188.0f, 320.f, 73.0f);
    firstConversionView = [[UIView alloc] initWithFrame:firstConversionViewRect];
    firstConversionView.translatesAutoresizingMaskIntoConstraints = NO;
    firstConversionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:firstConversionView];
    
    //build and add second conversion view
    CGRect secondConversionViewRect = CGRectMake(0.0f, 262.0f, 320.f, 76.0f);
    secondConversionView = [[UIView alloc] initWithFrame:secondConversionViewRect];
    secondConversionView.translatesAutoresizingMaskIntoConstraints = NO;
    secondConversionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:secondConversionView];
    
    //build and add third conversion view
    CGRect thirdConversionViewRect = CGRectMake(0.0f, 339.0f, 320.f, 77.0f);
    thirdConversionView = [[UIView alloc] initWithFrame:thirdConversionViewRect];
    thirdConversionView.translatesAutoresizingMaskIntoConstraints = NO;
    thirdConversionView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:thirdConversionView];
    
    //constraints for conversion views
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(>=188)-[firstConversionView(73)]-1-[secondConversionView(76)]-1-[thirdConversionView(77)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(firstConversionView, secondConversionView, thirdConversionView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[firstConversionView(320)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(firstConversionView, secondConversionView, thirdConversionView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[secondConversionView(320)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(firstConversionView, secondConversionView, thirdConversionView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[thirdConversionView(320)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(firstConversionView, secondConversionView, thirdConversionView)]];
    
    
    //build and add percent UOM label
    CGRect percentUOMLabelRect = CGRectMake(260.0f, 20.0f, 30.0f, 30.0f);
    NSParagraphStyle *percentUOMLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *percentUOMLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:24.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, percentUOMLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *percentUOMLabelText = [[NSAttributedString alloc] initWithString: @"%" attributes:percentUOMLabelTextDictionary];
    percentUOMLabel = [[UILabel alloc] initWithFrame:percentUOMLabelRect];
    percentUOMLabel.attributedText = percentUOMLabelText;
    percentUOMLabel.backgroundColor = [UIColor clearColor];
    
    //build and add ems UOM Label
    CGRect emsUOMLabelRect = CGRectMake(260.0f, 20.0f, 35.0f, 30.0f);
    NSParagraphStyle *emsUOMLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *emsUOMLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:24.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, emsUOMLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *emsUOMLabelText = [[NSAttributedString alloc] initWithString: @"em" attributes:emsUOMLabelTextDictionary];
    emsUOMLabel = [[UILabel alloc] initWithFrame:emsUOMLabelRect];
    emsUOMLabel.attributedText = emsUOMLabelText;
    emsUOMLabel.backgroundColor = [UIColor clearColor];
    
    //build and add main text field
    CGRect mainTextRect = CGRectMake(0.0f, 0.0f, 320.0f, 187.0f);
    mainTextField = [[UITextField alloc] initWithFrame:mainTextRect];
    mainTextField.translatesAutoresizingMaskIntoConstraints = NO;
    mainTextField.backgroundColor = [UIColor blackColor];
    mainTextField.textColor = [UIColor whiteColor];
    mainTextField.clearsOnBeginEditing = YES;
    mainTextField.textAlignment = NSTextAlignmentCenter;
    mainTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    mainTextField.font = [UIFont fontWithName:@"Helvetica" size:90.0f];
    mainTextField.delegate = self;
    [self.view addSubview:mainTextField];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mainTextField(320)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(mainTextField)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mainTextField(>=187)]-1-[firstConversionView(73)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(mainTextField,firstConversionView)]];
    
    //build and add label text subview
    CGRect labelRect = CGRectMake(115.0f, 167.0f, 90.0f, 15.0f);
    NSParagraphStyle *defaultStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *labelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:12.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, defaultStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *labelText = [[NSAttributedString alloc] initWithString:@"Enter base value" attributes:labelTextDictionary];
    insetLabel = [[UILabel alloc] initWithFrame:labelRect];
    insetLabel.translatesAutoresizingMaskIntoConstraints = NO;
    insetLabel.attributedText = labelText;
    insetLabel.textAlignment = NSTextAlignmentCenter;
    insetLabel.backgroundColor = [UIColor blackColor];
    [mainTextField addSubview:insetLabel];
    
    [mainTextField addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[insetLabel(15)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(insetLabel)]];
    [mainTextField addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(115)-[insetLabel(90)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(insetLabel)]];
    
    //custom b/g image for buttons
    UIImage *keypadBGImage = [UIImage imageNamed:@"keypad_normal"];
    UIImage *keypadBGImagePressed = [UIImage imageNamed:@"keypad_pressed"];
    
    //create 7 button
    UIButton *sevenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sevenButton.frame = CGRectMake(0.0f, 1.0f, 106.0f, 44.0f);
    [sevenButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [sevenButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    sevenButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [sevenButton setTitle:@"7" forState:UIControlStateNormal];
    sevenButton.tag = 7;
    [sevenButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sevenButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [sevenButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 8 button
    UIButton *eightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    eightButton.frame = CGRectMake(107.0f, 1.0f, 106.0f, 44.0f);
    [eightButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [eightButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    eightButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [eightButton setTitle:@"8" forState:UIControlStateNormal];
    eightButton.tag = 8;
    [eightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [eightButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [eightButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 9 button
    UIButton *nineButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nineButton.frame = CGRectMake(214.0f, 1.0f, 106.0f, 44.0f);
    [nineButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [nineButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    nineButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [nineButton setTitle:@"9" forState:UIControlStateNormal];
    nineButton.tag = 9;
    [nineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nineButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [nineButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 4 button
    UIButton *fourButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fourButton.frame = CGRectMake(0.0f, 46.0f, 106.0f, 44.0f);
    [fourButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [fourButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    fourButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [fourButton setTitle:@"4" forState:UIControlStateNormal];
    fourButton.tag = 4;
    [fourButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fourButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [fourButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 5 button
    UIButton *fiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fiveButton.frame = CGRectMake(107.0f, 46.0f, 106.0f, 44.0f);
    [fiveButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [fiveButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    fiveButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [fiveButton setTitle:@"5" forState:UIControlStateNormal];
    fiveButton.tag = 5;
    [fiveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fiveButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [fiveButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 6 button
    UIButton *sixButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sixButton.frame = CGRectMake(214.0f, 46.0f, 106.0f, 44.0f);
    [sixButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [sixButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    sixButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [sixButton setTitle:@"6" forState:UIControlStateNormal];
    sixButton.tag = 6;
    [sixButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sixButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [sixButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 1 button
    UIButton *oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    oneButton.frame = CGRectMake(0.0f, 91.0f, 106.0f, 44.0f);
    [oneButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [oneButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    oneButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [oneButton setTitle:@"1" forState:UIControlStateNormal];
    oneButton.tag = 1;
    [oneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [oneButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [oneButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 2 button
    UIButton *twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    twoButton.frame = CGRectMake(107.0f, 91.0f, 106.0f, 44.0f);
    [twoButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [twoButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    twoButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [twoButton setTitle:@"2" forState:UIControlStateNormal];
    twoButton.tag = 2;
    [twoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [twoButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [twoButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 3 button
    UIButton *threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    threeButton.frame = CGRectMake(214.0f, 91.0f, 106.0f, 44.0f);
    [threeButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [threeButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    threeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [threeButton setTitle:@"3" forState:UIControlStateNormal];
    threeButton.tag = 3;
    [threeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [threeButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [threeButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create base button
    baseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    baseButton.frame = CGRectMake(0.0f, 136.0f, 106.0f, 44.0f);
    [baseButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [baseButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    baseButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:18.0f];
    [baseButton setTitle:@"Set Base" forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [baseButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [baseButton addTarget:self action:@selector(pressBaseButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create 0 button
    UIButton *zeroButton = [UIButton buttonWithType:UIButtonTypeCustom];
    zeroButton.frame = CGRectMake(107.0f, 136.0f, 106.0f, 44.0f);
    [zeroButton setBackgroundImage: keypadBGImage forState:UIControlStateNormal];
    [zeroButton setBackgroundImage:keypadBGImagePressed forState:UIControlStateHighlighted];
    zeroButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:31.0f];
    [zeroButton setTitle:@"0" forState:UIControlStateNormal];
    zeroButton.tag = 0;
    [zeroButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zeroButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [zeroButton addTarget:self action: @selector(pressDigitButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create backspace button
    UIButton *bsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bsButton.frame = CGRectMake(214.0f, 136.0f, 106.0f, 44.0f);
    bsButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:24.0f];
    [bsButton setTitle:@"x" forState:UIControlStateNormal];
    UIImage *bsButtonImageNormal = [UIImage imageNamed:@"bs_button_normal"];
    UIImage *bsButtonImagePressed = [UIImage imageNamed:@"bs_button_pressed"];
    [bsButton setBackgroundImage: bsButtonImageNormal forState:UIControlStateNormal];
    [bsButton setBackgroundImage:bsButtonImagePressed forState:UIControlStateHighlighted];
    [bsButton addTarget:self action: @selector(pressBsButton:) forControlEvents:UIControlEventTouchUpInside];
    
    //create input view for keyboard
    CGRect keyboardRect = CGRectMake(0.0f, 302.0f, 320.0f, 178.0f);
    UIView *myInputView = [[UIView alloc] initWithFrame:keyboardRect];
    myInputView.backgroundColor = kMyGray;
    
    //create accessory view for keyboard
    CGRect accessoryViewRect = CGRectMake(0.0, 0.0, 320.0, 50.0);
    UIView *myInputAccessoryView = [[UIView alloc] initWithFrame:accessoryViewRect];
    myInputAccessoryView.backgroundColor = [UIColor blackColor];
    
    //add input view and accessory view to build keyboard
    mainTextField.inputView = myInputView;
    mainTextField.inputAccessoryView = myInputAccessoryView;
    
    //bg images for toButtons
    UIImage *toButtonBgNormal = [UIImage imageNamed:@"toButton_normal"];
    UIImage *toButtonBgPressed = [UIImage imageNamed:@"toButton_pressed"];
    
    //create px button
    UIButton *pixelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pixelButton.translatesAutoresizingMaskIntoConstraints = NO;
    pixelButton.frame = CGRectMake(67.0f, 3.0f, 60.0f, 44.0f);
    pixelButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:21.0f];
    [pixelButton setTitle:@"to Px" forState:UIControlStateNormal];
    [pixelButton setBackgroundImage:toButtonBgNormal forState:UIControlStateNormal];
    [pixelButton setBackgroundImage:toButtonBgPressed forState:UIControlStateHighlighted];
    [pixelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pixelButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [pixelButton addTarget:self action: @selector(convertToPixels:) forControlEvents:UIControlEventTouchUpInside];
    
    //create pt button
    UIButton *pointButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pointButton.translatesAutoresizingMaskIntoConstraints = NO;
    pointButton.frame = CGRectMake(194.0f, 3.0f, 60.0f, 44.0f);
    pointButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:21.0f];
    [pointButton setTitle:@"to Pt" forState:UIControlStateNormal];
    [pointButton setBackgroundImage:toButtonBgNormal forState:UIControlStateNormal];
    [pointButton setBackgroundImage:toButtonBgPressed forState:UIControlStateHighlighted];
    [pointButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [pointButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [pointButton addTarget:self action: @selector(convertToPoints:) forControlEvents:UIControlEventTouchUpInside];
    
    //add buttons to inputAccessoryView
    [mainTextField.inputAccessoryView addSubview:pixelButton];
    [mainTextField.inputAccessoryView addSubview:pointButton];
    
    //add buttons to inputView
    [mainTextField.inputView addSubview:sevenButton];
    [mainTextField.inputView addSubview:eightButton];
    [mainTextField.inputView addSubview:nineButton];
    [mainTextField.inputView addSubview:fourButton];
    [mainTextField.inputView addSubview:fiveButton];
    [mainTextField.inputView addSubview:sixButton];
    [mainTextField.inputView addSubview:oneButton];
    [mainTextField.inputView addSubview:twoButton];
    [mainTextField.inputView addSubview:threeButton];
    [mainTextField.inputView addSubview:baseButton];
    [mainTextField.inputView addSubview:zeroButton];
    [mainTextField.inputView addSubview:bsButton];
    
    [mainTextField becomeFirstResponder];
    
}

- (void) pressDigitButton:(UIButton *)sender
{
    if (displayString.length == 4) {
        return;
    } else {
        int numberPressed = sender.tag;
        [self processDigit: numberPressed];
        [insetLabel removeFromSuperview];
    }
    
}

- (void) processDigit:(int)numberPressed
{
    [displayString appendString:[NSString stringWithFormat:@"%i", numberPressed]];
    mainTextField.text = displayString;
    
}

- (void)pressBsButton:(UIButton *)sender
{
    
    //delete one digit at a time
    if (displayString.length == 0) {
        return;
    } else if (displayString.length == 1){
        NSRange currentRange = {0,1};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 2) {
        NSRange currentRange = {1,1};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 3) {
        NSRange currentRange = {2,1};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 4) {
        NSRange currentRange = {3,1};
        [displayString deleteCharactersInRange:currentRange];
    }
    
    //display new string after deletion
    mainTextField.text = displayString;
    
    /*
      display "enter base value" message once all values are deleted
      AND basevalue is not set
    */
    if (displayString.length == 0 && !baseValue) {
        [mainTextField addSubview:insetLabel];
    }
}

-(void) pressBaseButton: (UIButton *) sender
{

    //throw up alert if display is empty or equal to zero
    if ((displayString.length == 0) || ([displayString intValue] == 0)) {
        
        //throw up alert that base is not set ONLY if there isn't
        //a base value already set
        if (!baseValue) {
            [noBaseValueAlert show];
        }
        
        //clear display
        if (displayString.length == 1) {
            NSRange currentRange = {0,1};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 2) {
            NSRange currentRange = {0,2};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 3) {
            NSRange currentRange = {0,3};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 4) {
            NSRange currentRange = {0,4};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        }
        
    }

    //add leading zero removal condition
    NSRange oneDigit = {0,1};
    if (displayString.length == 2) { //disables crash due to display string being nil
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    } else if (displayString.length == 3) {
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    } else if (displayString.length == 4) {
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    }
    
    baseValue = [displayString intValue];
    
    //make basebutton blue when base value is not nil
    if (baseValue) {
        [baseButton setTitleColor:[UIColor colorWithRed:0.0f green:0.50f blue:255.0f alpha:1.0f] forState:UIControlStateNormal];
        [baseButton setTitle:@"Set Base" forState:UIControlStateNormal];
    } else if (!baseValue){
        [baseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [baseButton setTitle:@"Set Base" forState:UIControlStateNormal];
        [mainTextField addSubview:insetLabel];
    }
    
    //add base value button to mainTextField
    CGRect baseValueLabelRect = CGRectMake(5.0f, 0.0f, 40.0f, 26.0f);
    NSParagraphStyle *baseValueLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *baseValueLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:18.0f], NSFontAttributeName,[UIColor colorWithRed:0.0f green:0.50f blue:1.0f alpha:1.0f], NSForegroundColorAttributeName, baseValueLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *baseValueLabelText = [[NSAttributedString alloc] initWithString: displayString attributes:baseValueLabelTextDictionary];
    if (!baseValueLabel) {
        baseValueLabel = [[UILabel alloc] initWithFrame:baseValueLabelRect];
    }
    baseValueLabel.attributedText = baseValueLabelText;
    baseValueLabel.backgroundColor = [UIColor clearColor];
    [mainTextField addSubview:baseValueLabel];
    
    //clear display after base is set
    if (displayString.length == 1){
        NSRange currentRange = {0,1};
        [displayString deleteCharactersInRange:currentRange];
        mainTextField.text = displayString;
        [insetLabel removeFromSuperview];
    } else if (displayString.length == 2) {
        NSRange currentRange = {0,2};
        [displayString deleteCharactersInRange:currentRange];
        mainTextField.text = displayString;
        [insetLabel removeFromSuperview];
    } else if (displayString.length == 3) {
        NSRange currentRange = {0,3};
        [displayString deleteCharactersInRange:currentRange];
        mainTextField.text = displayString;
    } else if (displayString.length == 4) {
        NSRange currentRange = {0,4};
        [displayString deleteCharactersInRange:currentRange];
        mainTextField.text = displayString;
        [insetLabel removeFromSuperview];
    }

}

- (void) convertToPixels: (UIButton *) sender;
{
    //throw up alert that base is not set
    if (!baseValue) {
        
        [noBaseValueAlert show];
        
        //clear display
        if (displayString.length == 1){
            NSRange currentRange = {0,1};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 2) {
            NSRange currentRange = {0,2};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 3) {
            NSRange currentRange = {0,3};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 4) {
            NSRange currentRange = {0,4};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        }
        
        [mainTextField addSubview:insetLabel];
    
        return;
        
    } else if (displayString.length == 0){
        [noConversionValueAlert show];
        return;
    }
    
    //remove point UOM and value label
    [ptUOMLabel removeFromSuperview];
    [ptValueLabel removeFromSuperview];
    
    //set basevalue for conversion
    [myConverter setBaseValue:baseValue];
    
    //add leading zero removal condition
    NSRange oneDigit = {0,1};
    if (displayString.length == 2) { //disables crash due to display string being nil
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    } else if (displayString.length == 3) {
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    } else if (displayString.length == 4) {
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    }
    
    mainTextField.text = displayString;
    
    //set value to convert
    [myConverter setValueToConvert:[mainTextField.text intValue]];
    
    //convert to pixel, em, and percent
    int currentPixelValue = [myConverter convertToPixel];
    float currentEmsValue = [myConverter convertToEms];
    float currentPercentValue = [myConverter convertToPercent];
    
    //change int and float values to string for display
    NSString *pxValueString = [NSString stringWithFormat:@"%i", currentPixelValue];
    NSString *emsValueString = [NSString stringWithFormat:@"%3.2f", currentEmsValue];
    NSString *percentValueString = [NSString stringWithFormat:@"%5.2f", currentPercentValue];
    
    //build pixel UOM label
    CGRect pxUOMLabelRect = CGRectMake(260.0f, 20.0f, 30.0f, 30.0f);
    NSParagraphStyle *pxUOMLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *pxUOMLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:24.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, pxUOMLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *pxUOMLabelText = [[NSAttributedString alloc] initWithString: @"px" attributes:pxUOMLabelTextDictionary];
    if (!pxUOMLabel) {
        pxUOMLabel = [[UILabel alloc] initWithFrame:pxUOMLabelRect];
    }
    pxUOMLabel.attributedText = pxUOMLabelText;
    pxUOMLabel.backgroundColor = [UIColor clearColor];
    
    //build pixel value label
    CGRect pxValueLabelRect = CGRectMake(0.0f, 15.0f, 240.0f, 40.0f);
    NSParagraphStyle *pxValueLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *pxValueLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:50.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, pxValueLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *pxValueLabelText = [[NSAttributedString alloc] initWithString: pxValueString attributes:pxValueLabelTextDictionary];
    if (!pxValueLabel) {
        pxValueLabel = [[UILabel alloc] initWithFrame:pxValueLabelRect];
    }
    pxValueLabel.attributedText = pxValueLabelText;
    pxValueLabel.textAlignment = NSTextAlignmentRight;
    pxValueLabel.backgroundColor = [UIColor clearColor];
    
    //build percent value label
    CGRect percentValueLabelRect = CGRectMake(0.0f, 15.0f, 240.0f, 40.0f);
    NSParagraphStyle *percentValueLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *percentValueLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:50.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, percentValueLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *percentValueLabelText = [[NSAttributedString alloc] initWithString: percentValueString attributes:percentValueLabelTextDictionary];
    if (!percentValueLabel) {
        percentValueLabel = [[UILabel alloc] initWithFrame:percentValueLabelRect];
    }
    percentValueLabel.attributedText = percentValueLabelText;
    percentValueLabel.textAlignment = NSTextAlignmentRight;
    percentValueLabel.backgroundColor = [UIColor clearColor];
    
    //build ems value label
    CGRect emsValueLabelRect = CGRectMake(0.0f, 15.0f, 240.0f, 40.0f);
    NSParagraphStyle *emsValueLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *emsValueLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:50.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, emsValueLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *emsValueLabelText = [[NSAttributedString alloc] initWithString: emsValueString attributes:emsValueLabelTextDictionary];
    if (!emsValueLabel) {
        emsValueLabel = [[UILabel alloc] initWithFrame:emsValueLabelRect];
    }
    emsValueLabel.attributedText = emsValueLabelText;
    emsValueLabel.textAlignment = NSTextAlignmentRight;
    emsValueLabel.backgroundColor = [UIColor clearColor];
    
    //add UOM to appropriate conversion views
    [firstConversionView addSubview:emsUOMLabel];
    [firstConversionView addSubview:emsValueLabel];
    [secondConversionView addSubview:percentUOMLabel];
    [secondConversionView addSubview:percentValueLabel];
    [thirdConversionView addSubview:pxUOMLabel];
    [thirdConversionView addSubview:pxValueLabel];
    
    [mainTextField resignFirstResponder];
    
    //clear display value but NOT mainTextField value
    if (displayString.length == 1){
        NSRange currentRange = {0,1};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 2) {
        NSRange currentRange = {0,2};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 3) {
        NSRange currentRange = {0,3};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 4) {
        NSRange currentRange = {0,4};
        [displayString deleteCharactersInRange:currentRange];
    }
    
}

- (void) convertToPoints: (UIButton *) sender;
{
    //throw up alert that base is not set
    if (!baseValue) {
        
        [noBaseValueAlert show];
        
        //clear display
        if (displayString.length == 1){
            NSRange currentRange = {0,1};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 2) {
            NSRange currentRange = {0,2};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 3) {
            NSRange currentRange = {0,3};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        } else if (displayString.length == 4) {
            NSRange currentRange = {0,4};
            [displayString deleteCharactersInRange:currentRange];
            mainTextField.text = displayString;
        }
        
        [mainTextField addSubview:insetLabel];
        
        return;
        
    } else if (displayString.length == 0){
        [noConversionValueAlert show];
        return;
    }
    
    //remove px UOM and value label
    [pxUOMLabel removeFromSuperview];
    [pxValueLabel removeFromSuperview];
    
    //set base value to convert
    [myConverter setBaseValue:baseValue];
    
    //add leading zero removal condition
    NSRange oneDigit = {0,1};
    if (displayString.length == 2) { //disables crash due to display string being nil
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    } else if (displayString.length == 3) {
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    } else if (displayString.length == 4) {
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
        [displayString replaceOccurrencesOfString:@"0" withString:@"" options:NSLiteralSearch range:oneDigit];
    }

    
     mainTextField.text = displayString;
    
    //set value to convert
    [myConverter setValueToConvert:[mainTextField.text intValue]];
    
    //convert to point, em, and percent
    int currentPointValue = [myConverter convertToPoint];
    float currentEmsValue = [myConverter convertToEms];
    float currentPercentValue = [myConverter convertToPercent];
    
    //change int and float values to string for display
    NSString *ptValueString = [NSString stringWithFormat:@"%i", currentPointValue];
    NSString *emsValueString = [NSString stringWithFormat:@"%3.2f", currentEmsValue];
    NSString *percentValueString = [NSString stringWithFormat:@"%5.2f", currentPercentValue];
    
    //build point UOM label
    CGRect ptUOMLabelRect = CGRectMake(260.0f, 20.0f, 30.0f, 30.0f);
    NSParagraphStyle *ptUOMLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *ptUOMLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:24.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, ptUOMLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *ptUOMLabelText = [[NSAttributedString alloc] initWithString: @"pt" attributes:ptUOMLabelTextDictionary];
    if (!ptUOMLabel) {
        ptUOMLabel = [[UILabel alloc] initWithFrame:ptUOMLabelRect];
    }
    ptUOMLabel.attributedText = ptUOMLabelText;
    ptUOMLabel.backgroundColor = [UIColor clearColor];
    
    //build point value label
    CGRect ptValueLabelRect = CGRectMake(0.0f, 15.0f, 240.0f, 40.0f);
    NSParagraphStyle *ptValueLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *ptValueLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:50.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, ptValueLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *ptValueLabelText = [[NSAttributedString alloc] initWithString: ptValueString attributes:ptValueLabelTextDictionary];
    if (!ptValueLabel) {
        ptValueLabel = [[UILabel alloc] initWithFrame:ptValueLabelRect];
    }
    ptValueLabel.attributedText = ptValueLabelText;
    ptValueLabel.textAlignment = NSTextAlignmentRight;
    ptValueLabel.backgroundColor = [UIColor clearColor];
    
    //build percent value label
    CGRect percentValueLabelRect = CGRectMake(0.0f, 15.0f, 240.0f, 40.0f);
    NSParagraphStyle *percentValueLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *percentValueLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:50.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, percentValueLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *percentValueLabelText = [[NSAttributedString alloc] initWithString: percentValueString attributes:percentValueLabelTextDictionary];
    if (!percentValueLabel) {
        percentValueLabel = [[UILabel alloc] initWithFrame:percentValueLabelRect];
    }
    percentValueLabel.attributedText = percentValueLabelText;
    percentValueLabel.textAlignment = NSTextAlignmentRight;
    percentValueLabel.backgroundColor = [UIColor clearColor];
    
    //build ems value label
    CGRect emsValueLabelRect = CGRectMake(0.0f, 15.0f, 240.0f, 40.0f);
    NSParagraphStyle *emsValueLabelStyle = [NSParagraphStyle defaultParagraphStyle];
    NSDictionary *emsValueLabelTextDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica" size:50.0f], NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, emsValueLabelStyle, NSParagraphStyleAttributeName, nil];
    NSAttributedString *emsValueLabelText = [[NSAttributedString alloc] initWithString: emsValueString attributes:emsValueLabelTextDictionary];
    if (!emsValueLabel) {
        emsValueLabel = [[UILabel alloc] initWithFrame:emsValueLabelRect];
    }
    emsValueLabel.attributedText = emsValueLabelText;
    emsValueLabel.textAlignment = NSTextAlignmentRight;
    emsValueLabel.backgroundColor = [UIColor clearColor];
    
    //add to appropriate conversion view
    [firstConversionView addSubview:emsUOMLabel];
    [firstConversionView addSubview:emsValueLabel];
    [secondConversionView addSubview:percentUOMLabel];
    [secondConversionView addSubview:percentValueLabel];
    [thirdConversionView addSubview:ptUOMLabel];
    [thirdConversionView addSubview:ptValueLabel];
    
    [mainTextField resignFirstResponder];
    
    //clear display but NOT mainTextField value
    if (displayString.length == 1){
        NSRange currentRange = {0,1};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 2) {
        NSRange currentRange = {0,2};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 3) {
        NSRange currentRange = {0,3};
        [displayString deleteCharactersInRange:currentRange];
    } else if (displayString.length == 4) {
        NSRange currentRange = {0,4};
        [displayString deleteCharactersInRange:currentRange];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
