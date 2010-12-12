var ActiveAjax = ActiveAjax || {};

ActiveAjax.Model = function(json, url) {
  var priv = {};
  var publ = ActiveAjax.EventPublisher();

  priv.ajax = ActiveAjax.Ajax;

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
      priv.save();
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

  priv.save = function() {
    params = {};
    params[priv.modelName] = priv.replaceNullsWithEmpty(priv.getModel());
    priv.ajax.put(url, params);
  };

  priv.replaceNullsWithEmpty = function(anObject) {
    var newObject = {};
    for(var m in anObject) {
      if (anObject[m]!=null){
        newObject[m] = anObject[m];
      }
    }
    return newObject;
  };

  priv.init = function() {
    priv.calculateModelName();
    priv.generateMethods();
  };

  priv.init();

  publ.onChanged = function(fieldName, action) {
    publ[('on_' + fieldName + 'Changed').toCamelCase()](action);
  };

  publ.valueOf = function(fieldName) {
    return publ[fieldName]();
  };

  return publ;
};