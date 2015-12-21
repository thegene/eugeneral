require_relative '../../lib/eugeneral/dsl/vocabulary'

describe Eugeneral::DSL::Vocabulary do
  context 'Given a DSL::Vocabulary' do
    let(:foo_class) { double(:foo_class) }
    let(:foo_instance) { double(:foo_instance) }
    subject(:vocabulary) { described_class.new(mapping) }

    before do
      stub_const('FooClass', foo_class)
      allow(foo_class).to receive(:new).and_return(foo_instance)
    end

    context 'with an empty mapping' do
      let(:mapping) { {} }

      it 'will not define anything' do
        expect(vocabulary.defines?(:foo)).to be(false)
      end

      it 'will just return the thing which was to be defined' do
        expect(vocabulary.define(:foo)).to be(:foo)
      end
    end

    context 'with a simple mapping' do
      let(:mapping) { { foo: FooClass } }

      context 'when defining a command' do

        context 'which is present in the mapping' do

          it 'defines :foo' do
            expect(subject.defines?(:foo)).to be(true)
          end

          context 'without sub commands' do
            before do
              expect(foo_class).to receive(:new).once.with(no_args)
            end

            it 'returns an instance of FooClass' do
              expect(vocabulary.define(:foo)).to be(foo_instance)
            end
          end

          context 'with sub commands' do
            before do
              expect(foo_class).to receive(:new).with('something', 1, 2)
            end

            it 'returns an instance of FooClass' do
              expect(vocabulary.define(:foo, ['something', 1, 2]))
                .to be(foo_instance)
            end
          end
        end

        context 'which is not present in the mapping' do

          it 'does not define :bar' do
            expect(subject.defines?(:bar)).to be(false)
          end


          it 'will return that which is defined' do
            expect(vocabulary.define(:bar)).to be(:bar)
          end

        end

      end
    end

    context 'with a mapping with both strings and symbols' do
      let(:mapping) { { foo: FooClass, 'bar' => FooClass } }

      it 'will define a string which is mapped with a symbol' do
        expect(vocabulary.define('foo')).to be(foo_instance)
      end

      it 'will define a string which is mapped with a string' do
        expect(vocabulary.define('bar')).to be(foo_instance)
      end

      it 'will define a symbol which is mapped with a symbol' do
        expect(vocabulary.define(:bar)).to be(foo_instance)
      end

    end

    context 'with a complex mapping' do
      let(:apple_class) { double(:apple) }
      let(:pear_class) { double(:pear) }
      let(:peach_class) { double(:peach) }
      let(:plum_class) { double(:plum) }

      let(:apple_instance) { double(:apple_instance) }
      let(:pear_instance) { double(:pear_instance) }
      let(:peach_instance) { double(:peach_instance) }
      let(:plum_instance) { double(:plum_instance) }

      before do
        allow(apple_class).to receive(:new).and_return(apple_instance)
        allow(pear_class).to receive(:new).and_return(pear_instance)
        allow(peach_class).to receive(:new).and_return(peach_instance)
        allow(plum_class).to receive(:new).and_return(plum_instance)
      end

      let(:mapping) {{
        apple: apple_class,
        pear: pear_class,
        peach: peach_class,
        plum: plum_class
      }}

      it 'will instantiate apple' do
        expect(vocabulary.define(:apple)).to be(apple_instance)
      end

      it 'will instantiate pear' do
        expect(vocabulary.define(:pear)).to be(pear_instance)
      end

      it 'will instantiate peach' do
        expect(vocabulary.define(:peach)).to be(peach_instance)
      end

      it 'will instantiate plum' do
        expect(vocabulary.define(:plum)).to be(plum_instance)
      end

      context 'when adding to a single definition' do
        before do
          vocabulary[:other_plum] = plum_class
        end

        it 'will now find a definition for other_plum' do
          expect(vocabulary.defines?(:other_plum)).to be(true)
        end

        it 'will define other_plum as bar' do
          expect(vocabulary.define('other_plum')).to eq(plum_instance)
        end

        context 'which is already defined' do
          before do
            vocabulary[:pear] = apple_class
          end

          it 'will define using the new definition' do
            expect(vocabulary.define(:pear)).to eq(apple_instance)
          end
        end
      end

      context 'when merging multiple changes to the vocabulary' do
        before do
          vocabulary.merge!({
            new_thing: peach_class,
            apple: plum_class  
          })
        end

        it 'adds the new_thing' do
          expect(vocabulary.define('new_thing')).to eq(peach_instance)
        end

        it 'changes the old thing' do
          expect(vocabulary.define('apple')).to eq(plum_instance)
        end
      end
    end
  end
end
