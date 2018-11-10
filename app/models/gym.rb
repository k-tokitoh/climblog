class Gym < Spot
    has_many :indoor_problems, dependent: :destroy
    
    validates :prefecture, presence: true
    # validates :adress, presence: true
    validates :url, presence: true
    
end
