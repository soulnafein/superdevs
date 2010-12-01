describe("Editable text spec", function() {
  var anHeader;
  var user = ActiveAjax.Model({'user' : {'name':'David', 'surname':'Wagg'}});

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
    var newTextbox = anHeader.find('input[type=text]');

    expect(newTextbox.length).toEqual(1);
    expect(newTextbox.val()).toEqual('David');

    expect(newTextbox[0]).toEqual(document.activeElement);
  });

  it("should change the model when loosing focus from the textbox", function() {
    anHeader.click();
    var newTextbox = anHeader.find('input[type=text]');
    newTextbox.val('Whatever');
    newTextbox.blur();

    expect(user.name()).toEqual('Whatever');
    expect(anHeader.html()).toEqual('Whatever');
  });

  it("should change the element text when the model changes", function() {
    user.name('Luigi');

    expect(anHeader.text()).toEqual('Luigi');
  });

  it("should work many times", function() {
    anHeader.click();
    var newTextbox = anHeader.find('input[type=text]');
    newTextbox.val('Whatever');
    newTextbox.blur();
    expect(user.name()).toEqual('Whatever');

    anHeader.click();
    newTextbox.val('Santoro');
    newTextbox.blur();
    expect(user.name()).toEqual('Santoro');

  })
});

function inHtmlFixture(action) {
  $("#fixture").remove();
  var fixture = $("<div id='fixture'></div>");
  $("body").append(fixture);
  action(fixture);
}
