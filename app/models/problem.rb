class Problem < ApplicationRecord
    belongs_to :spot
    has_many :logs
    has_many_attached :photos
end
