//
//  JbD_Opus001_Converter.m
//  Pixel Coder
//
//  Created by John E Russo on 1/9/13.
//  Copyright (c) 2013 John E Russo. All rights reserved.
//

#import "JbD_Opus001_Converter.h"

@implementation JbD_Opus001_Converter


-(void) setBaseValue:(int)theValue
{
    baseValue = theValue;
}

-(void) setValueToConvert: (int) aValue
{
    valueToConvert = aValue;
}

-(int) convertToPixel
{
    int myValue = valueToConvert;
    pixelValue = round(myValue * 1.33);
    return pixelValue;
}
-(int) convertToPoint
{
    int myValue = valueToConvert;
    pointValue = round(myValue * 0.75);
    return pointValue;
}

-(float) convertToEms
{
    float myValue = (float) valueToConvert;
    emsValue = myValue / baseValue;
    return emsValue;
}

-(float) convertToPercent
{
    percentValue = [self convertToEms] * 100;
    return percentValue;
}

@end