# frozen_string_literal: true

require 'json' 
require 'open-uri'

module Parsing
  # Process JSON for job titles
  # @author  Robert Crews <rcrews@cloudera.com>
  # @since   0.1.0
  class Json
    attr_reader :people

    # Create local People struct
    def initialize
      @people = People.new
    end

    # Parse JSON and load local People struct with info
    def get
      JSON.parse(URI(JSON_DATA).read, symbolize_names: true).each do |i|
        person = Person.new(
          first_name: Fix.name(i[:name])[:first],
          last_name: Fix.name(i[:name])[:last],
          title: i[:title]
        )
        @people.add(person)
      end
    end
  end
end
