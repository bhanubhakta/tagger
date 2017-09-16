module Tagger
  class Tag < ApplicationRecord
    has_many :entities_tags
    validates :name, presence: true, uniqueness: true
  end
end
