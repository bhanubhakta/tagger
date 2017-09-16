class AddColumnTaggableItToEntitiesTags < ActiveRecord::Migration[5.1]
  def change
    remove_column :tagger_entities_tags, :entity_id
    add_column :tagger_entities_tags, :taggable_id, :integer
    add_column :tagger_entities_tags, :taggable_type, :string
    add_index :tagger_entities_tags, :taggable_id
  end
end
