# frozen_string_literal: true

require 'csv'
require 'erb'
require 'getoptlong'
require 'json'
require 'psych'
require 'active_support/core_ext/hash/keys'

module Parsing
  # Command-line interface
  # @author  Siddhant Kumar <siddhantkumar.xyz@gmail.com>
  # @since   0.1.0
  class Cli
    OPTIONS = [
      ['--help', '-h', GetoptLong::NO_ARGUMENT],
      ['--format', '-f', GetoptLong::REQUIRED_ARGUMENT],
      ['--output', '-o', GetoptLong::REQUIRED_ARGUMENT],
      ['--version', '-v', GetoptLong::NO_ARGUMENT]
    ].freeze

    def initialize
      @people = People.new
      @opts = GetoptLong.new(
        ['--help', '-h', GetoptLong::NO_ARGUMENT],
        ['--format', '-f', GetoptLong::REQUIRED_ARGUMENT],
        ['--output', '-o', GetoptLong::REQUIRED_ARGUMENT],
        ['--version', '-v', GetoptLong::NO_ARGUMENT]
      )
      # p @opts
      setup
      parse
      data_format(File.extname(@output).sub('.', '')) if @output
      run
    end

    # TODO:
    # Check to see if str matches the allowed format
    # If so, set @format
    # Be sure to allow for different letter cases
    # Be sure to allpw common different spellings:
    #   txt = text
    #   yml = yaml
    def data_format(str)
      @format = str
    end

    def format_as_csv
      CSV.generate do |csv|
        @people.each do |person|
          csv << [person.first_name, person.last_name, person.title, person.specialities]
        end
      end
    end

    def format_as_html
      ERB.new(File.read(HTML_TEMPLATE)).result(binding)
    end

    def format_as_json
      json = []
      @people.to_a.each do |person|
        json << person.to_h
      end
      JSON.pretty_generate(json)
    end

    def format_as_text
      ERB.new(File.read(TEXT_TEMPLATE)).result(binding)
    end

    def format_as_yaml
      yaml = []
      @people.to_a.each do |person|
        yaml << person.to_h.stringify_keys
      end
      Psych.dump(yaml)
    end

    # TODO:
    # Set the @output file
    # Check to see if the directory exists, create it if not
    # This might not be needed
    def output(str)
      @output = str
    end

    def parse
      parse_csv
      parse_html
      parse_json
      parse_xml
      parse_yaml
    end

    def parse_csv
      c = Csv.new
      c.get
      c.people.each { |i| @people.add(i) }
    end

    def parse_html
      h = Html.new
      h.get
      h.people.each { |i| @people.add(i) }
    end

    def parse_json
      j = Json.new
      j.get
      j.people.each { |i| @people.add(i) }
    end

    def parse_xml
      x = Xml.new
      x.get
      x.people.each { |i| @people.add(i) }
    end

    def parse_yaml
      y = Yaml.new
      y.get
      y.people.each { |i| @people.add(i) }
    end

    def run
      case @format
      when 'csv' then write_out(format_as_csv)
      when 'html' then write_out(format_as_html)
      when 'json' then write_out(format_as_json)
      when 'text' then write_out(format_as_text)
      when 'yaml' then write_out(format_as_yaml)
      else raise 'invalid output format specified'
      end
    end

    def setup
      @opts.each do |opt, arg|
        case opt
        when '--help' then help
        when '--format' then data_format(arg)
        when '--output' then output(arg)
        when '--version' then version
        end
      end
    end

    def help
      puts ERB.new(File.read(HELP_TEMPLATE)).result(binding)
      exit 0
    end

    def write_out(fdata)
      if @output
        File.write(@output, fdata)
      else
        puts fdata
      end
    end

    def version
      puts ERB.new(File.read(VERSION_TEMPLATE)).result(binding)
      exit 0
    end
  end
end
