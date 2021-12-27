# frozen_string_literal: true

require 'nokogiri'

module Parsing
  # Process HTML for something
  # @author  Siddhant Kumar <siddhantkumar.xyz@gmail.com>
  # @since   0.1.0
  class Html
    attr_reader :people

    # Create local People struct
    def initialize
      @people = People.new
    end

    def get
      Nokogiri::HTML(URI(HTML_DATA).read).css('tr').each do |row|
        person = Person.new(
          first_name: row.css('td')[0].text,
          last_name: row.css('td')[1].text
        )
        @people.add(person)
      end
    end
  end
end
