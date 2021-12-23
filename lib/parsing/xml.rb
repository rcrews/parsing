# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

module Parsing
  class Xml
    attr_reader :people

    def initialize
      @people = People.new
    end

    def get
      doc = Nokogiri::XML(URI(XML_DATA).read)
      doc.css('direct').each do |d|
        if Fix.name(d.text)['first']
        person = Parsing::Person.new(
          first_name: Fix.name(d.text)['first'],
          last_name: Fix.name(d.text)['last'],
          manager: d.xpath('parent::manager/@name').text
        )
        @people.add(person)
      end
    end
  end
end
