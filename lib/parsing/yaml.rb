# frozen_string_literal: true

require 'open-uri'
require 'psych'

module Parsing
  class Yaml
    attr_reader :people

    def initialize
      @people = People.new
    end

    def get
      Psych.safe_load(URI(YAML_DATA).read, symbolize_names: true).each do |i|
        person = Parsing::Person.new(
          first_name: Fix.name(i[:name])['first'],
          last_name: Fix.name(i[:name])['last'],
          country: Fix.location(i[:location])['country']
        )
        @people.add(person)
      end
    end
  end
end
