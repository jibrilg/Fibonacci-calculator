#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>
#import <Cordova/CDVPlugin.h>

@interface FibonacciCalculator : CDVPlugin

- (void)calculate:(CDVInvokedUrlCommand*)command;

@end
