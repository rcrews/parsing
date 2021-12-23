# frozen_string_literal: true

require 'set'

module Parsing
  class People < Set
    def get(first_name, last_name)
      each do |i|
        return i if i.first_name == first_name && i.last_name == last_name
      end
      nil
    end

    def add(person)
      existing = get(person[:first_name], person[:last_name])
      if existing
        person.members.each { |m| existing[m] = person[m] if person[m] }
      else
        super(person)
      end
    end
  end
end
