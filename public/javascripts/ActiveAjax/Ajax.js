var ActiveAjax = ActiveAjax || {};

ActiveAjax.Ajax = function() {
  var AUTH_TOKEN = AUTH_TOKEN || {};

  return {
    put: function(url, paramsToSend) {
      paramsToSend['authenticity_token'] = encodeURIComponent( AUTH_TOKEN );
      paramsToSend['_method'] = 'put';
      jQuery.ajax({url:url, data:params, type:'post'});
    }
  }
}();