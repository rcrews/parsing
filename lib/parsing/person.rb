# frozen_string_literal: true

module Parsing
  # Primary data structure
  # Implements Comparable to sort on last_name
  # @author  Robert Crews <rcrews@cloudera.com>
  # @since   0.1.0
  Person = Struct.new(:first_name, :last_name, :country, :title,
                      :manager, keyword_init: true) do
    include Comparable

    def <=>(other)
      self[:last_name] <=> other[:last_name]
    end
  end
end
