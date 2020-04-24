# frozen_string_literal: true

module CLI
  class PolicyPrinter
    def initialize(policy)
      @policy = policy
    end

    def print
      <<~STR
        Gross Premium: #{policy.gross_premium.to_s('F')}€
        Net Premium: #{policy.net_premium.to_s('F')}€
        Tax: #{policy.tax.to_s('F')}€
      STR
    end

    private

    attr_reader :policy
  end
end
