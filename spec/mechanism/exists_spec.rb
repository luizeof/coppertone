require 'spec_helper'

describe Coppertone::Mechanism::Exists do
  context '#new' do
    it 'should fail if called with a nil argument' do
      expect do
        Coppertone::Mechanism::Exists.new(nil)
      end.to raise_error(Coppertone::InvalidMechanismError)
    end

    it 'should fail if called with a blank argument' do
      expect do
        Coppertone::Mechanism::Exists.new('')
      end.to raise_error(Coppertone::InvalidMechanismError)
    end

    it 'should fail if called with an invalid macrostring' do
      expect do
        Coppertone::Mechanism::Exists.new(':abc%:def')
      end.to raise_error(Coppertone::InvalidMechanismError)
    end
  end

  context '#create' do
    it 'should fail if called with a nil argument' do
      expect do
        Coppertone::Mechanism::Exists.create(nil)
      end.to raise_error(Coppertone::InvalidMechanismError)
    end

    it 'should fail if called with a blank argument' do
      expect do
        Coppertone::Mechanism::Exists.create('')
      end.to raise_error(Coppertone::InvalidMechanismError)
    end

    it 'should fail if called with an invalid macrostring' do
      expect do
        Coppertone::Mechanism::Exists.create(':abc%:def')
      end.to raise_error(Coppertone::InvalidMechanismError)
    end
  end

  context '#match?' do
    context 'simple' do
      let(:mech_domain) { 'iexist.com' }
      let(:mech_arg) { ":#{mech_domain}" }
      let(:bad_domain) { 'idontexist.com' }
      let(:bad_arg) { ":#{bad_domain}" }
      let(:dns_client) do
        dc = double(:dns_client)
        allow(dc).to receive(:fetch_a_records)
          .with(mech_domain).and_return([
            {
              type: 'A',
              address: '74.125.234.117'
            }
          ])
        allow(dc).to receive(:fetch_a_records)
          .with(bad_domain).and_return([])
        dc
      end

      let(:domain) { 'yahoo.com' }
      let(:matching_context) do
        Coppertone::MacroContext.new(domain, '74.125.239.118', 'bob@gmail.com')
      end

      let(:not_matching_context) do
        Coppertone::MacroContext.new(domain, '74.125.249.118', 'bob@gmail.com')
      end

      before do
        allow(Coppertone::DNS::ResolvClient)
          .to receive(:new).and_return(dns_client)
      end

      it 'should match when the domain record for the target name exists' do
        mech = Coppertone::Mechanism::Exists.create(mech_arg)
        expect(mech.match?(matching_context, Coppertone::RequestContext.new))
          .to eq(true)
      end

      it 'should match when the domain record for the target name exists' do
        mech = Coppertone::Mechanism::Exists.create(bad_arg)
        expect(mech.match?(matching_context, Coppertone::RequestContext.new))
          .to eq(false)
      end
    end
  end
end
