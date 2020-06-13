#import "FibonacciCalculator.h"


@interface FibonacciCalculator()
@property (nonatomic, copy) NSString* callbackId;
@end

@implementation FibonacciCalculator

@synthesize callbackId;

static int MAX_NUMBER = 40;

- (UIViewController *)getTopPresentedViewController {
  UIViewController *presentingViewController = self.viewController;

  if (presentingViewController.view.window != [UIApplication sharedApplication].keyWindow){
    presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
  }

  while (presentingViewController.presentedViewController != nil && ![presentingViewController.presentedViewController isBeingDismissed]){
    presentingViewController = presentingViewController.presentedViewController;
  }

  return presentingViewController;
}

- (void)tryAgain {
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fibonacci Calculator"
                                                                           message:@"Invalid value"
                                                                    preferredStyle:UIAlertControllerStyleAlert];

  __weak FibonacciCalculator* weakSelf = self;

  [alertController addAction: [UIAlertAction actionWithTitle:@"Try Again"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
    [weakSelf showDialog: -1];
  }]];

  [alertController addAction: [UIAlertAction actionWithTitle:@"Cancel"
                                                       style:UIAlertActionStyleDestructive
                                                     handler:^(UIAlertAction * action) {
    [weakSelf sendResult:-1 forInput: -1];
  }]];

  [self.getTopPresentedViewController presentViewController:alertController animated:YES completion: nil];
}

- (void)showDialog:(int)input {

  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Fibonacci Calculator"
                                                                           message:[NSString stringWithFormat:@"Enter a positive number\nless or equal to %d", MAX_NUMBER]
                                                                    preferredStyle:UIAlertControllerStyleAlert];

  __weak FibonacciCalculator* weakSelf = self;

  [alertController addAction: [UIAlertAction actionWithTitle:@"Calculate"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * action) {
    NSString* value = [[alertController.textFields objectAtIndex:0] text];
    int intValue = value.intValue;

    if ((intValue < 0) || (intValue > MAX_NUMBER)) {
      [weakSelf tryAgain];
      return;
    }

    int fibonacci = [weakSelf fibonacciNumbers:intValue];

    [weakSelf sendResult:fibonacci forInput:intValue];
  }]];

  [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel"
                                                      style:UIAlertActionStyleDestructive
                                                    handler:^(UIAlertAction * action) {
    [weakSelf sendResult:-1 forInput:-1];
  }]];

  [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    textField.placeholder = @"10";
    textField.text = input > -1 ? [NSString stringWithFormat:@"%d", input] : 0;
  }];

  [self.getTopPresentedViewController presentViewController:alertController animated:YES completion: nil];
}

- (void)sendResult:(int)fibonacciNumber forInput:(int)input {
  NSDictionary* info;

  if (fibonacciNumber < 0) {
    info = @{
      @"result":@"Error",
    };
  } else {
    info = @{
      @"input": @(input),
      @"result": @(fibonacciNumber),
    };
  }

  CDVPluginResult* result = [CDVPluginResult resultWithStatus:(fibonacciNumber < 0 ? CDVCommandStatus_ERROR : CDVCommandStatus_OK)
                                          messageAsDictionary:info];

  [self.commandDelegate sendPluginResult:result callbackId: callbackId];
}

- (void)calculate:(CDVInvokedUrlCommand*)command {
  callbackId = command.callbackId;
  NSDictionary* json = [command argumentAtIndex:0];

  int input = [json[@"input"] intValue];

  NSLog(@"callbackId: %@ | message: %@ | input: %d", callbackId, json, input);

  [self showDialog: input];
}

- (int) fibonacciNumbers:(int) n {
  NSMutableArray *fibSeries = [NSMutableArray new];

  int total = 0;
  int prev = 1;
  for (int x=1; x<n; x++){
    total = total + prev;
    prev = total - prev;
    [fibSeries addObject:[NSNumber numberWithInt:total]];
  }

  NSLog(@"Fibonacci numbers are: %@", fibSeries);

  return total;
}

@end
