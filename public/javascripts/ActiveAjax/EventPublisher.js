var ActiveAjax = ActiveAjax || {};

ActiveAjax.EventPublisher = function() {
  var publ = {};
  var priv = {};
  priv.subscriptions = {};

  publ.canFire = function(eventName) {
    priv.subscriptions[eventName] = [];
    publ[('on_' + eventName).toCamelCase()] = function(action) {
      priv.subscriptions[eventName].push(action);
    };
  };

  publ.fire = function(eventName, value) {
    priv.subscriptions[eventName].foreach(function(action) {
      action(value);
    });
  };

  return publ;
};