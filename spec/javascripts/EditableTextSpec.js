describe("Editable text spec", function() {
  var anHeader;
  var user = ActiveAjax.Model({'user' : {'name':'David', 'surname':'Wagg'}});


  beforeEach(function() {
    HtmlFixture("<h1>David</h1>");
    anHeader = $("h1");
    var options = {
      htmlElement: anHeader,
      model: user,
      fieldName: 'name'
    };
    SuperDevs.EditableText(options);
  });

  function getTexbox() {
    return anHeader.find('input[type=text]');
  }

  it("should make me edit the name when I click it", function() {
    anHeader.click();

    expect(getTexbox()).toBeOneElementWithValueEqual('David');
    expect(getTexbox()).toBeFocused();
  });

  it("should change the model when loosing focus from the textbox", function() {
    anHeader.click();
    var textbox = getTexbox();
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
    var textbox = getTexbox();
    textbox.val('Whatever');
    textbox.blur();
    expect(user.name()).toEqual('Whatever');

    anHeader.click();
    textbox.val('Santoro');
    textbox.blur();
    expect(user.name()).toEqual('Santoro');
  })
});

describe("Editable text spec when starting with an empty value", function() {
  var brandHeader;

  beforeEach(function() {
    HtmlFixture("<h3 style='display:none'></h3>");
    brandHeader = $("h3");
  });

  it("should show a link", function() {
    var car = ActiveAjax.Model({'car':{'brand':''}});
    var options = {
      htmlElement: brandHeader,
      model: car,
      fieldName: 'brand',
      addLinkText: 'Add a brand'
    };
    SuperDevs.EditableText(options);

    var link = HTML().find('a');
    expect(link.length).toEqual(1);
    expect(link.text()).toEqual('Add a brand');
  })
});

function HtmlFixture(html) {
  $("#fixture").remove();
  var fixture = $("<div id='fixture'></div>");
  $("body").append(fixture);
  fixture.append(html);
}

function HTML() {
  return $("#fixture");
}


