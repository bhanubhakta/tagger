require "tagger/engine"

module Tagger
  mattr_accessor :tagged_resource
  mattr_accessor :tagged_klass
  mattr_accessor :association

  if defined? ActiveRecord::Base
    # require taggable
    require 'tagger/taggable'
    require 'tagger/route_mounter'

    # make acts_as_taggable class method for any class inheriting ActiveRecord::Base
    ActiveRecord::Base.send :extend, Tagger::Taggable
  end

  def self.set_tagged_klass(klass)
    klass.camelize.constantize
    Tagger.tagged_resource = klass.pluralize
  end
end
