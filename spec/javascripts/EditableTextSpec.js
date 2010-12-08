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
    spyOn(jQuery, 'ajax').andCallFake(function() {});
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
  var brandHeader, options, car;


  beforeEach(function() {
    HtmlFixture("<h3 style='display:none'></h3>");
    brandHeader = $("h3");
    car = ActiveAjax.Model({'car':{'brand':''}});
    options = {
      htmlElement: brandHeader,
      model: car,
      fieldName: 'brand',
      addLinkText: 'Add a brand'
    };
    spyOn(jQuery, 'ajax').andCallFake(function() {});
  });

  it("should show a link", function() {
    SuperDevs.EditableText(options);
    var link = HTML().find('a');
    expect(link.length).toEqual(1);
    expect(link.text()).toEqual('Add a brand');
  });

  it("should hide the link after clicking it", function(){
    SuperDevs.EditableText(options);
    var link = HTML().find('a');
    link.click();
    expect(HTML().find('a').length).toEqual(0);
  });

  it("should should let me edit the brand after clicking the link", function() {
    SuperDevs.EditableText(options);
    var link = HTML().find('a');
    link.click();
    var textbox = HTML().find('input[type=text]');
    textbox.val("NewBrand").blur();

    expect(car.brand()).toEqual('NewBrand');
    expect(brandHeader.css('display')).toEqual('block');
    expect(brandHeader.text()).toEqual('NewBrand');
  });

  it("should show the link again and hide the element when edited to an empty value", function() {
    car.brand("Whatever");
    SuperDevs.EditableText(options);
    brandHeader.click();
    var textbox = HTML().find('input[type=text]');

    textbox.val("").blur();

    expect(HTML().find('a').length).toEqual(1);
    expect(brandHeader.css('display')).toEqual('none');

    HTML().find('a').click();

    expect(brandHeader.css('display')).toEqual('block');
  })
});



