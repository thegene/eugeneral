require 'integration_helper'

context 'Given a command list with logic commands' do
  let(:command_list) {
    <<-YAML.unindent
      all_of_these?:
        and:
          - arg_number: 0
          - arg_number: 1
          - arg_number: 2
      one_of_these?:
        or:
          - arg_name: first
          - arg_name: second
      the_opposite_of:
        not:
          default_arg_number: [0, true]
      usually_false:
        not:
          default_arg_name: [sometimes, true]
    YAML
  }

  context 'and a General with the default vocabulary' do
    let(:general) { general_with_default_vocabulary(command_list) }

    context 'when using the And command' do
      context 'when all are true' do

        it 'finds all of them to be true' do
          expect(general.all_of_these?(true, true, true)).to be(true)
        end
      end

      context 'when one is false' do

        it 'finds the combination to be false' do
          expect(general.all_of_these?(true, false, true)).to be(false)
        end
      end

      context 'when all are false' do
        
        it 'finds the combination to be false' do
          expect(general.all_of_these?(false, false, false)).to be(false)
        end
      end
    end

    context 'when using the Or command' do
      context 'when all are true' do

        it 'finds the combination to be true' do
          expect(general.one_of_these?(first: true, second: true)).to be(true)
        end
      end

      context 'when one is true' do

        it 'finds the combination to be true' do
          expect(general.one_of_these?(second: true, first: false)).to be(true)
        end
      end

      context 'when both are false' do

        it 'finds the combination to be false' do
          expect(general.one_of_these?(first: false, second: false)).to be(false)
        end
      end
    end

    context 'when using the Not command' do
      context 'with positional arguments' do

        context 'when using the default argument value' do
          it 'resolves to false' do
            expect(general.the_opposite_of).to be(false)
          end
        end

        context 'without a default value' do
          context 'which is true' do
            it 'find false to be the opposite of false' do
              expect(general.the_opposite_of(true)).to be(false)
            end
          end

          context 'which is false' do
            it 'finds false to be the opposite of false' do
              expect(general.the_opposite_of(false)).to be(true)
            end
          end
        end
      end

      context 'with named arguments' do
        context 'with a default argument value' do
          pending
        end

        context 'without a default value' do
          pending
        end
      end

    end
  end
end