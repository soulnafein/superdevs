describe("Editable interests list", function() {
  var json, model, textbox;

  beforeEach(function() {
    json = {user:{name:'David', interests: 'Sport, Jazz, Ruby'}};
    model = ActiveAjax.Model(json);
    list = $("<ul><li>Sport</li><li>Jazz</li><li>Ruby</li></ul>");
    SuperDevs.BindableList(list, model, 'interests');
  });

  it("should change the list elements when the model changes", function() {
    model.interests("Sailing, Football");
    var items = list.find("li");
    expect(items.length).toEqual(2);
    expect(items.first().text()).toEqual("Sailing");
    expect(items.last().text()).toEqual("Football");
  });
});