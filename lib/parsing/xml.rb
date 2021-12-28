# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

module Parsing
  # Process XML for manager data
  # @author  Robert Crews <rcrews@cloudera.com>
  # @since   0.1.0
  class Xml
    attr_reader :people

    # Create local People struct
    def initialize
      @people = People.new
    end

    # Parse XML and load local People struct with info
    def get
      Nokogiri::XML(URI(XML_DATA).read).css('direct').each do |d|
        name = Fix.name(li.css('.name')[0].text)
        person = Person.new(
          first_name: name[:first],
          last_name: name[:last],
          manager: d.xpath('parent::manager/@name').text
        )
        @people.add(person)
      end
    end
  end
end
