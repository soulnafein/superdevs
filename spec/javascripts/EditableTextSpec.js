describe("Editable text spec", function() {
  var anHeader;
  var user = ActiveAjax.Model({'user' : {'name':'David', 'surname':'Wagg'}});

  function textbox() {
    return anHeader.find('input[type=text]');
  }

  beforeEach(function() {
    inHtmlFixture(function(html) {
      anHeader = $("<h1>David</h1>");
      html.append(anHeader);
    });
    var options = {
      htmlElement: anHeader,
      model: user,
      fieldName: 'name'
    };
    SuperDevs.EditableText(options);
  });

  it("should make me edit the name when I click it", function() {
    anHeader.click();

    expect(textbox()).toBeOneElementWithValueEqual('David');
    expect(textbox()).toBeFocused();
  });

  it("should change the model when loosing focus from the textbox", function() {
    anHeader.click();
    var textbox = textbox();
    textbox.val('Whatever');
    textbox.blur();

    expect(user.name()).toEqual('Whatever');
    expect(anHeader.html()).toEqual('Whatever');
  });

  it("should change the element text when the model changes", function() {
    user.name('Luigi');
    expect(anHeader.text()).toEqual('Luigi');
  });

  it("should work many times", function() {
    anHeader.click();
    var textbox = textbox();
    textbox.val('Whatever');
    textbox.blur();
    expect(user.name()).toEqual('Whatever');

    anHeader.click();
    textbox.val('Santoro');
    textbox.blur();
    expect(user.name()).toEqual('Santoro');

  })
});

function inHtmlFixture(action) {
  $("#fixture").remove();
  var fixture = $("<div id='fixture'></div>");
  $("body").append(fixture);
  action(fixture);
}
