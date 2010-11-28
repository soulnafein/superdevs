var SuperDevs = SuperDevs || {};

SuperDevs.ProfilePage = function() {
  return {
    init: function() {
      $("h2").click(function() {
        $(this).after("<input type='text' value='"+$(this).text()+"' />");
      });
    }
  }
};