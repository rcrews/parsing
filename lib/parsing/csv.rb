# frozen_string_literal: true

require 'csv'

module Parsing
  # Process CSV for speciality info
  # @author  Siddhant Kumar <siddhantkumar.xyz@gmail.com>
  # @since   0.1.0
  class Csv
    attr_reader :people

    # Create local People struct
    def initialize
      @people = People.new
    end

    # Parse JSON and load local People struct with info
    def get
      # TODO: Parse CSV, create person, add to people
      # CSV loop {
      CSV.foreach(CSV_DATA) do |row|
        #   person = Person.new()
        person = Person.new(
          first_name: row[0],
          last_name: row[1],
          title: row[2],
          Specialities: row[3]
        )
        #   @people.add(person)
        @people.add(person)
      end
      # }
      
      
      
      
    end
  end
end
