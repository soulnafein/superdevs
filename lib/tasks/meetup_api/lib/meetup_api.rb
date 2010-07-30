require 'net/http'
require 'rexml/document'

class MeetupApi
  API_KEY = "8043755844411bd5a772c72373c3357"
  def self.retrieve_groups_id(groups_name)

    groups_name.map do |group_name|
      url = "http://api.meetup.com/groups.xml/?group_urlname=#{group_name}&key=#{API_KEY}"
      xml_data = Net::HTTP.get_response(URI.parse(url)).body
      document = REXML::Document.new(xml_data)
      id = 0
      document.elements.each('//item/id') do |element|
        id = element.text
      end
      id
    end
  end
end