var exec = require('cordova/exec');

var app = {
  // Application Constructor
  initialize: function() {
    document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
  },

  calculate: function(arg0, success, error) {
    exec(success, error, 'fibonacciCalculator', 'calculate', [arg0]);
  },

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
  },

  // Update DOM on a Received Event
  receivedEvent: function(id) {
    var parentElement = document.getElementById(id);
    var listeningElement = parentElement.querySelector('.listening');
    var receivedElement = parentElement.querySelector('.received');

    listeningElement.setAttribute('style', 'display:none;');
    receivedElement.setAttribute('style', 'display:block;');

    console.log('Received 2 Event: ' + id);
  }
};

app.initialize();
