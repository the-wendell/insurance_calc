# frozen_string_literal: true

module Calculators
  class Dental
    def initialize(age, public_health_insurance)
      @age = age
      @public_health_insurance = public_health_insurance
    end

    def net_premium
      @net_premium ||= price * age_multiplier * public_health_insurance_multiplier
    end

    def gross_premium
      net_premium * tax_multiplier
    end

    def tax
      tax_multiplier
    end

    private

    attr_reader :age, :public_health_insurance

    def tax_multiplier
      @tax_multiplier ||= Multipliers::Dental.tax_multiplier
    end

    def price
      Prices.dental
    end

    def age_multiplier
      multiplier = Multipliers::Dental.age_multiplier(age)
      return multiplier unless multiplier.nil?

      raise Exceptions::InsuranceNotPossible, "Insurance is not possible for persones aged #{age}"
    end

    def public_health_insurance_multiplier
      Multipliers::Dental.public_health_insurance_multiplier(public_health_insurance)
    end
  end
end
