class Track < ActiveRecord::Base
  extend Enumerize

  enumerize :versions, in: [:sketch, :rough, :finale]

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :name, :genre, :version, :user_id, presence: :true
end
