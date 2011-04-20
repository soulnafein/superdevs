(function($) {

  $.fn.tabs = function() {

    var tabsList = $(this);
    var tabs = tabsList.find('li');
    var tabLinks = tabs.find('a');

    tabLinks.click(function() {
      var link = $(this);
      var currentTab = link.closest('li');
      removeAllSelectedClassFromTabs();
      hideAllTabsContent();
      showContentForTab(currentTab, link);
      return false;
    });

    function removeAllSelectedClassFromTabs() {
      tabs.removeClass('selected');
    }

    function hideAllTabsContent() {
      tabLinks.each(function() {
        content = $($(this).attr('rel'));
        content.hide();
      });
    }

    function showContentForTab(tab, link) {
      tab.addClass('selected');
      var content = $(link.attr('rel'));
      content.show();
    }

  };

})(jQuery);