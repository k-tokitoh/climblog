class Problem < ApplicationRecord
    belongs_to :spot
    has_many :logs, dependent: :destroy
    
    validates :grade, presence: true
    validates :type, presence: true
end
