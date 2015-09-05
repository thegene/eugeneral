require_relative '../lib/eugeneral/commands/command'
require_relative '../lib/eugeneral/dsl/dsl'

def command_file(file)
  File.open(File.join('spec', 'integration', 'command_lists', file)).read
end