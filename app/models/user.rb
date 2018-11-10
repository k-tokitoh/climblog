class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }  

  has_secure_password
  has_many :logs, dependent: :destroy
  
  # 第一引数: 関連付け名（任意。規約では関連付けるテーブル名）('User.第一引数'が使えるようになる。)
  # class_name: 関連付けるテーブル名
  # foreign_key: 関連付けるテーブルのどのカラムの値がこのモデルのidと等しいときにデータをもってくればよいか
  has_many :following_relations, class_name: 'FollowRelation', foreign_key: 'following_id', dependent: :destroy
  # through: 経由する関連付けの名前(User.through)
  # source: 経由する関連付けにより参照したテーブルの、どの関連付けを利用するか
  has_many :followings, through: :following_relations, source: :followed
  
  has_many :followed_relations, class_name: 'FollowRelation', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :followed_relations, source: :following
  
  def follow(other_user)
    unless self == other_user
      self.following_relations.find_or_create_by(following_id: self.id, followed_id: other_user.id)
    end
  end

  def unfollow(other_user)
    following_relation = self.following_relations.find_by(followed_id: other_user.id)
    following_relation.destroy if following_relation
  end

  def follow?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Log.where(user_id: self.following_ids + [self.id])
  end
  
  def feed_like_microposts
    self.like_logs.where(user_id: self.following_ids + [self.id])
  end
  
  has_many :like_relations, dependent: :destroy
  has_many :like_logs, through: :like_relations, source: :log
  
  def like(log)
    # 自身のpostをlikeすることは可能とする
    self.like_relations.find_or_create_by(log_id: log.id)
  end
  
  def unlike(log)
    like_relation = self.like_relations.find_by(log_id: log.id)
    like_relation.destroy if like_relation
  end
  
  def like?(log)
    self.like_logs.include?(log)
  end
end
