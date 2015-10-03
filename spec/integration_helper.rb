require_relative '../lib/eugeneral/commands/command'
require_relative '../lib/eugeneral/dsl/dsl'
require 'heredoc_unindent'

def command_file(file)
  File.open(File.join('spec', 'integration', 'command_lists', file)).read
end

def general_with_default_vocabulary(command_list)
  parser = Eugeneral::DSL::Parsers::YAML
  vocabulary = Eugeneral::DSL.default_vocabulary
  parser.new(vocabulary: vocabulary).parse(command_list) 
end