# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Calculators::Dental do
  let(:age) { 23 }
  let(:public_health_insurance) { true }
  subject { described_class.new(age, public_health_insurance) }

  describe '#net_premium' do
    context 'when public_health_insurance is true' do
      it 'retruns the correct net_premium' do
        expect(subject.net_premium).to eq(BigDecimal('7.89234'))
      end
    end

    context 'when public_health_insurance is false' do
      let(:public_health_insurance) { false }

      it 'retruns the correct net_premium' do
        expect(subject.net_premium).to eq(BigDecimal('11.83851'))
      end
    end

    context 'when age is different' do
      let(:age) { 50 }

      it 'retruns the correct net_premium' do
        expect(subject.net_premium).to eq(BigDecimal('13.811595'))
      end
    end

    context 'when age is not valid' do
      let(:age) { '12' }

      it 'raises an error' do
        expect { subject.net_premium }.to raise_error(Exceptions::InsuranceNotPossible)
      end
    end
  end

  describe '#gross_premium' do
    it 'retruns the correct gross_premium' do
      expect(subject.gross_premium).to eq(BigDecimal('0.0'))
    end

    context 'when age is not valid' do
      let(:age) { '12' }

      it 'raises an error' do
        expect { subject.net_premium }.to raise_error(Exceptions::InsuranceNotPossible)
      end
    end
  end

  describe '#tax' do
    it 'retruns the correct tax' do
      expect(subject.tax).to eq(BigDecimal('0.0'))
    end
  end
end
