# frozen_string_literal: true

# require_relative 'parsing/csv'
require_relative 'parsing/fix'
# require_relative 'parsing/html'
require_relative 'parsing/json'
require_relative 'parsing/people'
require_relative 'parsing/person'
require_relative 'parsing/version'
require_relative 'parsing/xml'
require_relative 'parsing/yaml'

# Primary namespace for the parsing application
module Parsing
  # URL of CSV data: Specialities
  CSV_DATA = 'https://raw.githubusercontent.com/SID262000/Test/main/data/cdev.csv'

  # URL of HTML data: none
  HTML_DATA = 'https://raw.githubusercontent.com/SID262000/Test/main/data/cdev.html'

  # URL of JSON data: Titles
  JSON_DATA = 'https://raw.githubusercontent.com/SID262000/Test/main/data/cdev.json'

  # URL of XML data: Managers
  XML_DATA = 'https://raw.githubusercontent.com/rcrews/parsing/main/data/cdev.xml'

  # URL of YAML data: Locations, especially coutries
  YAML_DATA = 'https://raw.githubusercontent.com/SID262000/Test/main/data/cdev.yml'

  people = People.new

  j = Json.new
  j.get
  j.people.each { |i| people.add(i) }

  y = Yaml.new
  y.get
  y.people.each { |i| people.add(i) }

  x = Xml.new
  x.get
  x.people.each { |i| people.add(i) }
  # x.people.each { |i| p i }

  people.sort.each { |i| p i }
end
