# frozen_string_literal: true

require 'csv'
require 'erb'
require 'getoptlong'
require 'json'
require 'psych'
require 'active_support/core_ext/hash/keys'
require 'fileutils'

module Parsing
  # Command-line interface
  # @author  Siddhant Kumar <siddhantkumar.xyz@gmail.com>
  # @since   0.1.0
  class Cli # rubocop:disable Metrics/ClassLength
    OPTIONS = [
      ['--help', '-h', GetoptLong::NO_ARGUMENT],
      ['--format', '-f', GetoptLong::REQUIRED_ARGUMENT],
      ['--output', '-o', GetoptLong::REQUIRED_ARGUMENT],
      ['--version', '-v', GetoptLong::NO_ARGUMENT]
    ].freeze

    def initialize
      @people = People.new
      @opts = GetoptLong.new(*OPTIONS)
      setup
      parse
      data_format(File.extname(@output).sub('.', '')) if @output
      run
    end

    # TODO: Check to see if str matches the allowed format
    # If so, set @format
    # Be sure to allow for different letter cases
    # Be sure to allow common different spellings:
    #   txt = text
    #   yml = yaml
    def data_format(str)
      @format = str.downcase
      case @format
      when 'text'
        @format = 'txt'
      when 'yml'
        @format = 'yaml'
      end
    end

    def format_as_csv
      CSV.generate do |csv|
        csv << %w[Name Country Title Specilities]
        @people.sort.each do |person|
          name = "#{person.first_name} #{person.last_name}"
          csv << [name, person.country, person.title, person.specialities]
        end
      end
    end

    def format_as_html
      ERB.new(File.read(HTML_TEMPLATE), trim_mode: '<>').result(binding)
    end

    def format_as_json
      json = []
      @people.sort.to_a.each do |person|
        json << Fix.full_name(person.to_h)
      end
      JSON.pretty_generate(json)
    end

    def format_as_text
      ERB.new(File.read(TEXT_TEMPLATE)).result(binding)
    end

    def format_as_yaml
      yaml = []
      @people.sort.to_a.each do |person|
        yaml << Fix.full_name(person.to_h).stringify_keys
      end
      Psych.dump(yaml)
    end

    # TODO: Check to see if the directory exists, create it if not
    # Set the @output file
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
        FileUtils.mkpath(File.dirname(@output)) unless File.directory?(File.dirname(@output))
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
