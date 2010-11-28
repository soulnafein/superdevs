String.prototype.capitalize = function() {
  return this.replace(/^(\w)/, function() { return arguments[1].toUpperCase()})
};