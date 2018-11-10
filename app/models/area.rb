class Area < Spot
    has_many :outdoor_problems, dependent: :destroy
    
    validates :region, presence: true
end
