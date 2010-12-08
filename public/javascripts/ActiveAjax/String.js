String.prototype.capitalize = function() {
  return this.replace(/^(\w)/, function() { return arguments[1].toUpperCase()})
};

String.prototype.toCamelCase = function() {
  return this.replace(/^(\w)/,
                      function() { return arguments[1].toLowerCase()})
             .replace(/_([^_])/g,
                      function() { return arguments[1].toUpperCase()})
};

