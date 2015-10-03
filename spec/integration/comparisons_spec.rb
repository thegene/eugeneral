require 'integration_helper'

context 'Given a YAML file with comparison comands' do
  let(:command_list) { command_file('comparisons.yml') }
  let(:parser) { Eugeneral::DSL::Parsers::YAML }
  let(:vocabulary) { Eugeneral::DSL.default_vocabulary }
  let(:general) { parser.new(vocabulary: vocabulary).parse(command_list) }

  context 'when using the equals command' do

    it 'finds 1 is equal to 1' do
      expect(general.equal?(1, 1)).to be(true)
    end

    it 'finds foo is not equal to bar' do
      expect(general.equal?(:foo, :bar)).to be(false)
    end
  end

  context 'when using the not equals command' do

    it 'finds 1 is not not equal to 1' do
      expect(general.not_equal?(1, 1)).to be(false)
    end

    it 'finds foo is not equal to bar' do
      expect(general.not_equal?(:foo, :bar)).to be(true)
    end
  end

  context 'when using the greater than command' do

    it 'finds foo: 2 is greater than bar: 1' do
      expect(general.greater_than?(bar: 1, foo: 2)).to be(true)
    end

    it 'finds foo: 1 is not greater than bar: 2' do
      expect(general.greater_than?(foo: 1, bar: 2)).to be(false)
    end
  end
end