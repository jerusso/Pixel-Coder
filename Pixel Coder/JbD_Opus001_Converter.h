//
//  JbD_Opus001_Converter.h
//  Pixel Coder
//
//  Created by John E Russo on 1/9/13.
//  Copyright (c) 2013-2014 John E Russo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JbD_Opus001_Converter : NSObject
{
    int pointValue;
    int pixelValue;
    float percentValue;
    float emsValue;
    int baseValue;
    int valueToConvert;
}

-(void) setBaseValue:(int) theBaseValue;
-(void) setValueToConvert: (int) aValue;
-(int) convertToPixel;
-(int) convertToPoint;
-(float) convertToEms;
-(float) convertToPercent;



@end