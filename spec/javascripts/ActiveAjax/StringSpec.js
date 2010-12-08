describe("Capitalize a string", function() {
  it("should capitalize the first letter", function() {
    var aString = "nameChanged";
    expect(aString.capitalize()).toEqual("NameChanged");
  });
});

describe("Converting a string to camel case", function() {
  it("should remove underscore and capitalize the next word", function() {
    var aString = "whatever_you_like";

    expect(aString.toCamelCase()).toEqual("whateverYouLike");
  });

  it("should remove lowercase first letter", function() {
    var aString = "Lowercaseme"

    expect(aString.toCamelCase()).toEqual("lowercaseme")
  });
});