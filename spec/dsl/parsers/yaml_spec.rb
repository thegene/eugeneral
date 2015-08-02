require_relative '../../../lib/eugeneral/dsl/parsers/yaml'
require 'heredoc_unindent'

describe Eugeneral::DSL::Parsers::YAML do
  context 'Given a YAML Parser' do
    subject(:parser) { described_class.new(vocabulary) }

    context 'with a vocabulary' do
      let(:vocabulary) { double(:vocabulary) }
      let(:foo_instance) { double(:foo_instance) }

      before do
        allow(vocabulary).to receive(:define).with('foo', 'something')
          .and_return(foo_instance)
      end

      context 'when parsing a simple YAML command list' do
        let(:yaml) {
          <<-YAML.unindent
            some_command:
              foo: 'something'
          YAML
        }

        it 'returns an object with some_command' do
          expect(parser.parse(yaml)).to respond_to(:some_command)
        end

        it 'instantiates foo with something' do
          expect(parser.parse(yaml).some_command).to be(foo_instance)
        end

      end
    end
  end
end
