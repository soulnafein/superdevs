var ActiveAjax = ActiveAjax || {};

ActiveAjax.Ajax = function() {
  var AUTH_TOKEN = AUTH_TOKEN || {};
  return {
    put: function(url, params) {
      params['authenticity_token'] = encodeURIComponent( AUTH_TOKEN );
      params['_method'] = 'put';
      jQuery.ajax({url:url, data:params, type:'post'});
    }
  }
}();