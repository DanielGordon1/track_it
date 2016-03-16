class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:soundcloud]

  mount_uploader :photo, PhotoUploader

  has_many :comments, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :first_name, :last_name, :username, presence: :true
  validates :username, uniqueness: :true

  def self.find_for_soundcloud_oauth(auth)
    where(uid: auth.uid).first_or_create do |user|
      # user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.token = auth.credentials.token
      user.city = auth.extra.raw_info.city
      user.username = auth.extra.raw_info.username
      user.photo = auth.extra.raw_info.avatar_url
      user.country = auth.extra.raw_info.country
      user.description = auth.extra.raw_info.description
      user.first_name = auth.extra.raw_info.first_name
      user.last_name = auth.extra.raw_info.last_name
      user.followers_count = auth.extra.raw_info.followers_count
      user.public_favorites_count = auth.extra.raw_info.public_favorites_count
      user.upload_seconds_left = auth.extra.raw_info.quota.upload_seconds_left
      user.uid = auth.uid
    end
  end

  private

  def email_required?
    false
  end
end
