class Comment < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validates :content, :track_id, :user_id, presence: :true
end
