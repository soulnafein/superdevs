var SuperDevs = SuperDevs || {};

SuperDevs.ProfilePage = function() {
  var priv = {};

  var tagLineHeader = function() {
    return $("h3")
  };

  var companyElement = function() {
    return $("span.company");
  };

  var cityElement = function() {
    return $("span.city");
  };

  var websiteElement = function() {
    return $("span.website");
  };

  var phoneElement = function() {
    return $("span.phone");
  };

  return {
    init: function(userJson, canEdit) {
      if (canEdit) {
        var model = ActiveAjax.Model(userJson);

        SuperDevs.EditableText({
          htmlElement: tagLineHeader(),
          model: model,
          fieldName: 'tagline',
          addLinkText: 'Add a tagline'});

        SuperDevs.EditableText({
          htmlElement: companyElement(),
          model: model,
          fieldName: 'company',
          addLinkText: 'Add a company'});

        SuperDevs.EditableText({
          htmlElement: cityElement(),
          model: model,
          fieldName: 'city',
          addLinkText: 'Choose a city'});

        SuperDevs.EditableText({
          htmlElement: websiteElement(),
          model: model,
          fieldName: 'website',
          addLinkText: 'Add a website'});

        SuperDevs.EditableText({
          htmlElement: phoneElement(),
          model: model,
          fieldName: 'phone_number',
          addLinkText: 'Choose a phone number'});
      }
    }
  }
}();

