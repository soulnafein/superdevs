describe("ActiveAjax Model", function() {
  var json = {'person' : {'name':'David', 'surname':'Santoro'}};

  it ("should generate accessors for each json attribute", function() {
    var model = ActiveAjax.Model(json);

    model.name('Mike');
    model.surname('Wagg');

    expect(model.name()).toEqual('Mike');
    expect(model.surname()).toEqual('Wagg');
  });

  it ("should notify subscribers when attributes are updated", function() {
    var model = ActiveAjax.Model(json);
    var listOfChanges = [];
    model.onNameChanged(function(newName) {listOfChanges.push(newName);});
    model.onNameChanged(function(newName) {listOfChanges.push(newName);});

    model.name("X");
    model.name("Y");

    expect(listOfChanges).toEqual(["X", "X", "Y", "Y"]);
  });
});
