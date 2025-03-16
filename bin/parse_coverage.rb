#!/usr/bin/env ruby

# frozen_string_literal: true

require 'nokogiri'
require 'terminal-table'

def parse_coverage(xml_path) # rubocop:disable Metrics/AbcSize
  doc = Nokogiri::XML(File.read(xml_path))
  workspace_path = doc.at_xpath('//source').text
  results = {}

  doc.xpath('//class').each do |klass|
    filename = klass.attr('filename')
    next unless filename # Skip if no filename

    uncovered_lines = klass.xpath('.//line').select { |line| line.attr('hits') == '0' }
    next if uncovered_lines.empty? # Skip if all lines are covered

    file_content = File.read(File.join(workspace_path, filename)).split("\n")
    results[filename] = uncovered_lines.map do |line|
      line_number = line.attr('number').to_i
      {
        line_number: line_number,
        content: file_content[line_number - 1]&.strip
      }
    end
  end

  results
end

def print_results(results)
  return puts 'All lines are covered!' if results.empty?

  results.each do |filename, uncovered_lines|
    puts "\n\e[33mUncovered lines in #{filename}:\e[0m"

    rows = uncovered_lines.map do |line|
      [line[:line_number], line[:content]]
    end

    table = Terminal::Table.new(
      headings: %w[Line Content],
      rows: rows,
      style: { border_x: '-', border_i: '+', alignment: :left }
    )
    puts table
  end
end

coverage_file = ARGV[0] || 'coverage/coverage.xml'
unless File.exist?(coverage_file)
  puts "\e[31mError: Coverage file not found at #{coverage_file}\e[0m"
  exit 1
end

results = parse_coverage(coverage_file)
print_results(results)
