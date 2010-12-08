var SuperDevs = SuperDevs || {};

SuperDevs.BindableList = function(list, model, fieldName) {
  function init() {
    model.onChanged(fieldName, function(newValues){
      removeAllItems();
      var values = splitValues(newValues);
      addItems(values);
    });
  }
  init();

  function removeAllItems() {
    list.empty();
  }

  function splitValues(valueString) {
    return valueString.split(",");
  }

  function addItems(values) {
    values.foreach(function(value) {
      list.append("<li>"+value.trim()+"</li>");
    });
  }
  return {};
};