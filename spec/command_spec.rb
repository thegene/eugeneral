require_relative '../lib/eugeneral'

describe Eugeneral::Command do
  context 'Given a Command' do
    let(:args) {{ a: 'b' }}

    context 'when instantiated with a sub command' do
      let(:command) { described_class.new(sub_command) }
      let(:sub_command) { double(:sub_command) }

      before do
        allow(sub_command).to receive(:resolve)
      end

      it 'Calls resolve on sub_command' do
        expect(sub_command).to receive(:resolve).once.with(args)
        command.resolve(args)
      end

      context 'which returns something' do
        before do
          expect(sub_command).to receive(:resolve)
            .with(args).and_return('something')
        end

        it 'returns something' do
          expect(command.resolve(args)).to eq('something')
        end

      end
    end

    context 'when instantiated with a non-command' do
      let(:command) { described_class.new(thing) }
      let(:thing) { 'a thing' }

      context 'when resolved with args' do
        it 'resolves to thing' do
          expect(command.resolve(args)).to be(thing)
        end
      end

      context 'when resolved without args' do
        it 'resolves to the thing' do
          expect(command.resolve).to be(thing)
        end
      end
    end

  end
end