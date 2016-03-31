class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  # mount_uploader :photo, PhotoUploader

  has_many :comments, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :username, presence: :true
  validates :username, uniqueness: :true

  def self.find_for_soundcloud_oauth(auth)
    uid = auth[:infos].id

    user = where(uid: uid).first_or_initialize do |user|
      user.uid = uid
      user.password = Devise.friendly_token[0,20] # Fake password for validation
    end

    # credentials
    user.token = auth[:credentials].access_token
    user.refresh_token = auth[:credentials].refresh_token
    user.token_expires_at = Time.current + auth[:credentials].expires_in.seconds

    # user infos
    user.city = auth[:infos].city
    user.username = auth[:infos].username
    user.photo_url = auth[:infos].avatar_url
    user.country = auth[:infos].country
    user.description = auth[:infos].description
    user.first_name = auth[:infos].first_name
    user.last_name = auth[:infos].last_name
    user.followers_count = auth[:infos].followers_count
    user.public_favorites_count = auth[:infos].public_favorites_count
    user.upload_seconds_left = auth[:infos].quota.upload_seconds_left
    # user.email = "#{user.username}@gmail.com" # WAT

    user.save

    return user
  end

  private

  def email_required?
    false
  end
end
