require_relative 'spec_helper'

describe Eugeneral do
  context 'Given Eugeneral using defaults' do
    let(:command_list) { {}.to_yaml }

    context 'when calling for a general' do
      let(:general) { described_class.general(command_list).class }

      it 'returns a general' do
        expect(general).to be(Eugeneral::General)
      end
    end

    context 'when specifying the parser' do
      let(:parser) { double(:parser) }

      it 'uses the specified parser class' do
        expect(parser).to receive(:parse).with(command_list)
        described_class.general(command_list, parser: parser)
      end

    end
  end

end
