class LikeRelation < ApplicationRecord
  belongs_to :user
  belongs_to :log
end
