describe("BindableDropDown", function() {
  var json, model, dropDown;

  beforeEach(function() {
    json = {user:{name:'David', country:'uk'}};
    model = ActiveAjax.Model(json);
    dropDown = $("<select>" +
                    "<option value='italy'>Italia</option>" +
                    "<option value='germany'>Deutschland</option>" +
                 "</select>");
    SuperDevs.BindableDropDown(dropDown, model, 'country');
  });

  it("should change model when dropdown value changes", function() {
    dropDown.val("italy");
    dropDown.change();
    expect(model.country()).toEqual("italy");
  });
});