class CreateTaggerTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tagger_tags do |t|
      t.string :name

      t.timestamps
    end
  end
end
