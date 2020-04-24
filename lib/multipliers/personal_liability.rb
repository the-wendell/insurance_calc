# frozen_string_literal: true

require 'yaml'
require 'bigdecimal'

module Multipliers
  class PersonalLiability
    CONFIG = YAML.load(File.read('config/data.yaml'))[ENV['CALC_ENV']]['multipliers']
    DATA = YAML.load(File.read(CONFIG))
    ZIP_CODE = DATA['zip_code']
    PREVIOUS_INSURANCE = DATA['previous_insurance']
    TAX = DATA['tax']['personal_liability']

    class << self
      def zip_code_multiplier(zip_code)
        multiplier = ZIP_CODE['starts_with'][zip_code[0].to_i]
        return if multiplier.nil?

        BigDecimal(multiplier.to_s)
      end

      def previous_insurance_multiplier(previous_insurance)
        BigDecimal(PREVIOUS_INSURANCE[previous_insurance].to_s)
      end

      def tax_multiplier
        BigDecimal(TAX.to_s)
      end
    end
  end
end
