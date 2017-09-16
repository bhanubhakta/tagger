module Tagger
  class EntityTag
    def self.create_entity_tags(params)
      if params[:id].present?
        entity = Tagger.tagged_klass.constantize.find(params[:id])
        entity.update_attributes({ name: params[:name] || entity.name })
      else
        entity = Tagger.tagged_klass.constantize.create({ name: params[:name] })
      end

      if params[:tags]
        entity.tags.delete_all
        tag_params = JSON.parse(params[:tags])
        tags = []
        tag_params.flatten.each do |tag|
          tags << Tagger::Tag.find_or_create_by({ name: tag })
        end
        entity.update_attributes({ tags: tags })
      end
      entity
    end
  end
end