# frozen_string_literal: true

require 'open-uri'
require 'psych'

module Parsing
  # Process YAML for location data, especially countries
  # @author  Robert Crews <rcrews@cloudera.com>
  # @since   0.1.0
  class Yaml
    attr_reader :people

    # Create local People struct
    def initialize
      @people = People.new
    end

    # Parse YAML and load local People struct with info
    def get
      Psych.safe_load(URI(YAML_DATA).read, symbolize_names: true).each do |i|
        person = Person.new(
          first_name: Fix.name(i[:name])[:first],
          last_name: Fix.name(i[:name])[:last],
          country: Fix.location(i[:location])
        )
        @people.add(person)
      end
    end
  end
end
