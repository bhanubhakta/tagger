require 'tagger/tag_helper'
module Tagger
  module Taggable
    extend ActiveSupport::Concern

    def acts_as_taggable
      has_many :entities_tags, as: :taggable, class_name: 'Tagger::EntitiesTag'
      has_many :tags, through: :entities_tags, class_name: 'Tagger::Tag'
      klass = ancestors.first
      Tagger.tagged_klass = klass.name
      Tagger::Tag.send :extend, Tagger::TagHelper
      Tagger::Tag.acts_as_tag
    end

    # Public: Preparing summary for the entities.
    #
    # Examples
    #
    #   summary
    #
    # Returns the summary of the entities.
    def summary
      result = []
      all.each do |entity|
        result << {
          id: entity.id,
          name: entity.name,
          tag_count: entity.tags.count,
          tag_ids: entity.tags.map(&:id)
        }
      end
      result
    end
  end
end
