require_relative '../lib/eugeneral'

describe Eugeneral::Command do
  context 'Given a Command' do
    let(:command) { described_class.new(sub_command) }
    let(:args) {{ a: 'b' }}

    context 'with a sub command' do
      let(:sub_command) { double(:sub_command) }

      before do
        allow(sub_command).to receive(:resolve)
      end

      it 'Calls resolve on sub_command' do
        expect(sub_command).to receive(:resolve).once.with(args)
        command.resolve(args)
      end
    end

    context 'with a sub command which returns something' do
      let(:sub_command) { double(:sub_command) }
      before do
        expect(sub_command).to receive(:resolve).with(args).and_return('something')
      end

      it 'Returns something' do
        expect(command.resolve(args)).to eq('something')
      end
    end
  end
end