var ActiveAjax = ActiveAjax || {};

ActiveAjax.Model = function(json) {
  var priv = {};
  var publ = ActiveAjax.EventPublisher();

  priv.generateMethods = function() {
    for(var attributeName in priv.getModel()) {
      priv.generateAccessor(attributeName);
      priv.configureEvents(attributeName);
    }
  };

  priv.configureEvents = function(attributeName) {
    publ.canFire(attributeName+"Changed");
  };

  priv.generateAccessor = function(attributeName) {
    publ[attributeName] = function(value) {
      if (arguments.length == 0) {
        return priv.getModel()[attributeName];
      }

      priv.getModel()[attributeName] = value;
      publ.fire(attributeName+"Changed", value);
    };
  };

  priv.getModel = function() {
    return json[priv.modelName];
  };

  priv.calculateModelName = function() {
    var modelName = '';
    for (var attribute in json) {
      modelName = attribute;
    }
    priv.modelName = modelName;
  };

  priv.init = function() {
    priv.calculateModelName();
    priv.generateMethods();
  };
  priv.init();

  return publ;
};