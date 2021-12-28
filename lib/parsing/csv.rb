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
      CSV.parse(URI(CSV_DATA).read, headers: true).each do |row|
        name = Fix.name(li.css('.name')[0].text)
        person = Person.new(
          first_name: name[:first],
          last_name: name[:last],
          specialities: row['Specialties']
        )
        @people.add(person)
      end
    end
  end
end
