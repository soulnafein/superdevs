var SuperDevs = SuperDevs || {};

SuperDevs.BindableTextbox = function(textbox, model, fieldName) {
  function init() {
    textbox.val(model.valueOf(fieldName));
    model.onChanged(fieldName, function(newValue){textbox.val(newValue);});
    textbox.blur(function() {
      model[fieldName](textbox.val());
    })
  }
  init();
  return {};
};