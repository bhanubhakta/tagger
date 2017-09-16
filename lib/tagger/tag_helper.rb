module Tagger
  module TagHelper
    extend ActiveSupport::Concern
    def acts_as_tag
      Tagger.association = Tagger.tagged_klass.split('::').last.downcase.pluralize.to_sym
      has_many Tagger.association, through: :entities_tags,
        source: :taggable, source_type: Tagger.tagged_klass
    end

    # Public: Preparing summary for the tags.
    #
    # Examples
    #
    #   summary
    #
    # Returns the summary of the tags.
    def summary
      result = []
      all.each do |tag|
        taggables = tag.send(Tagger.association)
        klass_name = Tagger.association.to_s.singularize
        result << {
          id: tag.id,
          name: tag.name,
          "#{klass_name}_count": taggables.count,
          "#{klass_name}_ids": taggables.map(&:id)
        }
      end
      result
    end
  end
end
