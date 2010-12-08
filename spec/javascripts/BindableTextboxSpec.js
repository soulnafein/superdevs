describe("BindableTextbox", function() {
  var json, model, textbox;

  beforeEach(function() {
    json = {user:{name:'David', interests: 'Sport, Jazz, Ruby'}};
    model = ActiveAjax.Model(json);
    textbox = $("<input type='text'/>");
    SuperDevs.BindableTextbox(textbox, model, 'interests');
  });

  it("should set initial value of textbox as model", function() {
    expect(textbox.val()).toEqual(model.interests());
  });

  it("should change textbox value when model changes", function() {
    model.interests("Sailing, Sex");
    expect(textbox.val()).toEqual("Sailing, Sex");
  });

  it("should change model when textbox value changes", function() {
    textbox.val("Football, Programming");
    textbox.blur();
    expect(model.interests()).toEqual("Football, Programming");
  });
});