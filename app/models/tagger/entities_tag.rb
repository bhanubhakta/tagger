module Tagger
  class EntitiesTag < ApplicationRecord
    belongs_to :taggable, polymorphic: true
    belongs_to :tag
  end
end
