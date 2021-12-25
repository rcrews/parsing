# frozen_string_literal: true

require 'set'

module Parsing
  # Structure for collecting person data
  # @author  Robert Crews <rcrews@cloudera.com>
  # @since   0.1.0
  class People < Set
    def get(first_name, last_name)
      each do |i|
        return i if i.first_name == first_name && i.last_name == last_name
      end
      nil # return nil if no match is found
    end

    def add(person) # function definition
      existing = get(person[:first_name], person[:last_name]) # get existing person
      if existing # if existing
        person.members.each { |m| existing[m] = person[m] if person[m] } # update existing
      else # if not existing
        super(person) # add new person
      end 
    end # end of add function
  end # end of class People
end # end of module Parsing
