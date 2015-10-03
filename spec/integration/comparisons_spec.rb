require 'integration_helper'

context 'Given a YAML file with comparison comands' do
  let(:parser) { Eugeneral::DSL::Parsers::YAML }
  let(:vocabulary) { Eugeneral::DSL.default_vocabulary }
  let(:general) { parser.new(vocabulary: vocabulary).parse(command_list) }

  context 'when using the equals command' do
    let(:command_list) {
      <<-YAML.unindent
        equal?:
          equal:
            - arg_number: 0
            - arg_number: 1
      YAML
    }

    it 'finds 1 is equal to 1' do
      expect(general.equal?(1, 1)).to be(true)
    end

    it 'finds foo is not equal to bar' do
      expect(general.equal?(:foo, :bar)).to be(false)
    end
  end

  context 'when using the not equals command' do
    let(:command_list) {
      <<-YAML.unindent
        not_equal?:
          not_equal:
            - arg_number: 0
            - arg_number: 1
      YAML
    }

    it 'finds 1 is not not equal to 1' do
      expect(general.not_equal?(1, 1)).to be(false)
    end

    it 'finds foo is not equal to bar' do
      expect(general.not_equal?(:foo, :bar)).to be(true)
    end
  end

  context 'when using the greater than command' do
    let(:command_list) {
      <<-YAML.unindent
        greater_than?:
          greater_than:
            - arg_name: :foo
            - arg_name: :bar
      YAML
    }

    it 'finds foo: 2 is greater than bar: 1' do
      expect(general.greater_than?(bar: 1, foo: 2)).to be(true)
    end

    it 'finds foo: 1 is not greater than bar: 2' do
      expect(general.greater_than?(foo: 1, bar: 2)).to be(false)
    end
  end

  context 'when using the greater than or equal to command' do
    let(:command_list) {
      <<-YAML.unindent
        greater_than_or_equal_to?:
          greater_than_or_equal_to:
            - arg_name: :foo
            - arg_name: :bar
      YAML
    }

    it 'finds foo: 2 is greater than bar: 1' do
      expect(general.greater_than_or_equal_to?(bar: 1, foo: 2)).to be(true)
    end

    it 'finds foo: 1 is not greater than bar: 2' do
      expect(general.greater_than_or_equal_to?(foo: 1, bar: 2)).to be(false)
    end

    it 'finds foo: 1 is equal to bar: 1' do
      expect(general.greater_than_or_equal_to?(foo: 1, bar: 1)).to be(true)
    end
  end

  context 'when using the less than command' do
    let(:command_list) {
      <<-YAML.unindent
        less_than?:
          less_than:
            - arg_name: :foo
            - arg_name: :bar
      YAML
    }

    it 'finds foo: 2 is not less than bar: 1' do
      expect(general.less_than?(bar: 1, foo: 2)).to be(false)
    end

    it 'finds foo: 1 is less than bar: 2' do
      expect(general.less_than?(foo: 1, bar: 2)).to be(true)
    end
  end

  context 'when using the less than or equal to command' do
    let(:command_list) {
      <<-YAML.unindent
        less_than_or_equal_to?:
          less_than_or_equal_to:
            - arg_name: :foo
            - arg_name: :bar
      YAML
    }

    it 'finds foo: 2 is not less than bar: 1' do
      expect(general.less_than_or_equal_to?(bar: 1, foo: 2)).to be(false)
    end

    it 'finds foo: 1 is less than bar: 2' do
      expect(general.less_than_or_equal_to?(foo: 1, bar: 2)).to be(true)
    end

    it 'finds foo: 1 is equal to bar: 1' do
      expect(general.less_than_or_equal_to?(foo: 1, bar: 1)).to be(true)
    end
  end
end