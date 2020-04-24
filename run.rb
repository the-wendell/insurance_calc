# frozen_string_literal: true

ENV['CALC_ENV'] = 'production'

require 'optparse'
require 'rubygems'
require 'bundler/setup'
require 'require_all'
require_all 'lib'

PERSONAL_LIABILITY = 'personal_liability'
DENTAL = 'dental'
VALID_INSURANCE_TYPES = [DENTAL, PERSONAL_LIABILITY].freeze

def personal_liability
  opts = CLI::OptionBuilder.personal_liability_options
  policy = Calculators::PersonalLiability.new(opts[:zip_code], opts[:previous_insurance] == 'true')

  puts CLI::PolicyPrinter.new(policy).print
  exit
end

def dental
  opts = CLI::OptionBuilder.dental_options
  policy = Calculators::Dental.new(opts[:age].to_i, opts[:public_health_insurance] == 'true')

  puts CLI::PolicyPrinter.new(policy).print
  exit
end

def get_quote(type)
  return unless VALID_INSURANCE_TYPES.include?(type)

  send(type)
end

OptionParser.new do |opts|
  opts.on('-z zip_code', 'test') do |v|
    puts v
  end

  begin
    get_quote(ARGV[0])
  rescue Exceptions::InsuranceNotPossible => e
    puts e.message
    exit
  end

  opts.on('-h', '--help', 'Prints this help') do
    puts <<~STR
      Valid insurance options are: #{VALID_INSURANCE_TYPES.join(', ')}
      To see required value inputs for a given type pass -h after the type name.
      ex: dental -h
    STR
    exit
  end

  puts 'non-supported insurance type'
end.parse!
