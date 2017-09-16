module Tagger
  class EntityTag
    def self.create_entity_tags(params)
      tags = []
      tag_params = []
      tag_params << JSON.parse(params[:tags]) if params[:tags].present?
      if params[:id].present?
        entity = Tagger.tagged_klass.constantize.find(params[:id])
        entity.update({name: params[:name]})
        entity.tags.delete_all
      else
        entity = Tagger.tagged_klass.constantize.create({ name: params[:name] })
      end
      tag_params.flatten.each do |tag|
        tag = Tagger::Tag.create({ name: tag })
        entity_key = tag.send(Tagger.association).present? || Tagger.association
        tag.update({"#{entity_key}": [entity]})
        tags << tag
      end
      entity.update({ tags: tags })
      [entity, tags]
    end
  end
end