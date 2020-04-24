# frozen_string_literal: true

module CLI
  class OptionBuilder
    DENTAL_OPTIONS = [
      { name: 'age', opt_short: '-a ', opt_long: '-age ', description: 'age in years' },
      { name: 'public_health_insurance', opt_short: '-p ',
        opt_long: '-public_health_insurance ', description: 'boolean' }
    ].freeze
    PERSONAL_LIABILITY_OPTIONS = [
      { name: 'zip_code', opt_short: '-z ', opt_long: '-zip_code ', description: 'residential zipcode' },
      { name: 'previous_insurance', opt_short: '-p ', opt_long: '-previous_insurance ', description: 'boolean' }
    ].freeze

    class << self
      def dental_options
        opts = build_options(DENTAL_OPTIONS)
        require_options(opts)
        opts
      end

      def personal_liability_options
        opts = build_options(PERSONAL_LIABILITY_OPTIONS)
        require_options(opts)
        opts
      end

      private

      def initialize_options(options)
        options.each_with_object({}) { |option, hash| hash[option[:name].to_sym] = nil }
      end

      def build_options(options)
        values = initialize_options(options)

        OptionParser.new do |opts|
          options.each do |option|
            opts.on(option[:opt_short], option[:opt_long], option[:description]) do |v|
              values[option[:name].to_sym] = v
            end
          end
          help(opts)
        end.parse!
        values
      end

      def help(opts)
        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end

      def require_options(options)
        return unless options.any? { |_, v| v.nil? }

        puts 'missing options. "{insurance_type} -h" to see required options'
        exit
      end
    end
  end
end
