# frozen_string_literal: true

module Parsing
  # Utility class for cleaning data
  # @author  Robert Crews <rcrews@cloudera.com>
  # @since   0.1.0
  class Fix
    # Names that should be different
    BETTER_NAME = {
      'Gombos Tamas' => 'Tamas Gombos',
      'Kadar Liliana' => 'Liliana Kadar',
      'Kertesz Miklos' => 'Miklos Kertesz',
      'Lillin Matyas' => 'Matyas Lillin',
      'Marsal Dóra' => 'Dóra Marsal',
      'Tóth-Major Dóra' => 'Dóra Tóth-Major',
      'Feher Ildiko' => 'Ildiko Feher'
    }.freeze

    # Normalize names
    # @param name [String] Name from data source
    # @return [Hash] String values for 'first', 'last' names
    def self.name(name)
      name = name.delete_suffix(' [C]') # Remove contractor notation
      name = name.gsub(/[[:space:]+]/, ' ').strip # normalize spaces
      name = better_name(name)
      md = /\A(?<first>\S+)\s+(?<last>.*)\z/.match(name)
      { first: md[:first], last: md[:last] }
    end

    # Parse country from the location value
    # @param location [String] Location from the data source
    # @return [String] The country value
    def self.location(location)
      md = /\A(?<country>[^-]+)-.*\z/.match(location)
      md[:country]
    end

    # Fix known name errors
    # @param name [String] Partially processed name data
    # @return [String] Better name, might be the same name
    def self.better_name(name)
      BETTER_NAME.each { |k, v| name = v if name == k }
      name
    end

    # Creates name key from the first and last name
    # @param hash [Hash] Hash from person object
    # @return [Hash] Hash with first and last name removed
    def self.full_name(hash)
      hash[:name] = "#{hash[:first_name]} #{hash[:last_name]}"
      hash.delete(:first_name)
      hash.delete(:last_name)
      hash
    end
  end
end
