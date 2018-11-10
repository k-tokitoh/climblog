class Log < ApplicationRecord
  validates :climbed_at, presence: true
  validates :status, presence: true  
  validates :comment, presence: true  
  
  belongs_to :user
  belongs_to :problem
  has_many_attached :photos
  
  has_many :like_relations, dependent: :destroy
  has_many :like_users, through: :like_relations, source: :user
end
