module Tagger
  class Engine < ::Rails::Engine
    isolate_namespace Tagger

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
