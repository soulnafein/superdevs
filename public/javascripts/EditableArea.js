var SuperDevs = SuperDevs || {};

SuperDevs.EditableArea = function(params) {
  return  SuperDevs.EditableField(params, $("<textarea></textarea>"));
};
