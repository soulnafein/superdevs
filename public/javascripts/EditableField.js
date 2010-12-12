var SuperDevs = SuperDevs || {};

SuperDevs.EditableField = function(params, editingElement) {
  var elem = params.htmlElement;
  var model = params.model;
  var field = params.fieldName;
  var currentState;
  var addLink = $("<a class='add' href='#'>"+params.addLinkText+"</a>");

  function init() {
    elem.click(function() { currentState.onElementClicked() });
    addLink.click(function() { currentState.onAddLinkClicked()});
    editingElement.blur(function() {currentState.onEditingCompleted()});
    model.onChanged(field, function(newValue) {elem.html(newValue)});
    changeState(states.initial);
  }

  var states = {};

  states = {
    initial: {
      onEnter: function() {
        if(getValue() === '' || getValue() === null)
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
        editingElement.detach();
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
    editingElement.val(getValue());
    elem.html(editingElement);
    editingElement.focus();
  }

  function changeModel() {
    model[field](editingElement.val());
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