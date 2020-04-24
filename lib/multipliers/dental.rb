# frozen_string_literal: true

require 'yaml'
require 'bigdecimal'

module Multipliers
  class Dental
    CONFIG = YAML.load(File.read('config/data.yaml'))[ENV['CALC_ENV']]['multipliers']
    DATA = YAML.load(File.read(CONFIG))
    AGE = DATA['age']
    PUBLIC_HEALTH_INSURANCE = DATA['public_health_insurance']
    TAX = DATA['tax']['dental']

    class << self
      def age_multiplier(age)
        multiplier = AGE.find { |multi| multi['range'].include?(age) }
        return if multiplier.nil?

        BigDecimal(multiplier['value'].to_s)
      end

      def public_health_insurance_multiplier(public_health_insurance)
        BigDecimal(PUBLIC_HEALTH_INSURANCE[public_health_insurance].to_s)
      end

      def tax_multiplier
        BigDecimal(TAX.to_s)
      end
    end
  end
end
