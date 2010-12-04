var SuperDevs = SuperDevs || {};

SuperDevs.EditableText = function(params) {
  var elem = params.htmlElement;
  var model = params.model;
  var field = params.fieldName;
  var currentState;
  var textbox = $("<input type='text' val='' />");
  var addLink = $("<a class='add' href='#'>"+params.addLinkText+"</a>");

  function init() {
    elem.click(function() { currentState.onElementClicked() });
    addLink.click(function() { currentState.onAddLinkClicked()});
    textbox.blur(function() {currentState.onEditingCompleted()});
    model.onChanged(field, function(newValue) {elem.html(newValue)});
    changeState(states.initial);
  }

  var states = {};

  states = {
    initial: {
      onEnter: function() {
        if(getValue() === '')
          changeState(states.adding);
        else
          changeState(states.showing);
      }
    },
    showing: {
      onEnter: function() {elem.show()},
      onElementClicked: function() {
        changeState(states.editing);
      }
    },
    adding: {
      onEnter: function() {
        hideElement();
        showLink()
      },
      onAddLinkClicked: function() {
        changeState(states.editing)
      }
    },
    editing: {
      onEnter: function() {
        hideLink();
        showElement();
        showTextbox();
      },
      onEditingCompleted: function() {changeState(states.editingConfirmed);},
      onElementClicked: function() {}
    },
    editingConfirmed: {
      onEnter: function() {
        textbox.detach();
        changeModel();
        changeState(states.initial);
      }
    }
  };

  function showLink() {
    elem.after(addLink);
  }

  function hideLink() {
    addLink.detach();
  }

  function hideElement() {
    elem.hide();
  }

  function showElement() {
    elem.show();
  }

  function showTextbox() {
    textbox.val(getValue());
    elem.html(textbox);
    textbox.focus();
  }

  function changeModel() {
    model[field](textbox.val());
  }

  function getValue() {
    return model.valueOf(field);
  }

  function changeState(newState)
  {
    currentState = newState;
    var action = newState.onEnter;
    if (action) action();
  }

  init();

  return {};
};