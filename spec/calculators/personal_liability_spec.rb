# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Calculators::PersonalLiability do
  let(:zip_code) { '12345' }
  let(:previous_insurance) { true }
  subject { described_class.new(zip_code, previous_insurance) }

  describe '#net_premium' do
    context 'when previous_insurance is true' do
      it 'retruns the correct net_premium' do
        expect(subject.net_premium).to eq(BigDecimal('2.125'))
      end
    end

    context 'when previous_insurance is false' do
      let(:previous_insurance) { false }

      it 'retruns the correct net_premium' do
        expect(subject.net_premium).to eq(BigDecimal('3.1875'))
      end
    end

    context 'when a different zip code is used' do
      let(:zip_code) { '89142' }

      it 'retruns the correct net_premium' do
        expect(subject.net_premium).to eq(BigDecimal('2.8225'))
      end
    end

    context 'when zip_code is not valid' do
      let(:zip_code) { '0123' }

      it 'raises an error' do
        expect { subject.net_premium }.to raise_error(Exceptions::InsuranceNotPossible)
      end
    end
  end

  describe '#gross_premium' do
    it 'retruns the correct gross_premium' do
      expect(subject.gross_premium).to eq(BigDecimal('0.40375'))
    end

    context 'when zip_code is not valid' do
      let(:zip_code) { '0123' }

      it 'raises an error' do
        expect { subject.net_premium }.to raise_error(Exceptions::InsuranceNotPossible)
      end
    end
  end

  describe '#tax' do
    it 'retruns the correct tax' do
      expect(subject.tax).to eq(BigDecimal('0.19'))
    end
  end
end
