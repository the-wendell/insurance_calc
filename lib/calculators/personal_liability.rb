# frozen_string_literal: true

module Calculators
  class PersonalLiability
    def initialize(zip_code, previous_insurance)
      @zip_code = zip_code
      @previous_insurance = previous_insurance
    end

    def net_premium
      @net_premium ||= price * zip_code_multiplier * previous_insurance_multiplier
    end

    def gross_premium
      net_premium * tax_multiplier
    end

    def tax
      tax_multiplier
    end

    private

    attr_reader :zip_code, :previous_insurance

    def tax_multiplier
      @tax_multiplier ||= Multipliers::PersonalLiability.tax_multiplier
    end

    def price
      Prices.personal_liability
    end

    def zip_code_multiplier
      multiplier = Multipliers::PersonalLiability.zip_code_multiplier(zip_code)
      return multiplier unless multiplier.nil?

      raise Exceptions::InsuranceNotPossible, "#{zip_code} is not a valid zip code"
    end

    def previous_insurance_multiplier
      Multipliers::PersonalLiability.previous_insurance_multiplier(previous_insurance)
    end
  end
end
