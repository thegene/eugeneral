require_relative 'eugeneral/version'
require_relative 'eugeneral/command'

module Eugeneral
  def self.require_sub_module(name)
    submodules_for(name).each do |file|
      require_relative file
    end
  end

  private

  def self.submodules_for(name)
    Dir[
      File.join(
        File.expand_path(File.dirname(__FILE__)),
        'eugeneral', 
        name,
        '*.rb')
    ]
  end
end
