module Tagger
  class EntitiesTag < ApplicationRecord
    belongs_to :taggable, polymorphic: true
    belongs_to :tag
    validates_uniqueness_of :tag_id, scope: [:taggable_id]
  end
end
