module Tagger
  class Tag < ApplicationRecord
    has_many :entities_tags
  end
end
