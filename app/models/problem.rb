class Problem < ApplicationRecord
    has_one :spot
    has_many :logs
    has_many_attached :photos
end
