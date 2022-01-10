# frozen_string_literal: true

RSpec.describe Parsing do # rubocop:disable Metrics/BlockLength
  it 'has a version number' do
    expect(Parsing::VERSION).not_to be nil
  end

  it 'has access to CSV data' do
    expect(URI Parsing::CSV_DATA).not_to be nil
  end

  it 'has access to HTML data' do
    expect(URI Parsing::HTML_DATA).not_to be nil
  end

  it 'has access to JSON data' do
    expect(URI Parsing::JSON_DATA).not_to be nil
  end

  it 'has access to XML data' do
    expect(URI Parsing::XML_DATA).not_to be nil
  end

  it 'has access to YAML data' do
    expect(URI Parsing::YAML_DATA).not_to be nil
  end

  it 'has an ERB template for HTML output' do
    expect(File.exist? Parsing::HTML_TEMPLATE).to be true
  end

  it 'has an ERB template for text output' do
    expect(File.exist? Parsing::TEXT_TEMPLATE).to be true
  end

  it 'has an ERB template for displaying the version from the CLI' do
    expect(File.exist? Parsing::VERSION_TEMPLATE).to be true
  end

  it 'has an ERB template for displaying usage from the CLI' do
    expect(File.exist? Parsing::HELP_TEMPLATE).to be true
  end
end
