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
    end
  end
end