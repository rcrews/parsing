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
      #   person = Person.new()
      #   @people.add(person)
      # }
    end
  end
end
