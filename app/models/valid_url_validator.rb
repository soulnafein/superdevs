require 'uri'
class ValidUrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.to_s.empty?
    uri = URI.parse(value)
    raise Exception("No http, https, or other schema") unless uri.scheme
  rescue
    record.errors[attribute] << "is not a valid URL. Remember to add http:// or other schema in front"
  end
end
