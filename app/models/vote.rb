class Vote < ActiveRecord::Base
  belongs_to :track
  belongs_to :user

  validates :track_id, :user_id, presence: :true
end
