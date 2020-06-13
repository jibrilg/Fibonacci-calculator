# Fibonacci-calculator
An iOS sample Cordova plugin to calculate Fibonacci number

# Installation
```
cordova plugin add Fibonacci-calculator
```

# Method
`calculate` call expect just one parameter named `input` (see example below) to calculate its Fibonacci nummber.

```
  calculate: function(arg0, success, error) {
    exec(success, error, 'fibonacciCalculator', 'calculate', [arg0]);
  },
```

# Quick Example

```
  document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
  
  onDeviceReady: function() {
    this.receivedEvent('deviceready');
    this.calculate({"input": 5},
                   function(msg) {
                      document
                      .getElementById('deviceready')
                      .querySelector('.received')
                      .innerHTML = "Fib(" + msg["input"] + ") =" + msg["result"].toString();
                    },
                   function(err) {
                    document
                    .getElementById('deviceready')
                    .innerHTML = '<p class="event received">' + err + '</p>';
                  });
  }
  ```

# Use

App only shows the demo of the Fibonacci calculator inside cordova app on iOS.
