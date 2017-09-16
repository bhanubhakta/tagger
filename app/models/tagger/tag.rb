module Tagger
  class Tag < ApplicationRecord
    has_many :entities_tags, dependent: :destroy, class_name: 'Tagger::EntitiesTag'
    validates :name, presence: true, uniqueness: true
  end
end
