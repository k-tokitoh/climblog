class OutdoorProblem < Problem
    has_one :area
    
    validates :name, presence: true
end
