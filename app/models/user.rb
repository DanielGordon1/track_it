class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :comments, dependent: :destroy
  has_many :tracks, dependent: :destroy
  has_many :votes, dependent: :destroy

  validates :first_name, :last_name, :username, presence: :true
  validates :username, uniqueness: :true
end
