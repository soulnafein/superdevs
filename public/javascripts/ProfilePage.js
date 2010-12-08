var SuperDevs = SuperDevs || {};

SuperDevs.ProfilePage = function() {
  var priv = {};

  function fullnameHeader() {
    return $("h2")
  }

  function tagLineHeader() {
    return $("h3")
  }

  function companyElement() {
    return $("span.company")
  }

  function cityElement() {
    return $("span.city")
  }

  function websiteElement() {
    return $("span.website")
  }

  function phoneElement() {
    return $("span.phone")
  }

  function bioParagraph() {
    return $("p.bio")
  }

  function interestsList() {
    return $("ul#interests");
  }

  function interestsTextbox() {
    return $("input.interests");
  }

  function editInterestsLink() {
    return $("a.edit.interests");
  }

  function countryDropDown() {
    return $("#user_country");
  }

  function initInterestsEditing(model) {
    SuperDevs.BindableList(interestsList(), model, 'interests');
    SuperDevs.BindableTextbox(interestsTextbox(), model, 'interests');
    editInterestsLink().click(function() {
      interestsTextbox().parent().show();
      interestsTextbox().focus();
      editInterestsLink().hide();
    });
    interestsTextbox().blur(function() {
      interestsTextbox().parent().hide();
      editInterestsLink().show();
    })
  }

  function initAccountsEditing() {
    $("a.edit.accounts").facebox();
  }

  return {
    init: function(userJson, canEdit) {
      if (canEdit) {
        var model = ActiveAjax.Model(userJson, '/users/' + userJson.user.username + '.json');

        SuperDevs.EditableText({
          htmlElement: fullnameHeader(),
          model: model,
          fieldName: 'full_name',
          addLinkText: 'Add your name'});

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

        SuperDevs.EditableArea({
          htmlElement: bioParagraph(),
          model: model,
          fieldName: 'bio',
          addLinkText: 'Add a short personal profile'});

        initInterestsEditing(model);

        initAccountsEditing();

        SuperDevs.BindableDropDown(countryDropDown(), model, 'country');
      }
    }
  }
}();

