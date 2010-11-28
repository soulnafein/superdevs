var SuperDevs = SuperDevs || {};

SuperDevs.EditableText = function(element, model, field) {
  var priv = {};

  var textbox = $("<input type='text' val='' />");

  priv.init = function() {
    element.click(priv.showTextbox);
    model['on'+field.capitalize()+'Changed'](function(newValue) {
      element.html(newValue);
    })
  };

  priv.isEditing = false;
  priv.notEditing = function() {
    return !priv.isEditing;
  };

  priv.showTextbox = function() {
    if (priv.notEditing()) {
      textbox.val(model[field]());
      element.html(textbox);
      textbox.blur(priv.changeModel);
      textbox.focus();
      priv.isEditing = true;
    }
  };

  priv.changeModel = function () {
    model[field](textbox.val());
    priv.isEditing = false;
  };

  priv.init();

  return {

  };
};