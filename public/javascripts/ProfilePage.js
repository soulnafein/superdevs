var SuperDevs = SuperDevs || {};

SuperDevs.ProfilePage = function() {
  var priv = {};
  return {
    init: function(userJson) {
      var model = ActiveAjax.Model(userJson);
      this.TagLine.init(model);
    }
  }
}();

SuperDevs.ProfilePage.TagLine = function() {
  var tagLineLink = function() {return $("a.add.tagline")};
  var tagLineHeader = function() {return $("h3")};
  var hideTagLineLink = function() { tagLineLink().addClass("hidden")};

  return {
    init: function(model) {
      SuperDevs.EditableText(tagLineHeader(), model, 'tagline');

      tagLineLink().click(function() {
        hideTagLineLink();
        tagLineHeader().removeClass("hidden");
        tagLineHeader().click();
        return false;
      });

    }
  }
}();