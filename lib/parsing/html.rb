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

    def get
      doc = Nokogiri::HTML(URI(HTML_DATA).read)
      doc.css('li').each do |li|
        person = Person.new(
          first_name: Fix.name(li.css('.name')[0].text)[:first],
          last_name: Fix.name(li.css('.name')[0].text)[:last],
          note: li.css('.note')[0].text
        )
        @people.add(person)
      end
    end
  end
end
