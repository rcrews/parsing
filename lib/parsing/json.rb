# frozen_string_literal: true

require 'json'
require 'open-uri'

module Parsing
  class Json
    attr_reader :people

    def initialize
      @people = People.new
    end

    def get
      JSON.parse(URI(JSON_DATA).read, symbolize_names: true).each do |i|
        person = Parsing::Person.new(
          first_name: Fix.name(i[:name])['first'],
          last_name: Fix.name(i[:name])['last'],
          title: i[:title]
        )
        @people.add(person)
      end
    end
  end
end
