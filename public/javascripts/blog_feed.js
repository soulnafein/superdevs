(function($) {
  $.fn.blog_feed = function(feed_url) {
    var list = "";

    $(this).each(function() {
      list = $(this).find("dl:first");
      load_feed();
    });

    function load_feed() {
      $.jGFeed(feed_url, display_feed, 10)
    }

    function display_feed(feed) {
      if (!feed) {
        alert("Error!");
        return false;
      }

      
      var entries = feed.entries.sort(sort_by_date);
      var odd = false;
      for(var i = 0; i < entries.length; i++) {
        var entry = entries[i];
        list.append(get_date_tag(new Date(entry.publishedDate)));
        var alternate_class = odd ? ' class="odd"' : '';
        var title = '<a href="'+entry.link+'"><h5>' + entry.title + '</h5></a>';
        var snippet = '<p>'+entry.contentSnippet+'</p>';
        list.append('<dd><ul><li'+alternate_class+'>'+title+snippet+'</li></ul></dd>');
        odd = !odd;
      }
      return true;
    }

  var months_names = { 1:"Jan",2:"Feb",3:"Mar",4:"Apr",5:"May",6:"Jun",
      7:"Jul",8:"Aug",9:"Sep",10:"Oct",11:"Nov",12:"Dec"};

    function sort_by_date(a,b) {
      var decomposed_a = get_year_month_day(new Date(a.publishedDate));
      var decomposed_b = get_year_month_day(new Date(b.publishedDate));
      var x = decomposed_a[0].toString() + decomposed_a[1].toString() + decomposed_a[2].toString();
      var y = decomposed_b[0].toString() + decomposed_b[1].toString() + decomposed_b[2].toString();
      return ((x<y) ? 1 : ((x>1) ? -1 : 0));
    }


    function get_date_tag(date) {
      var decomposed_date = get_year_month_day(date);
      var dayOfMonth = decomposed_date[2];
      var month = months_names[decomposed_date[1]+1];
      var year = decomposed_date[0];
      return "<dt>"+dayOfMonth+"<br /> <strong>"+month+"</strong> "+year+"</dt>"
    }

    function get_year_month_day(date) {
      var dayOfMonth = date.getDate();
      var month = date.getMonth();
      var year = date.getFullYear();
      return [year, month, dayOfMonth];
    }
  }
})(jQuery);