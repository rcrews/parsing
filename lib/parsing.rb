# frozen_string_literal: true

require 'erb'
require_relative 'parsing/cli'
require_relative 'parsing/csv'
require_relative 'parsing/fix'
require_relative 'parsing/html'
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
  XML_DATA = 'https://raw.githubusercontent.com/SID262000/Test/main/data/cdev.xml'

  # URL of YAML data: Locations, especially coutries
  YAML_DATA = 'https://raw.githubusercontent.com/SID262000/Test/main/data/cdev.yml'

  # ERB template for HTML
  HTML_TEMPLATE = File.expand_path('../views/html.erb', __dir__)

  # ERB template for text
  TEXT_TEMPLATE = File.expand_path('../views/text.erb', __dir__)

  # ERB template for VERSION
  VERSION_TEMPLATE = File.expand_path('../views/version.erb', __dir__)

  # ERB template for HELP
  HELP_TEMPLATE = File.expand_path('../views/help.erb', __dir__)

  Cli.new
end
