describe("ActiveAjax Model", function() {
  var json = {'person' : {'name':'David', 'surname':'Santoro'}};

  beforeEach(function() {
    spyOn(jQuery, 'ajax').andCallFake(function() {});
  });

  it ("should generate accessors for each json attribute", function() {
    var model = ActiveAjax.Model(json);

    model.name('Mike');
    model.surname('Wagg');

    expect(model.name()).toEqual('Mike');
    expect(model.valueOf('surname')).toEqual('Wagg');
  });

  it ("should notify subscribers when attributes are updated", function() {
    var model = ActiveAjax.Model(json);
    var listOfChanges = [];
    model.onNameChanged(function(newName) {listOfChanges.push(newName);});
    model.onChanged('name', function(newName) {listOfChanges.push(newName);});

    model.name("X");
    model.name("Y");

    expect(listOfChanges).toEqual(["X", "X", "Y", "Y"]);
  });

  it("should persist changes automatically", function() {
    spyOn(ActiveAjax.Ajax, 'put');
    var model = ActiveAjax.Model(json, '/users/123');
    model.name("X");

    expect(ActiveAjax.Ajax.put).toHaveBeenCalledWith('/users/123', json);
  });
});
