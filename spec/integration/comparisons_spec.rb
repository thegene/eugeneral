require 'integration_helper'

context 'Given a command list with comparison commands' do
  let(:command_list) {
    <<-YAML.unindent
      equal?:
        equal:
          - arg_number: 0
          - arg_number: 1
      not_equal?:
        not_equal:
          - arg_number: 0
          - arg_number: 1
      greater_than?:
        greater_than:
          - arg_name: :foo
          - arg_name: :bar
      greater_than_or_equal_to?:
        greater_than_or_equal_to:
          - arg_name: :foo
          - arg_name: :bar
      less_than?:
        less_than:
          - arg_name: :foo
          - arg_name: :bar
      less_than_or_equal_to?:
        less_than_or_equal_to:
          - arg_name: :foo
          - arg_name: :bar
      between_five_and_ten?:
        and:
          - less_than:
            - arg_number: 0
            - 10
          - greater_than:
            - arg_number: 0
            - 5
    YAML
  }

  context 'and a General using the default vocabulary' do
    let(:general) { general_with_default_vocabulary(command_list) }


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

    context 'when using the greater than or equal to command' do

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

      it 'finds foo: 2 is not less than bar: 1' do
        expect(general.less_than?(bar: 1, foo: 2)).to be(false)
      end

      it 'finds foo: 1 is less than bar: 2' do
        expect(general.less_than?(foo: 1, bar: 2)).to be(true)
      end
    end

    context 'when using the less than or equal to command' do

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

    context 'when using between five and ten command' do

      it 'finds 7 to be true' do
        expect(general.between_five_and_ten? 7).to be(true)
      end

      it 'finds 3 to be false' do
        expect(general.between_five_and_ten? 3).to be(false)
      end

      it 'finds 5 to be false' do
        expect(general.between_five_and_ten? 5).to be(false)
      end

      it 'finds 10 to be false' do
        expect(general.between_five_and_ten? 10).to be(false)
      end

      it 'finds 11 to be false' do
        expect(general.between_five_and_ten? 11).to be(false)
      end
    end
  end
end