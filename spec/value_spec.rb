require_relative '../lib/eugeneral/value'

describe Eugeneral::Value do
  context 'given a class including value' do
    let(:subject) { Class.new { extend Eugeneral::Value }}
    let(:args) { [:b, 'a'] }

    context 'when called with a command' do
      let(:command) { double(:command) }
      before do
        allow(command).to receive(:resolve).and_return(:foo)
      end

      context 'with args' do
        it 'calls resolve on the command with args' do
          expect(command).to receive(:resolve).with(args)
          subject.value_for(command, args)
        end

        it 'returns foo' do
          expect(subject.value_for(command, args)).to be(:foo)
        end
      end

      context 'without args' do
        it 'calls resolve on the command without args' do
          expect(command).to receive(:resolve).with(no_args)
          subject.value_for(command)
        end
      end
    end

    context 'when called with a simple value' do
      let(:command) { :bar }
      context 'with args' do
        it 'returns bar' do
          expect(subject.value_for(command, args)).to be(:bar)
        end
      end

      context 'without args' do
        it 'returns bar' do
          expect(subject.value_for(command)).to be(:bar)
        end
      end
    end
  end
end