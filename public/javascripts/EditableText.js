var SuperDevs = SuperDevs || {};

SuperDevs.EditableText = function(params) {
  var elem = params.htmlElement;
  var model = params.model;
  var field = params.fieldName;
  var currentState;
  var textbox = $("<input type='text' val='' />");
  var addLink = $("<a href='#'>"+params.addLinkText+"</a>");

  function init() {
    if(value() === '')
    {
      currentState
    }

    currentState = value() === '' ? transitions.toAddingState() : transitions.to
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
    },
    adding: {
    }
  };

  function hideLink() {

  }

  function showTextbox() {
    textbox.val(model.valueOf(field));
    elem.html(textbox);
    textbox.focus();
  }

  function changeModel() {
    model[field](textbox.val());
  }

  function value() {
    model[field]();
  }

  init();

  return {};
};