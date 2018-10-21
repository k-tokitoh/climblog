class Log < ApplicationRecord
    has_one :user
    has_one :problem
end
