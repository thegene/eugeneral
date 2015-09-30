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
  end
end