#!/usr/bin/env ruby

# frozen_string_literal: true

require 'bundler/setup'
require 'nokogiri'
require 'optparse'

def parse_coverage(xml_path, target_file = nil)
  doc = Nokogiri::XML(File.read(xml_path))
  workspace_path = doc.at_xpath('//sources/source')&.text || ''
  results = {}

  doc.xpath('//class').each do |klass|
    filename = klass.attr('filename')
    next unless filename # Skip if no filename
    next if target_file && target_file != '-all' && !filename.include?(target_file) # Filter by target file if specified

    # Get coverage percentages directly from XML attributes
    line_rate = klass.attr('line-rate').to_f
    branch_rate = klass.attr('branch-rate').to_f
    line_percentage = (line_rate * 100).round(2)
    branch_percentage = (branch_rate * 100).round(2)

    # Parse all lines for detailed analysis
    lines = klass.xpath('.//line')
    total_lines = lines.size
    covered_lines = lines.count { |line| line.attr('hits').to_i > 0 }

    # Parse branch coverage for detailed analysis
    branch_lines = lines.select { |line| line.attr('condition-coverage') }
    total_branches = 0
    covered_branches = 0

    branch_lines.each do |line|
      condition_coverage = line.attr('condition-coverage')
      if condition_coverage && condition_coverage.match(/(\d+)% \((\d+)\/(\d+)\)/)
        covered_branches += $2.to_i
        total_branches += $3.to_i
      end
    end

    # Get file content for line details
    file_content = File.read(File.join(workspace_path, filename)).split("\n") rescue []

    results[filename] = {
      line_percentage: line_percentage,
      branch_percentage: branch_percentage,
      total_lines: total_lines,
      covered_lines: covered_lines,
      missed_lines: total_lines - covered_lines,
      total_branches: total_branches,
      covered_branches: covered_branches,
      missed_branches: total_branches - covered_branches,
      lines: lines,
      file_content: file_content
    }
  end

  results
end

def show_help
  puts <<~HELP
    Coverage Parser - Analyze code coverage from XML reports

    Usage:
      #{$0} [coverage_file.xml] [options]

    Options:
      -f, --file FILE    Filter coverage for specific file (required)
      -h, --help         Show this help message

    Examples:
      # Show coverage for all files
      #{$0} --file -all

      # Show coverage for specific file
      #{$0} --file search_run.rb
      #{$0} --file "app/models/search_run.rb"

      # Use custom coverage file
      #{$0} coverage/other.xml --file search_run.rb

    Output includes:
      - Line coverage percentage and totals
      - Branch coverage percentage and totals
      - List of uncovered lines with code content
      - Branch coverage details for conditionals
  HELP
end

def print_results(results)
  return puts 'No coverage data found!' if results.empty?

  results.each do |filename, data|
    puts filename
    puts "#{data[:line_percentage]}% lines covered"
    puts "#{data[:branch_percentage]}% branches covered"
    puts "#{data[:total_lines]} relevant lines. #{data[:covered_lines]} lines covered and #{data[:missed_lines]} lines missed."
    puts "#{data[:total_branches]} total branches, #{data[:covered_branches]} branches covered and #{data[:missed_branches]} branches missed."
    puts

    # Show uncovered lines
    uncovered_lines = data[:lines].select { |line| line.attr('hits') == '0' }
    unless uncovered_lines.empty?
      puts "Uncovered lines:"
      uncovered_lines.each do |line|
        line_num = line.attr('number')
        content = data[:file_content][line_num.to_i - 1]&.strip || ""
        puts "line: #{line_num} --> #{content}"
      end
      puts
    end

    # Show branch lines
    branch_lines = data[:lines].select { |line| line.attr('condition-coverage') }
    unless branch_lines.empty?
      puts "Branch coverage:"
      branch_lines.each do |line|
        line_num = line.attr('number')
        coverage = line.attr('condition-coverage')
        puts "line: #{line_num} --> #{coverage}"
      end
      puts
    end

    puts "----"
    puts
  end
end

# Parse command line arguments
options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [coverage_file.xml] [--file target_file]"

  opts.on("-f", "--file FILE", "Filter coverage for specific file") do |file|
    options[:target_file] = file
  end

  opts.on("-h", "--help", "Show this help message") do
    show_help
    exit
  end
end.parse!

# Get coverage file from arguments or use default
coverage_file = ARGV[0] || 'coverage/coverage.xml'
target_file = options[:target_file]

# Show help if no arguments provided
if ARGV.empty? && !target_file
  show_help
  exit
end

unless File.exist?(coverage_file)
  puts "\e[31mError: Coverage file not found at #{coverage_file}\e[0m"
  exit 1
end

results = parse_coverage(coverage_file, target_file)
print_results(results)
