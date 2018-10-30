class Log < ApplicationRecord
    belongs_to :user
    belongs_to :problem
    has_many_attached :photos
end
