var SuperDevs = SuperDevs || {};

SuperDevs.EditableText = function(params) {
  return  SuperDevs.EditableField(params, $("<input type='text' value='' />"))
};
