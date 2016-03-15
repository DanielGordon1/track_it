class Track < ActiveRecord::Base
  belongs_to :user

  validates :name, :genre, :version, :user_id, presence: :true

end
