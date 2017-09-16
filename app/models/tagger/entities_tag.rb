module Tagger
  class EntitiesTag < ApplicationRecord
    belongs_to :taggable, polymorphic: true
    belongs_to :tag
    validates_uniqueness_of :tag_id, scope: [:taggable_id]
    after_destroy :check_and_destroy_tags

    private
      # delete orphand tags
      def check_and_destroy_tags
        self.tag.delete if self.tag.send(Tagger.association).count.zero?
      end
  end
end
