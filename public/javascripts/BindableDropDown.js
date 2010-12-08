var SuperDevs = SuperDevs || {};

SuperDevs.BindableDropDown = function(dropDown, model, fieldName) {
  function init() {
    dropDown.change(function() {
      model[fieldName](dropDown.val());
    })
  }
  init();
  return {};
};