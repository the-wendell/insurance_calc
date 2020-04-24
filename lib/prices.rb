# frozen_string_literal: true

require 'yaml'
require 'bigdecimal'

class Prices
  class << self
    CONFIG = YAML.load(File.read('config/data.yaml'))[ENV['CALC_ENV']]['prices']
    DATA = YAML.load(File.read(CONFIG))

    def personal_liability
      BigDecimal(DATA['personal_liability'].to_s)
    end

    def dental
      BigDecimal(DATA['dental'].to_s)
    end
  end
end
