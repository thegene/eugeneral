require_relative '../../../lib/eugeneral/dsl/parsers/yaml'
require_relative '../../../lib/eugeneral/dsl/vocabulary'
require 'heredoc_unindent'

describe Eugeneral::DSL::Parsers::YAML do
  context 'Given a YAML Parser' do
    subject(:parser) { described_class.new(vocabulary) }

    context 'with a vocabulary' do
      let(:vocabulary) { Eugeneral::DSL::Vocabulary.new(mapping) }

      let(:mapping) {{
        foo: FooClass
      }}

      let(:foo_instance) { double(:foo_instance) }
      let(:foo_class) { double(:foo_class) }

      before do
        allow(foo_class).to receive(:new).and_return(foo_instance)
        stub_const('FooClass', foo_class)
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

        context 'when it uses the vocabulary interface' do

          it 'instantiates foo with something' do
            expect(vocabulary).to receive(:define).with('foo', 'something')
            expect(vocabulary).to receive(:define).with('something')
            parser.parse(yaml)
          end

          context 'when calling the subsequent command' do

            it 'will call foo with something when called with something' do
              expect(foo_instance).to receive(:resolve).once.with('something')
              parser.parse(yaml).some_command.call('something')
            end

            it 'will call foo when called without arguments' do
              expect(foo_instance).to receive(:resolve).once.with(no_args)
              parser.parse(yaml).some_command.call()
            end
          end

        end

      end

      context 'when parsing a more complex command list' do
        let(:yaml) {
          <<-YAML.unindent
            complex_command:
              sooper_foo:
                - [1, 2, 3]
                - bar:
                  - 'takes'
                  - 'three'
                  - 'strings'
                - some_number: 17
                - other_foo:
                    purple: true
                    seven: 8
                    eight:
                      bar: 'thing'
            simpler_command:
              fruit:
                - apple
                - pear
                - plum
          YAML
        }

        it 'returns an object with complex_command' do
          expect(parser.parse(yaml)).to respond_to(:complex_command)
        end

        it 'returns an object with simpler_command' do
          expect(parser.parse(yaml)).to respond_to(:simpler_command)
        end

        context 'when it uses the vocabulary interface' do
          let(:sooper_foo) { double(:sooper_foo) }
          let(:sooper_foo_class) { double(:sooper_foo_class) }
          let(:other_foo) { double(:other_foo) }
          let(:other_foo_class) { double(:other_foo_class) }
          let(:bar) { double(:bar) }
          let(:bar_class) { double(:bar_class) }
          let(:some_number) { double(:some_number) }
          let(:some_number_class) { double(:some_number_class) }
          let(:fruit) { double(:fruit) }
          let(:fruit_class) { double(:fruit_class) }

          let(:mapping) {{
            sooper_foo: SooperFoo,
            bar: Bar,
            some_number: SomeNumber,
            fruit: Fruit,
            other_foo: OtherFoo
          }}

          before do
            allow(sooper_foo_class).to receive(:new).and_return(sooper_foo)
            allow(other_foo_class).to receive(:new).and_return(other_foo)
            allow(bar_class).to receive(:new).and_return(bar)
            allow(some_number_class).to receive(:new).and_return(some_number)
            allow(fruit_class).to receive(:new).and_return(fruit)
            stub_const('SooperFoo', sooper_foo_class)
            stub_const('Bar', bar_class)
            stub_const('SomeNumber', some_number_class)
            stub_const('Fruit', fruit_class)
            stub_const('SooperFoo', sooper_foo_class)
            stub_const('OtherFoo', other_foo_class)
          end

          it 'instantiates bar with three strings' do
            expect(Bar).to receive(:new).with(['takes', 'three', 'strings'])
            parser.parse(yaml)
          end

          it 'instantiates sooper foo with bar, some number and an array' do
            expect(SooperFoo).to receive(:new).with(
              [
                [1, 2, 3],
                bar,
                some_number,
                other_foo
              ])
            parser.parse(yaml)
          end

          it 'instantiates SomeNumber with 17' do
            expect(SomeNumber).to receive(:new).with(17)
            parser.parse(yaml)
          end

          it 'instantiates fruit with three fruit' do
            expect(Fruit).to receive(:new).with(['apple', 'pear', 'plum'])
            parser.parse(yaml)
          end

          it 'instantiates OtherFoo with a hash of stuff' do
            expect(OtherFoo).to receive(:new).with({
              'purple' => true,
              'seven' => 8,
              'eight' => bar  
            })
            parser.parse(yaml)
          end

        end
      end
    end
  end
end
