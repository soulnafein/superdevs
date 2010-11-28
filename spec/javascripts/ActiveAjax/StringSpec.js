describe("Converting a string to camel case", function() {
  it("should capitalize the first letter", function() {
    var aString = "nameChanged";
    expect(aString.capitalize()).toEqual("NameChanged");
  });
});