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

    # Parse HTML and load local People struct with info
    def get
      # TODO: Parse HTML, create person, add to people
      # HTML loop {
      Nokogiri::HTML(open(HTML_DATA)).css('tr').each do |row|
        
      #   person = Person.new()
        person = Person.new( 
          first_name: row.css('td')[0].text,
          last_name: row.css('td')[1].text,
          title: row.css('td')[2].text,
          Specialities: row.css('td')[3].text
        )
      #   @people.add(person)
        @people.add(person)
      end
      # }
    end
  end
end
