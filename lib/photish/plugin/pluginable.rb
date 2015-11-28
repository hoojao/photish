require 'photish/plugin/type'
require 'photish/plugin/repository'

module Photish
  module Plugin
    module Pluginable
      def initialize(*args)
        Photish::Plugin::Repository.plugins_for(self.plugin_type).each do |moduol|
          self.class.send(:include, moduol)
        end
      end
    end
  end
end