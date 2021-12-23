# frozen_string_literal: true

module Parsing
  Person = Struct.new(:first_name, :last_name, :country, :title,
                      :manager, keyword_init: true) do
  end
end
