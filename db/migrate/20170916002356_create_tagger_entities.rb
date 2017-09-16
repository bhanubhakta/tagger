class CreateTaggerEntities < ActiveRecord::Migration[5.1]
  def change
    create_table :tagger_entities do |t|
      t.string :name

      t.timestamps
    end
  end
end
