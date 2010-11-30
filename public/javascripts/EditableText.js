var SuperDevs = SuperDevs || {};

SuperDevs.EditableText = function(params) {
  var textbox = $("<input type='text' val='' />");
  var isEditing = false;
  var elem = params.htmlElement;
  var model = params.model;
  var field = params.fieldName;

  function init() {
    elem.click(showTextbox);
    var methodName = ('on_' + field + 'Changed').toCamelCase();
    model[methodName](function(newValue) {
      elem.html(newValue);
    });
  }

  function notEditing() {
    return !isEditing;
  }

  function showTextbox() {
    if (notEditing()) {
      textbox.val(model[field]());
      elem.html(textbox);
      textbox.blur(changeModel);
      textbox.focus();
      isEditing = true;
    }
  }

  function changeModel() {
    model[field](textbox.val());
    isEditing = false;
  }

  init();

  return {};
};