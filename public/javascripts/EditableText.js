var SuperDevs = SuperDevs || {};

SuperDevs.EditableText = function(params) {
  var textbox = $("<input type='text' val='' />");
  var elem = params.htmlElement;
  var model = params.model;
  var field = params.fieldName;
  var currentState;

  function init() {
    currentState = states.showing;
    elem.click(function() { currentState.elementClicked() });
    textbox.blur(function() {currentState.editingCompleted()});
    model.onChanged(field, function(newValue) {elem.html(newValue)});
  }

  var states = {};
  var transitions = {};

  transitions = {
    fromEditingToShowing: function() {
      currentState=states.showing;
      textbox.detach();
      changeModel();
    },
    fromShowingToEditing: function() {
      currentState = states.editing;
      showTextbox();
    }
  };

  states = {
    editing: {
      editingCompleted: transitions.fromEditingToShowing
    },
    showing: {
      elementClicked: transitions.fromShowingToEditing
    }
  };

  function showTextbox() {
    textbox.val(model.valueOf(field));
    elem.html(textbox);
    textbox.focus();
  }

  function changeModel() {
    model[field](textbox.val());
  }

  init();

  return {};
};