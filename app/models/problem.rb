class Problem < ApplicationRecord
    belongs_to :spot
    has_many :logs
end
