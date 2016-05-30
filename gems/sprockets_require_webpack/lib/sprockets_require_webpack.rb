require 'sprockets'
require_relative 'sprockets_require_webpack/webpack_directive_processor'

if defined? Rails::Railtie
  module SprocketsRequireWebpack
    class Railtie < ::Rails::Railtie
      config.to_prepare do
        Sprockets.unregister_processor('application/javascript', Sprockets::DirectiveProcessor)
        Sprockets.register_processor('application/javascript', WebpackDirectiveProcessor)
      end
    end
  end
end