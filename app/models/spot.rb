class Spot < ApplicationRecord
    has_many :problems, dependent: :destroy
    
    validates :name, presence: true
    validates :type, presence: true
end
